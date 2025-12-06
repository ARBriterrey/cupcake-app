import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/supabase_config.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/models/calendar_event_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load environment variables
    await dotenv.load(fileName: '.env');

    // Initialize Hive for local storage
    await Hive.initFlutter();

    // Register Hive adapters
    Hive.registerAdapter(CalendarEventLocalAdapter());

    // Open Hive boxes
    await Hive.openBox<CalendarEventLocal>('calendar_events');

    // Initialize Supabase
    await SupabaseConfig.initialize();

    // Run the app
    runApp(
      const ProviderScope(
        child: CupcakeApp(),
      ),
    );
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Initialization Error: $e'),
          ),
        ),
      ),
    );
  }
}

class CupcakeApp extends ConsumerWidget {
  const CupcakeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Cupcake',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
