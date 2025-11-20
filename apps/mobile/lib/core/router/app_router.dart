import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/auth/screens/sign_up_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/pairing/screens/pairing_screen.dart';
import '../../features/pairing/screens/send_invitation_screen.dart';
import '../providers/supabase_providers.dart';

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

      // If authenticated and trying to access auth route
      if (isAuthenticated && isAuthRoute) {
        return '/pairing';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/pairing',
        builder: (context, state) => const PairingScreen(),
      ),
      GoRoute(
        path: '/send-invitation',
        builder: (context, state) => const SendInvitationScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
});
