// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calendarRepositoryHash() =>
    r'60906eddc95e77b1e57fd226563fede30d3a1586';

/// Provides the CalendarRepository (for Supabase sync)
///
/// Copied from [calendarRepository].
@ProviderFor(calendarRepository)
final calendarRepositoryProvider =
    AutoDisposeProvider<CalendarRepository>.internal(
  calendarRepository,
  name: r'calendarRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$calendarRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CalendarRepositoryRef = AutoDisposeProviderRef<CalendarRepository>;
String _$monthlyEventsHash() => r'30e4624f957504d67882dd4c16d42b51f65df44c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Get events for a specific month (from local DB)
/// Filtered by active event type filters
///
/// Copied from [monthlyEvents].
@ProviderFor(monthlyEvents)
const monthlyEventsProvider = MonthlyEventsFamily();

/// Get events for a specific month (from local DB)
/// Filtered by active event type filters
///
/// Copied from [monthlyEvents].
class MonthlyEventsFamily extends Family<AsyncValue<List<CalendarEvent>>> {
  /// Get events for a specific month (from local DB)
  /// Filtered by active event type filters
  ///
  /// Copied from [monthlyEvents].
  const MonthlyEventsFamily();

  /// Get events for a specific month (from local DB)
  /// Filtered by active event type filters
  ///
  /// Copied from [monthlyEvents].
  MonthlyEventsProvider call({
    required int year,
    required int month,
  }) {
    return MonthlyEventsProvider(
      year: year,
      month: month,
    );
  }

  @override
  MonthlyEventsProvider getProviderOverride(
    covariant MonthlyEventsProvider provider,
  ) {
    return call(
      year: provider.year,
      month: provider.month,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'monthlyEventsProvider';
}

/// Get events for a specific month (from local DB)
/// Filtered by active event type filters
///
/// Copied from [monthlyEvents].
class MonthlyEventsProvider
    extends AutoDisposeFutureProvider<List<CalendarEvent>> {
  /// Get events for a specific month (from local DB)
  /// Filtered by active event type filters
  ///
  /// Copied from [monthlyEvents].
  MonthlyEventsProvider({
    required int year,
    required int month,
  }) : this._internal(
          (ref) => monthlyEvents(
            ref as MonthlyEventsRef,
            year: year,
            month: month,
          ),
          from: monthlyEventsProvider,
          name: r'monthlyEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthlyEventsHash,
          dependencies: MonthlyEventsFamily._dependencies,
          allTransitiveDependencies:
              MonthlyEventsFamily._allTransitiveDependencies,
          year: year,
          month: month,
        );

  MonthlyEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<List<CalendarEvent>> Function(MonthlyEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlyEventsProvider._internal(
        (ref) => create(ref as MonthlyEventsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CalendarEvent>> createElement() {
    return _MonthlyEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyEventsProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MonthlyEventsRef on AutoDisposeFutureProviderRef<List<CalendarEvent>> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _MonthlyEventsProviderElement
    extends AutoDisposeFutureProviderElement<List<CalendarEvent>>
    with MonthlyEventsRef {
  _MonthlyEventsProviderElement(super.provider);

  @override
  int get year => (origin as MonthlyEventsProvider).year;
  @override
  int get month => (origin as MonthlyEventsProvider).month;
}

String _$dailyEventsHash() => r'2d6d8da6a0e04083e9c1212a655d0740ceddf296';

/// Get events for a specific day (from local DB)
///
/// Copied from [dailyEvents].
@ProviderFor(dailyEvents)
const dailyEventsProvider = DailyEventsFamily();

/// Get events for a specific day (from local DB)
///
/// Copied from [dailyEvents].
class DailyEventsFamily extends Family<AsyncValue<List<CalendarEvent>>> {
  /// Get events for a specific day (from local DB)
  ///
  /// Copied from [dailyEvents].
  const DailyEventsFamily();

  /// Get events for a specific day (from local DB)
  ///
  /// Copied from [dailyEvents].
  DailyEventsProvider call(
    DateTime date,
  ) {
    return DailyEventsProvider(
      date,
    );
  }

  @override
  DailyEventsProvider getProviderOverride(
    covariant DailyEventsProvider provider,
  ) {
    return call(
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dailyEventsProvider';
}

/// Get events for a specific day (from local DB)
///
/// Copied from [dailyEvents].
class DailyEventsProvider
    extends AutoDisposeFutureProvider<List<CalendarEvent>> {
  /// Get events for a specific day (from local DB)
  ///
  /// Copied from [dailyEvents].
  DailyEventsProvider(
    DateTime date,
  ) : this._internal(
          (ref) => dailyEvents(
            ref as DailyEventsRef,
            date,
          ),
          from: dailyEventsProvider,
          name: r'dailyEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dailyEventsHash,
          dependencies: DailyEventsFamily._dependencies,
          allTransitiveDependencies:
              DailyEventsFamily._allTransitiveDependencies,
          date: date,
        );

  DailyEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<List<CalendarEvent>> Function(DailyEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DailyEventsProvider._internal(
        (ref) => create(ref as DailyEventsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CalendarEvent>> createElement() {
    return _DailyEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyEventsProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DailyEventsRef on AutoDisposeFutureProviderRef<List<CalendarEvent>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _DailyEventsProviderElement
    extends AutoDisposeFutureProviderElement<List<CalendarEvent>>
    with DailyEventsRef {
  _DailyEventsProviderElement(super.provider);

  @override
  DateTime get date => (origin as DailyEventsProvider).date;
}

String _$selectedDateEventsHash() =>
    r'546a15f033b7b694dc0520538cec4dc9fa83ef0d';

/// Get events for the currently selected date (from local DB)
/// Derives from monthly events to avoid redundant Hive query
/// Filtered by active event type filters (applied at monthly level)
///
/// Copied from [selectedDateEvents].
@ProviderFor(selectedDateEvents)
final selectedDateEventsProvider =
    AutoDisposeFutureProvider<List<CalendarEvent>>.internal(
  selectedDateEvents,
  name: r'selectedDateEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedDateEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectedDateEventsRef
    = AutoDisposeFutureProviderRef<List<CalendarEvent>>;
String _$todaysEventsHash() => r'8796101c48377a1d0eaa68d7504ffcba7d3754c1';

/// Get today's events (from local DB)
///
/// Copied from [todaysEvents].
@ProviderFor(todaysEvents)
final todaysEventsProvider =
    AutoDisposeFutureProvider<List<CalendarEvent>>.internal(
  todaysEvents,
  name: r'todaysEventsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todaysEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodaysEventsRef = AutoDisposeFutureProviderRef<List<CalendarEvent>>;
String _$upcomingEventsHash() => r'6d1e4f3d3cc5c5f93512621d0e214818ec87d93d';

/// Get upcoming events (next 30 days, from local DB)
///
/// Copied from [upcomingEvents].
@ProviderFor(upcomingEvents)
const upcomingEventsProvider = UpcomingEventsFamily();

/// Get upcoming events (next 30 days, from local DB)
///
/// Copied from [upcomingEvents].
class UpcomingEventsFamily extends Family<AsyncValue<List<CalendarEvent>>> {
  /// Get upcoming events (next 30 days, from local DB)
  ///
  /// Copied from [upcomingEvents].
  const UpcomingEventsFamily();

  /// Get upcoming events (next 30 days, from local DB)
  ///
  /// Copied from [upcomingEvents].
  UpcomingEventsProvider call({
    int limit = 10,
  }) {
    return UpcomingEventsProvider(
      limit: limit,
    );
  }

  @override
  UpcomingEventsProvider getProviderOverride(
    covariant UpcomingEventsProvider provider,
  ) {
    return call(
      limit: provider.limit,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'upcomingEventsProvider';
}

/// Get upcoming events (next 30 days, from local DB)
///
/// Copied from [upcomingEvents].
class UpcomingEventsProvider
    extends AutoDisposeFutureProvider<List<CalendarEvent>> {
  /// Get upcoming events (next 30 days, from local DB)
  ///
  /// Copied from [upcomingEvents].
  UpcomingEventsProvider({
    int limit = 10,
  }) : this._internal(
          (ref) => upcomingEvents(
            ref as UpcomingEventsRef,
            limit: limit,
          ),
          from: upcomingEventsProvider,
          name: r'upcomingEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$upcomingEventsHash,
          dependencies: UpcomingEventsFamily._dependencies,
          allTransitiveDependencies:
              UpcomingEventsFamily._allTransitiveDependencies,
          limit: limit,
        );

  UpcomingEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<CalendarEvent>> Function(UpcomingEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpcomingEventsProvider._internal(
        (ref) => create(ref as UpcomingEventsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CalendarEvent>> createElement() {
    return _UpcomingEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpcomingEventsProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpcomingEventsRef on AutoDisposeFutureProviderRef<List<CalendarEvent>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _UpcomingEventsProviderElement
    extends AutoDisposeFutureProviderElement<List<CalendarEvent>>
    with UpcomingEventsRef {
  _UpcomingEventsProviderElement(super.provider);

  @override
  int get limit => (origin as UpcomingEventsProvider).limit;
}

String _$eventsByTypeHash() => r'c87119b307180639ce1e90a3adb5d10668703d0c';

/// Get events by type (from local DB)
///
/// Copied from [eventsByType].
@ProviderFor(eventsByType)
const eventsByTypeProvider = EventsByTypeFamily();

/// Get events by type (from local DB)
///
/// Copied from [eventsByType].
class EventsByTypeFamily extends Family<AsyncValue<List<CalendarEvent>>> {
  /// Get events by type (from local DB)
  ///
  /// Copied from [eventsByType].
  const EventsByTypeFamily();

  /// Get events by type (from local DB)
  ///
  /// Copied from [eventsByType].
  EventsByTypeProvider call({
    required InvalidType eventType,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return EventsByTypeProvider(
      eventType: eventType,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  EventsByTypeProvider getProviderOverride(
    covariant EventsByTypeProvider provider,
  ) {
    return call(
      eventType: provider.eventType,
      startDate: provider.startDate,
      endDate: provider.endDate,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eventsByTypeProvider';
}

/// Get events by type (from local DB)
///
/// Copied from [eventsByType].
class EventsByTypeProvider
    extends AutoDisposeFutureProvider<List<CalendarEvent>> {
  /// Get events by type (from local DB)
  ///
  /// Copied from [eventsByType].
  EventsByTypeProvider({
    required InvalidType eventType,
    DateTime? startDate,
    DateTime? endDate,
  }) : this._internal(
          (ref) => eventsByType(
            ref as EventsByTypeRef,
            eventType: eventType,
            startDate: startDate,
            endDate: endDate,
          ),
          from: eventsByTypeProvider,
          name: r'eventsByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsByTypeHash,
          dependencies: EventsByTypeFamily._dependencies,
          allTransitiveDependencies:
              EventsByTypeFamily._allTransitiveDependencies,
          eventType: eventType,
          startDate: startDate,
          endDate: endDate,
        );

  EventsByTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventType,
    required this.startDate,
    required this.endDate,
  }) : super.internal();

  final InvalidType eventType;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Override overrideWith(
    FutureOr<List<CalendarEvent>> Function(EventsByTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsByTypeProvider._internal(
        (ref) => create(ref as EventsByTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventType: eventType,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CalendarEvent>> createElement() {
    return _EventsByTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsByTypeProvider &&
        other.eventType == eventType &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventType.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventsByTypeRef on AutoDisposeFutureProviderRef<List<CalendarEvent>> {
  /// The parameter `eventType` of this provider.
  InvalidType get eventType;

  /// The parameter `startDate` of this provider.
  DateTime? get startDate;

  /// The parameter `endDate` of this provider.
  DateTime? get endDate;
}

class _EventsByTypeProviderElement
    extends AutoDisposeFutureProviderElement<List<CalendarEvent>>
    with EventsByTypeRef {
  _EventsByTypeProviderElement(super.provider);

  @override
  InvalidType get eventType => (origin as EventsByTypeProvider).eventType;
  @override
  DateTime? get startDate => (origin as EventsByTypeProvider).startDate;
  @override
  DateTime? get endDate => (origin as EventsByTypeProvider).endDate;
}

String _$eventsByTagHash() => r'5cdb75795ec010beaaa6b5b2cc56c18e2216a23e';

/// Get events by tag (from local DB)
///
/// Copied from [eventsByTag].
@ProviderFor(eventsByTag)
const eventsByTagProvider = EventsByTagFamily();

/// Get events by tag (from local DB)
///
/// Copied from [eventsByTag].
class EventsByTagFamily extends Family<AsyncValue<List<CalendarEvent>>> {
  /// Get events by tag (from local DB)
  ///
  /// Copied from [eventsByTag].
  const EventsByTagFamily();

  /// Get events by tag (from local DB)
  ///
  /// Copied from [eventsByTag].
  EventsByTagProvider call(
    String tag,
  ) {
    return EventsByTagProvider(
      tag,
    );
  }

  @override
  EventsByTagProvider getProviderOverride(
    covariant EventsByTagProvider provider,
  ) {
    return call(
      provider.tag,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eventsByTagProvider';
}

/// Get events by tag (from local DB)
///
/// Copied from [eventsByTag].
class EventsByTagProvider
    extends AutoDisposeFutureProvider<List<CalendarEvent>> {
  /// Get events by tag (from local DB)
  ///
  /// Copied from [eventsByTag].
  EventsByTagProvider(
    String tag,
  ) : this._internal(
          (ref) => eventsByTag(
            ref as EventsByTagRef,
            tag,
          ),
          from: eventsByTagProvider,
          name: r'eventsByTagProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsByTagHash,
          dependencies: EventsByTagFamily._dependencies,
          allTransitiveDependencies:
              EventsByTagFamily._allTransitiveDependencies,
          tag: tag,
        );

  EventsByTagProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tag,
  }) : super.internal();

  final String tag;

  @override
  Override overrideWith(
    FutureOr<List<CalendarEvent>> Function(EventsByTagRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsByTagProvider._internal(
        (ref) => create(ref as EventsByTagRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tag: tag,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CalendarEvent>> createElement() {
    return _EventsByTagProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsByTagProvider && other.tag == tag;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tag.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventsByTagRef on AutoDisposeFutureProviderRef<List<CalendarEvent>> {
  /// The parameter `tag` of this provider.
  String get tag;
}

class _EventsByTagProviderElement
    extends AutoDisposeFutureProviderElement<List<CalendarEvent>>
    with EventsByTagRef {
  _EventsByTagProviderElement(super.provider);

  @override
  String get tag => (origin as EventsByTagProvider).tag;
}

String _$monthlyEventsStreamHash() =>
    r'f5e9a05abb72c348beec36e5202539bffa02e7cb';

/// Stream events for a specific month with real-time updates
///
/// Copied from [monthlyEventsStream].
@ProviderFor(monthlyEventsStream)
const monthlyEventsStreamProvider = MonthlyEventsStreamFamily();

/// Stream events for a specific month with real-time updates
///
/// Copied from [monthlyEventsStream].
class MonthlyEventsStreamFamily
    extends Family<AsyncValue<List<CalendarEvent>>> {
  /// Stream events for a specific month with real-time updates
  ///
  /// Copied from [monthlyEventsStream].
  const MonthlyEventsStreamFamily();

  /// Stream events for a specific month with real-time updates
  ///
  /// Copied from [monthlyEventsStream].
  MonthlyEventsStreamProvider call({
    required int year,
    required int month,
  }) {
    return MonthlyEventsStreamProvider(
      year: year,
      month: month,
    );
  }

  @override
  MonthlyEventsStreamProvider getProviderOverride(
    covariant MonthlyEventsStreamProvider provider,
  ) {
    return call(
      year: provider.year,
      month: provider.month,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'monthlyEventsStreamProvider';
}

/// Stream events for a specific month with real-time updates
///
/// Copied from [monthlyEventsStream].
class MonthlyEventsStreamProvider
    extends AutoDisposeStreamProvider<List<CalendarEvent>> {
  /// Stream events for a specific month with real-time updates
  ///
  /// Copied from [monthlyEventsStream].
  MonthlyEventsStreamProvider({
    required int year,
    required int month,
  }) : this._internal(
          (ref) => monthlyEventsStream(
            ref as MonthlyEventsStreamRef,
            year: year,
            month: month,
          ),
          from: monthlyEventsStreamProvider,
          name: r'monthlyEventsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthlyEventsStreamHash,
          dependencies: MonthlyEventsStreamFamily._dependencies,
          allTransitiveDependencies:
              MonthlyEventsStreamFamily._allTransitiveDependencies,
          year: year,
          month: month,
        );

  MonthlyEventsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final int year;
  final int month;

  @override
  Override overrideWith(
    Stream<List<CalendarEvent>> Function(MonthlyEventsStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlyEventsStreamProvider._internal(
        (ref) => create(ref as MonthlyEventsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<CalendarEvent>> createElement() {
    return _MonthlyEventsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyEventsStreamProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MonthlyEventsStreamRef
    on AutoDisposeStreamProviderRef<List<CalendarEvent>> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _MonthlyEventsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<CalendarEvent>>
    with MonthlyEventsStreamRef {
  _MonthlyEventsStreamProviderElement(super.provider);

  @override
  int get year => (origin as MonthlyEventsStreamProvider).year;
  @override
  int get month => (origin as MonthlyEventsStreamProvider).month;
}

String _$todaysEventsStreamHash() =>
    r'9e530e1330176cdd5a5ab2c8de6759c1919d40be';

/// Stream today's events with real-time updates
///
/// Copied from [todaysEventsStream].
@ProviderFor(todaysEventsStream)
final todaysEventsStreamProvider =
    AutoDisposeStreamProvider<List<CalendarEvent>>.internal(
  todaysEventsStream,
  name: r'todaysEventsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todaysEventsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodaysEventsStreamRef
    = AutoDisposeStreamProviderRef<List<CalendarEvent>>;
String _$selectedMonthEventsStreamHash() =>
    r'6c9b24831f08e0168b3c2d67017fbd5c8bc0c216';

/// Stream events for the currently selected month
///
/// Copied from [selectedMonthEventsStream].
@ProviderFor(selectedMonthEventsStream)
final selectedMonthEventsStreamProvider =
    AutoDisposeStreamProvider<List<CalendarEvent>>.internal(
  selectedMonthEventsStream,
  name: r'selectedMonthEventsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedMonthEventsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectedMonthEventsStreamRef
    = AutoDisposeStreamProviderRef<List<CalendarEvent>>;
String _$deletedEventsHash() => r'033d11a698d71fe2e3892bd89bb1c1451b38e76b';

/// Get deleted events (for Trash bin)
///
/// Copied from [deletedEvents].
@ProviderFor(deletedEvents)
final deletedEventsProvider =
    AutoDisposeFutureProvider<List<CalendarEvent>>.internal(
  deletedEvents,
  name: r'deletedEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deletedEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeletedEventsRef = AutoDisposeFutureProviderRef<List<CalendarEvent>>;
String _$calendarEventHash() => r'44a04f03aade2b8633a18ba08300d6d872f2e627';

/// Get a single event by ID (from local DB)
///
/// Copied from [calendarEvent].
@ProviderFor(calendarEvent)
const calendarEventProvider = CalendarEventFamily();

/// Get a single event by ID (from local DB)
///
/// Copied from [calendarEvent].
class CalendarEventFamily extends Family<AsyncValue<CalendarEvent?>> {
  /// Get a single event by ID (from local DB)
  ///
  /// Copied from [calendarEvent].
  const CalendarEventFamily();

  /// Get a single event by ID (from local DB)
  ///
  /// Copied from [calendarEvent].
  CalendarEventProvider call(
    String eventId,
  ) {
    return CalendarEventProvider(
      eventId,
    );
  }

  @override
  CalendarEventProvider getProviderOverride(
    covariant CalendarEventProvider provider,
  ) {
    return call(
      provider.eventId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'calendarEventProvider';
}

/// Get a single event by ID (from local DB)
///
/// Copied from [calendarEvent].
class CalendarEventProvider extends AutoDisposeFutureProvider<CalendarEvent?> {
  /// Get a single event by ID (from local DB)
  ///
  /// Copied from [calendarEvent].
  CalendarEventProvider(
    String eventId,
  ) : this._internal(
          (ref) => calendarEvent(
            ref as CalendarEventRef,
            eventId,
          ),
          from: calendarEventProvider,
          name: r'calendarEventProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$calendarEventHash,
          dependencies: CalendarEventFamily._dependencies,
          allTransitiveDependencies:
              CalendarEventFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  CalendarEventProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    FutureOr<CalendarEvent?> Function(CalendarEventRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CalendarEventProvider._internal(
        (ref) => create(ref as CalendarEventRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CalendarEvent?> createElement() {
    return _CalendarEventProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalendarEventProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CalendarEventRef on AutoDisposeFutureProviderRef<CalendarEvent?> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _CalendarEventProviderElement
    extends AutoDisposeFutureProviderElement<CalendarEvent?>
    with CalendarEventRef {
  _CalendarEventProviderElement(super.provider);

  @override
  String get eventId => (origin as CalendarEventProvider).eventId;
}

String _$hasEventsOnDateHash() => r'14e4438826a8e1d6e0c320604da8d9b681e5c7eb';

/// Helper to check if a date has any events
///
/// Copied from [hasEventsOnDate].
@ProviderFor(hasEventsOnDate)
const hasEventsOnDateProvider = HasEventsOnDateFamily();

/// Helper to check if a date has any events
///
/// Copied from [hasEventsOnDate].
class HasEventsOnDateFamily extends Family<AsyncValue<bool>> {
  /// Helper to check if a date has any events
  ///
  /// Copied from [hasEventsOnDate].
  const HasEventsOnDateFamily();

  /// Helper to check if a date has any events
  ///
  /// Copied from [hasEventsOnDate].
  HasEventsOnDateProvider call(
    DateTime date,
  ) {
    return HasEventsOnDateProvider(
      date,
    );
  }

  @override
  HasEventsOnDateProvider getProviderOverride(
    covariant HasEventsOnDateProvider provider,
  ) {
    return call(
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hasEventsOnDateProvider';
}

/// Helper to check if a date has any events
///
/// Copied from [hasEventsOnDate].
class HasEventsOnDateProvider extends AutoDisposeFutureProvider<bool> {
  /// Helper to check if a date has any events
  ///
  /// Copied from [hasEventsOnDate].
  HasEventsOnDateProvider(
    DateTime date,
  ) : this._internal(
          (ref) => hasEventsOnDate(
            ref as HasEventsOnDateRef,
            date,
          ),
          from: hasEventsOnDateProvider,
          name: r'hasEventsOnDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hasEventsOnDateHash,
          dependencies: HasEventsOnDateFamily._dependencies,
          allTransitiveDependencies:
              HasEventsOnDateFamily._allTransitiveDependencies,
          date: date,
        );

  HasEventsOnDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<bool> Function(HasEventsOnDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HasEventsOnDateProvider._internal(
        (ref) => create(ref as HasEventsOnDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _HasEventsOnDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasEventsOnDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HasEventsOnDateRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _HasEventsOnDateProviderElement
    extends AutoDisposeFutureProviderElement<bool> with HasEventsOnDateRef {
  _HasEventsOnDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as HasEventsOnDateProvider).date;
}

String _$allEventTagsHash() => r'c13f71c95ece26326a414e4d7a1abd977435c65a';

/// Get all unique tags from events
///
/// Copied from [allEventTags].
@ProviderFor(allEventTags)
final allEventTagsProvider = AutoDisposeFutureProvider<List<String>>.internal(
  allEventTags,
  name: r'allEventTagsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allEventTagsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllEventTagsRef = AutoDisposeFutureProviderRef<List<String>>;
String _$selectedDateHash() => r'c4aef8f2e189c2578c08f14b528fa9afaf03b0e8';

/// State class for managing selected date in the calendar
///
/// Copied from [SelectedDate].
@ProviderFor(SelectedDate)
final selectedDateProvider =
    AutoDisposeNotifierProvider<SelectedDate, DateTime>.internal(
  SelectedDate.new,
  name: r'selectedDateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedDateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedDate = AutoDisposeNotifier<DateTime>;
String _$calendarEventCreatorHash() =>
    r'160ac62afbd894d7ec7bc1e9a3e3dfe393e3d661';

/// Controller for creating calendar events
///
/// Copied from [CalendarEventCreator].
@ProviderFor(CalendarEventCreator)
final calendarEventCreatorProvider = AutoDisposeAsyncNotifierProvider<
    CalendarEventCreator, CalendarEvent?>.internal(
  CalendarEventCreator.new,
  name: r'calendarEventCreatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$calendarEventCreatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CalendarEventCreator = AutoDisposeAsyncNotifier<CalendarEvent?>;
String _$calendarEventUpdaterHash() =>
    r'333f307aacdf877861057822c5f89ae850554d01';

/// Controller for updating calendar events
///
/// Copied from [CalendarEventUpdater].
@ProviderFor(CalendarEventUpdater)
final calendarEventUpdaterProvider = AutoDisposeAsyncNotifierProvider<
    CalendarEventUpdater, CalendarEvent?>.internal(
  CalendarEventUpdater.new,
  name: r'calendarEventUpdaterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$calendarEventUpdaterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CalendarEventUpdater = AutoDisposeAsyncNotifier<CalendarEvent?>;
String _$calendarEventDeleterHash() =>
    r'a529137c8b22238e5a444f64fc1be8e75b475105';

/// Controller for deleting calendar events
///
/// Copied from [CalendarEventDeleter].
@ProviderFor(CalendarEventDeleter)
final calendarEventDeleterProvider =
    AutoDisposeAsyncNotifierProvider<CalendarEventDeleter, void>.internal(
  CalendarEventDeleter.new,
  name: r'calendarEventDeleterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$calendarEventDeleterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CalendarEventDeleter = AutoDisposeAsyncNotifier<void>;
String _$deleteSyncWorkerHash() => r'721cd04d0768ccf5053e9734da2387e1381ea2f1';

/// Background worker to sync pending deletes
///
/// Copied from [DeleteSyncWorker].
@ProviderFor(DeleteSyncWorker)
final deleteSyncWorkerProvider =
    AutoDisposeAsyncNotifierProvider<DeleteSyncWorker, void>.internal(
  DeleteSyncWorker.new,
  name: r'deleteSyncWorkerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteSyncWorkerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteSyncWorker = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
