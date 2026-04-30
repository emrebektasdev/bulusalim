import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/community/presentation/pages/community_detail_page.dart';
import '../../features/create/presentation/pages/create_community_page.dart';
import '../../features/create/presentation/pages/create_page.dart';
import '../../features/create/presentation/pages/create_event_page.dart';
import '../../features/event/presentation/pages/event_detail_page.dart';
import '../../features/explore/presentation/pages/explore_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/profile_setup_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../shared/presentation/widgets/main_shell.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _exploreNavigatorKey = GlobalKey<NavigatorState>();
final _createNavigatorKey = GlobalKey<NavigatorState>();
final _notificationsNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

/// Converts the auth stream into a [Listenable] that GoRouter can use
/// to trigger re-evaluation of its redirect callback.
class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Stream<User?> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }
  late final StreamSubscription<User?> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

/// Routes that do not require authentication.
const _publicRoutes = ['/', '/onboarding', '/auth'];

@riverpod
GoRouter router(Ref ref) {
  final authStream = FirebaseAuth.instance.authStateChanges();
  final refreshListenable = _AuthChangeNotifier(authStream);

  ref.onDispose(() => refreshListenable.dispose());

  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final location = state.matchedLocation;
      final isPublic = _publicRoutes.contains(location);

      // 1. Still on splash — let it show briefly.
      if (location == '/') return null;

      // 2. Not signed in → send to /auth.
      if (user == null) {
        return isPublic ? null : '/auth';
      }

      // 3. Signed in but on a public page → send to home.
      if (isPublic) {
        return '/home';
      }

      // 4. Otherwise, allow navigation.
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _exploreNavigatorKey,
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExplorePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _createNavigatorKey,
            routes: [
              GoRoute(
                path: '/create',
                builder: (context, state) => const CreatePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _notificationsNavigatorKey,
            routes: [
              GoRoute(
                path: '/notifications',
                builder: (context, state) => const NotificationsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/create-community',
        builder: (context, state) => const CreateCommunityPage(),
      ),
      GoRoute(
        path: '/create-event',
        builder: (context, state) {
          final communityId = state.uri.queryParameters['communityId'];
          return CreateEventPage(communityId: communityId);
        },
      ),
      GoRoute(
        path: '/community/:id',
        builder: (context, state) =>
            CommunityDetailPage(communityId: state.pathParameters['id'] ?? ''),
      ),
      GoRoute(
        path: '/event/:id',
        builder: (context, state) =>
            EventDetailPage(eventId: state.pathParameters['id'] ?? ''),
      ),
    ],
  );
}
