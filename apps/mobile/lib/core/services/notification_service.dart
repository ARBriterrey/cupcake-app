import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../providers/supabase_providers.dart';

part 'notification_service.g.dart';

@riverpod
NotificationService notificationService(NotificationServiceRef ref) {
  return NotificationService(ref);
}

class NotificationService {
  final Ref _ref;

  NotificationService(this._ref);

  Future<void> initialize() async {
    // 1. Initialize Firebase
    try {
      await Firebase.initializeApp();
    } catch (e) {
      // Ignore if already initialized or checking logic
      print('Firebase Init Check: $e');
    }

    // 2. Request Permissions
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 3. Get Token and Save
      final token = await messaging.getToken();
      if (token != null) {
        await _updateToken(token);
      }

      // 4. Listen for Token Refresh
      messaging.onTokenRefresh.listen(_updateToken);
      
      // 5. Setup message handlers (Foreground)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message while in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
          // TODO: Show local notification if needed, or rely on SnackBar updates from StreamProviders
        }
      });
    }
  }

  Future<void> _updateToken(String token) async {
    final currentUser = _ref.read(currentUserProvider);
    if (currentUser != null) {
      await _ref.read(userRepositoryProvider).updateProfile(
        userId: currentUser.id,
        fcmToken: token,
      );
      print('FCM Token updated for user ${currentUser.id}');
    }
  }
}
