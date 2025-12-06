import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_status.freezed.dart';

/// Represents the current state of calendar synchronization
@freezed
class SyncStatus with _$SyncStatus {
  const factory SyncStatus.idle() = _Idle;

  const factory SyncStatus.syncing({
    String? message,
  }) = _Syncing;

  const factory SyncStatus.synced({
    required DateTime lastSyncedAt,
    int? eventsSynced,
  }) = _Synced;

  const factory SyncStatus.error({
    required String message,
    DateTime? lastSyncedAt,
    int? retryCount,
  }) = _Error;
}
