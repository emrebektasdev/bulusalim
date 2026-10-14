# Firestore ve Storage yetkileri

Kurallar sahibi, üye ve katılımcıyı ayrı denetler. Sahiplik alanları istemciden devredilemez. Kullanıcı kendisine owner/moderator rolü veremez; özel topluluk ve onaylı etkinlik katılımı sahip onayı gerektirir. Üyelik/RSVP işlemlerinde sayaç değişikliği ilgili belgeyle aynı atomik işlemde yapılır. Sahip kendi topluluğunun/etkinliğinin üyelerini yönetebilir.

Kapak görsellerine yalnızca ilgili topluluk/etkinlik sahibi yazabilir. 5 MB JPEG/PNG/WebP sınırı vardır; diğer yollar kapalıdır.

Canlı kurallarda bulunan collection-group okuma, engellenen kullanıcılar, etkinlik onayları ve sohbet yolları korunmuştur. Sohbet mesajı gönderen kimliği doğrulanır. Topluluk/etkinlik metadatası ve üye/katılımcı listeleri giriş yapan kullanıcılara açıktır; özel üyelik gizli metadata anlamına gelmez.

Test:
```sh
cd security-tests
npm ci --ignore-scripts
cd ..
firebase emulators:exec --only firestore,storage --project demo-bulusalim-security "node --test security-tests/rules.test.cjs"
flutter test test/firestore_dates_test.dart
```

14 Ekim 2026'da yedi güvenlik senaryosu geçtikten sonra kurallar `bulusalim-d8713` projesine dağıtıldı. Sahiplerin üye ekleme/çıkarma işlemleri sayacı birer artırıp azaltabilir; sahiplerin kendi kaynaklarına ait sayaçları yönetmesi tasarımın parçasıdır. Moderasyon, ödeme veya ücretli haklar bu sayaçlara bağlanmamalıdır.

Sunucu tarihleri Timestamp olarak okunup yazılır. ISO tarih içeren eski kayıtlar okunabilir. Önceden yetkisiz değişiklik yapılıp yapılmadığı bu düzeltmeyle kanıtlanmaz; geçmiş veri bütünlüğü ayrıca incelenmelidir.
