import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/supabase_config.dart';
import 'package:cupcake_ui/ui.dart';
import 'core/router/app_router.dart';
import 'core/models/calendar_event_local.dart';
import 'features/journal/models/journal_entry_local.dart';
import 'features/journal/providers/journal_context_providers.dart';
import 'features/auth/providers/auth_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load environment variables
    await dotenv.load(fileName: '.env');

    // Initialize Hive for local storage
    await Hive.initFlutter();

    // Register Hive adapters
    Hive.registerAdapter(CalendarEventLocalAdapter());
    Hive.registerAdapter(JournalEntryLocalAdapter());

    // Open Hive boxes
    await Hive.openBox<CalendarEventLocal>('calendar_events');
    await Hive.openBox<JournalEntryLocal>('journal_entries');

    // Initialize Supabase
    await SupabaseConfig.initialize();

    // Run the app
    runApp(
      ProviderScope(
        overrides: [
          // Override journal context providers with actual auth data
          journalContextUserIdProvider.overrideWith((ref) {
            final user = ref.watch(currentUserProvider);
            return user?.id ?? '';
          }),
          journalContextPairIdProvider.overrideWith((ref) {
            final userProfile = ref.watch(currentUserProfileProvider).value;
            return userProfile?.activePairId ?? '';
          }),
        ],
        child: const CupcakeApp(),
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
      theme: CupcakeTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
