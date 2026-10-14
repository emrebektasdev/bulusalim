const { test, before, after, beforeEach } = require('node:test');
const fs = require('node:fs'); const path = require('node:path');
const { initializeTestEnvironment, assertFails, assertSucceeds } = require('@firebase/rules-unit-testing');
const { doc, setDoc, updateDoc, deleteDoc, getDoc, writeBatch, serverTimestamp, increment } = require('firebase/firestore');
const { ref, uploadBytes } = require('firebase/storage');
let env;
const db = uid => env.authenticatedContext(uid).firestore();
const community = { ownerId: 'owner', name: 'Community', description: '', category: 'General', memberCount: 1, isPrivate: false, isDeleted: false, createdAt: serverTimestamp() };
const event = { organizerId: 'owner', title: 'Event', description: '', attendeeCount: 1, capacity: 2, isDeleted: false, communityId: null, createdAt: serverTimestamp() };
const member = (uid, role = 'member') => ({ uid, role, joinedAt: serverTimestamp() });
const attendee = (uid, status = 'going') => ({ uid, status, joinedAt: serverTimestamp() });
before(async () => {
 env = await initializeTestEnvironment({ projectId: 'demo-bulusalim-security',
 firestore: { rules: fs.readFileSync(path.join(__dirname, '..', 'firestore.rules'), 'utf8') },
 storage: { rules: fs.readFileSync(path.join(__dirname, '..', 'storage.rules'), 'utf8') } });
});
beforeEach(async () => {
 await env.clearFirestore(); await env.clearStorage();
 await env.withSecurityRulesDisabled(async c => {
  await setDoc(doc(c.firestore(), 'communities/c1'), community);
  await setDoc(doc(c.firestore(), 'communities/private'), { ...community, isPrivate: true });
  await setDoc(doc(c.firestore(), 'communities/c1/members/owner'), member('owner','owner'));
  await setDoc(doc(c.firestore(), 'events/e1'), event);
  await setDoc(doc(c.firestore(), 'events/e1/attendees/owner'), attendee('owner'));
 });
});
after(async () => env.cleanup());
function join(uid, id='c1', role='member', amount=1) {
 const d=db(uid), b=writeBatch(d);b.set(doc(d,'communities/'+id+'/members/'+uid),member(uid,role));
 b.update(doc(d,'communities/'+id),{memberCount:increment(amount)});return b.commit();
}
function rsvp(uid,status='going',amount=1,id='e1') {
 const d=db(uid), b=writeBatch(d);b.set(doc(d,'events/'+id+'/attendees/'+uid),attendee(uid,status));
 if(amount)b.update(doc(d,'events/'+id),{attendeeCount:increment(amount)});return b.commit();
}
test('owner creation is atomic and identities cannot be spoofed or reassigned', async () => {
 const d=db('owner'), b=writeBatch(d);b.set(doc(d,'communities/new'),community);b.set(doc(d,'communities/new/members/owner'),member('owner','owner'));
 await assertSucceeds(b.commit());
 await assertFails(setDoc(doc(db('attacker'),'communities/forged'),community));
 await assertFails(updateDoc(doc(db('attacker'),'communities/c1'),{ownerId:'attacker'}));
 await assertFails(updateDoc(doc(d,'communities/c1'),{ownerId:'attacker'}));
 await assertSucceeds(updateDoc(doc(d,'communities/c1'),{name:'New name'}));
 await assertFails(updateDoc(doc(db('attacker'),'events/e1'),{organizerId:'attacker'}));
 const e=writeBatch(d);e.set(doc(d,'events/new'),event);e.set(doc(d,'events/new/attendees/owner'),attendee('owner'));
 await assertSucceeds(e.commit());
});
test('public join and leave keep exact counts; self promotion and forged counts fail', async () => {
 await assertFails(join('alice','c1','owner'));
 await assertFails(join('alice','c1','member',50));
 await assertFails(setDoc(doc(db('alice'),'communities/c1/members/alice'),member('alice')));
 await assertSucceeds(join('alice'));
 await assertFails(updateDoc(doc(db('alice'),'communities/c1/members/alice'),{role:'moderator'}));
 await assertFails(updateDoc(doc(db('alice'),'communities/c1'),{memberCount:99}));
 const d=db('alice'), b=writeBatch(d);b.delete(doc(d,'communities/c1/members/alice'));b.update(doc(d,'communities/c1'),{memberCount:increment(-1)});
 await assertSucceeds(b.commit());
 await assertFails(deleteDoc(doc(db('owner'),'communities/c1/members/owner')));
});
test('private join requires an owner-approved request; requester cannot approve themselves', async () => {
 await assertFails(join('alice','private'));
 const p='communities/private/joinRequests/alice';
 await assertSucceeds(setDoc(doc(db('alice'),p),{uid:'alice',status:'pending',requestedAt:serverTimestamp()}));
 await assertFails(updateDoc(doc(db('alice'),p),{status:'approved'}));
 await assertFails(getDoc(doc(db('bob'),p)));
 await assertSucceeds(updateDoc(doc(db('owner'),p),{status:'approved'}));
 await assertSucceeds(join('alice','private'));
});
test('RSVP transactions enforce capacity, exact deltas and attendee identity', async () => {
 await assertFails(setDoc(doc(db('alice'),'events/e1/attendees/alice'),attendee('alice')));
 await assertFails(rsvp('alice','going',20));
 await assertSucceeds(rsvp('alice'));
 await assertFails(rsvp('bob'));
 await assertFails(setDoc(doc(db('bob'),'events/e1/attendees/alice'),attendee('bob')));
 await assertSucceeds(rsvp('alice','not_going',-1));
 await assertSucceeds(rsvp('bob'));
 await assertFails(updateDoc(doc(db('bob'),'events/e1'),{title:'Taken over'}));
});
test('approval-required events cannot be entered directly', async () => {
 await env.withSecurityRulesDisabled(c=>setDoc(doc(c.firestore(),'events/approval'),{...event,joinType:'approvalRequired'}));
 await assertFails(rsvp('alice','going',1,'approval'));
 const p='events/approval/joinRequests/alice';
 await assertSucceeds(setDoc(doc(db('alice'),p),{uid:'alice',status:'pending',requestedAt:serverTimestamp()}));
 await assertFails(updateDoc(doc(db('alice'),p),{status:'approved'}));
 await assertSucceeds(updateDoc(doc(db('owner'),p),{status:'approved'}));
 await assertSucceeds(rsvp('alice','going',1,'approval'));
});
test('chat requires participation and binds sender identity', async () => {
 const message={senderUid:'alice',senderName:'Alice',text:'Hello',createdAt:serverTimestamp()};
 await assertFails(setDoc(doc(db('alice'),'events/e1/chatMessages/m1'),message));
 await assertSucceeds(rsvp('alice'));
 await assertFails(setDoc(doc(db('alice'),'events/e1/chatMessages/m1'),{...message,senderUid:'owner'}));
 await assertSucceeds(setDoc(doc(db('alice'),'events/e1/chatMessages/m1'),message));
 await assertFails(getDoc(doc(db('bob'),'events/e1/chatMessages/m1')));
});
test('Storage allows only the matching community/event owner and image content', async () => {
 const upload=(uid,p,type='image/jpeg')=>uploadBytes(ref(env.authenticatedContext(uid).storage(),p),new Uint8Array([1]),{contentType:type});
 await assertSucceeds(upload('owner','communities/c1/cover.jpg'));
 await assertFails(upload('bob','communities/c1/cover.jpg'));
 await assertSucceeds(upload('owner','events/e1/cover.jpg'));
 await assertFails(upload('bob','events/e1/cover.jpg'));
 await assertFails(upload('owner','events/e1/cover.jpg','text/html'));
 await assertFails(upload('owner','unknown/file.jpg'));
});
