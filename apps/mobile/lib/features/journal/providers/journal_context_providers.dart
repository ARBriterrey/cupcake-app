import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the current User ID, intended to be overridden by the main app.
final journalContextUserIdProvider = Provider<String>((ref) {
  throw UnimplementedError('journalContextUserIdProvider must be overridden');
});

/// Provider for the current Pair ID, intended to be overridden by the main app.
final journalContextPairIdProvider = Provider<String>((ref) {
  throw UnimplementedError('journalContextPairIdProvider must be overridden');
});
