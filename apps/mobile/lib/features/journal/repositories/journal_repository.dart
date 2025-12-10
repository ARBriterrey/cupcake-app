import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/journal_entry.dart';

class JournalRepository {
  final SupabaseClient _supabase;

  JournalRepository(this._supabase);

  // All queries are RLS-protected, so we don't need to manually filter by pair_id usually,
  // but it's good practice for clarity.

  Future<List<JournalEntry>> getAllEntries() async {
    final response = await _supabase
        .from('journal_entries')
        .select()
        .eq('is_deleted', false)
        .order('created_at', ascending: false);

    return (response as List).map((json) => JournalEntry.fromJson(json)).toList();
  }

  Future<JournalEntry?> getEntryById(String id) async {
    final response = await _supabase
        .from('journal_entries')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return JournalEntry.fromJson(response);
  }

  Future<JournalEntry> createEntry(JournalEntry entry) async {
    // We convert the entry to JSON but let postgres handle timestamps for consistency if needed,
    // though our model provides them.
    final jsonMatches = entry.toJson();
    // Remove null fields to let defaults kick in or to avoid errors if needed
    jsonMatches.removeWhere((key, value) => value == null);

    final response = await _supabase
        .from('journal_entries')
        .insert(jsonMatches)
        .select()
        .single();

    return JournalEntry.fromJson(response);
  }

  Future<JournalEntry> updateEntry(JournalEntry entry) async {
    final jsonMatches = entry.toJson();
    // Don't update immutable fields like pair_id, created_by usually, but RLS handles checking.
    // Important: updated_at should be handled.
    
    final response = await _supabase
        .from('journal_entries')
        .update(jsonMatches)
        .eq('id', entry.id)
        .select()
        .single();

    return JournalEntry.fromJson(response);
  }

  Future<void> deleteEntry(String id) async {
    // We use soft delete via the database function to ensure safety and logic consistency
    await _supabase.rpc('soft_delete_journal_entry', params: {'p_entry_id': id});
  }
  
  Future<void> linkCalendarEvent(String entryId, String calendarEventId) async {
    await _supabase
        .from('journal_entries')
        .update({'calendar_event_id': calendarEventId})
        .eq('id', entryId);
  }

  /// Real-time stream (optional usage, providers often use polling or dedicated sync logic)
  Stream<List<JournalEntry>> streamEntries() {
    return _supabase
        .from('journal_entries')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((json) => JournalEntry.fromJson(json)).toList());
  }
}
