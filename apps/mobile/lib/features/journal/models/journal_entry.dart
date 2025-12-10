import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cupcake_core/core.dart';

part 'journal_entry.freezed.dart';
part 'journal_entry.g.dart';

@freezed
class JournalEntry with _$JournalEntry {
  const JournalEntry._();

  const factory JournalEntry({
    required String id,
    @JsonKey(name: 'pair_id') required String pairId,
    @JsonKey(name: 'created_by') String? createdBy,
    
    required String title,
    required String body,
    
    @Default(EventVisibility.private) EventVisibility visibility,
    @JsonKey(name: 'visible_to_user_id') String? visibleToUserId,
    
    @Default([]) List<String> tags,
    String? mood,
    
    @JsonKey(name: 'calendar_event_id') String? calendarEventId,
    
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
    @JsonKey(name: 'deleted_by') String? deletedBy,
  }) = _JournalEntry;

  factory JournalEntry.fromJson(Map<String, dynamic> json) => 
      _$JournalEntryFromJson(json);
      
  /// Check if the entry is owned by the specific user
  bool isOwnedBy(String userId) {
    return createdBy == userId;
  }
  
  /// Check if the entry is visible to the specific user
  bool isVisibleTo(String userId) {
    if (visibility == EventVisibility.shared) return true;
    if (createdBy == userId) return true;
    if (visibleToUserId == userId) return true;
    return false;
  }
  
  /// Get a preview of the body text (approx 100 chars)
  String get bodyPreview {
    if (body.length <= 100) return body;
    return '${body.substring(0, 100)}...';
  }
}
