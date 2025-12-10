import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/auth/screens/sign_up_screen.dart';
import '../../features/calendar/screens/calendar_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/pairing/screens/pairing_screen.dart';
import '../../features/pairing/screens/send_invitation_screen.dart';
import '../../features/pairing/screens/send_invitation_screen.dart';
import '../../features/settings/screens/restore_events_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/sprinkles/screens/sprinkles_screen.dart';
import '../providers/supabase_providers.dart';
import 'navigation_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final supabase = ref.watch(supabaseClientProvider);

  return GoRouter(
    initialLocation: '/sign-in',
    redirect: (context, state) {
      final isAuthenticated = supabase.auth.currentSession != null;
      final isAuthRoute = state.matchedLocation.startsWith('/sign-in') ||
          state.matchedLocation.startsWith('/sign-up');

      // If not authenticated and trying to access protected route
      if (!isAuthenticated && !isAuthRoute) {
        return '/sign-in';
      }

      // If authenticated and trying to access auth route, go to pairing
      // Let pairing screen handle redirect to home if already paired
      if (isAuthenticated && isAuthRoute) {
        return '/pairing';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-in',
        name: 'sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        name: 'sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/pairing',
        name: 'pairing',
        builder: (context, state) => const PairingScreen(),
        routes: [
          GoRoute(
            path: 'send-invitation',
            name: 'send-invitation',
            builder: (context, state) => const SendInvitationScreen(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calendar',
                name: 'calendar',
                builder: (context, state) => const CalendarScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/sprinkles',
                name: 'sprinkles',
                builder: (context, state) => const SprinklesScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'restore-events',
            name: 'restore-events',
            builder: (context, state) => const RestoreEventsScreen(),
          ),
        ],
      ),
    ],
  );
});
