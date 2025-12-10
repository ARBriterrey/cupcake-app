// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$journalLocalRepositoryHash() =>
    r'df582b541c09dd0de2b0f05de20c91d6b20f4857';

/// See also [journalLocalRepository].
@ProviderFor(journalLocalRepository)
final journalLocalRepositoryProvider =
    AutoDisposeProvider<JournalLocalRepository>.internal(
  journalLocalRepository,
  name: r'journalLocalRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalLocalRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JournalLocalRepositoryRef
    = AutoDisposeProviderRef<JournalLocalRepository>;
String _$journalRepositoryHash() => r'98f23815303daa0a858a9739fb5499eecaed83cc';

/// See also [journalRepository].
@ProviderFor(journalRepository)
final journalRepositoryProvider =
    AutoDisposeProvider<JournalRepository>.internal(
  journalRepository,
  name: r'journalRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JournalRepositoryRef = AutoDisposeProviderRef<JournalRepository>;
String _$journalEntriesHash() => r'b5c3894c832504503063778407e6a7b8ba128189';

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

/// See also [journalEntries].
@ProviderFor(journalEntries)
const journalEntriesProvider = JournalEntriesFamily();

/// See also [journalEntries].
class JournalEntriesFamily extends Family<List<JournalEntryLocal>> {
  /// See also [journalEntries].
  const JournalEntriesFamily();

  /// See also [journalEntries].
  JournalEntriesProvider call(
    String pairId,
  ) {
    return JournalEntriesProvider(
      pairId,
    );
  }

  @override
  JournalEntriesProvider getProviderOverride(
    covariant JournalEntriesProvider provider,
  ) {
    return call(
      provider.pairId,
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
  String? get name => r'journalEntriesProvider';
}

/// See also [journalEntries].
class JournalEntriesProvider
    extends AutoDisposeProvider<List<JournalEntryLocal>> {
  /// See also [journalEntries].
  JournalEntriesProvider(
    String pairId,
  ) : this._internal(
          (ref) => journalEntries(
            ref as JournalEntriesRef,
            pairId,
          ),
          from: journalEntriesProvider,
          name: r'journalEntriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$journalEntriesHash,
          dependencies: JournalEntriesFamily._dependencies,
          allTransitiveDependencies:
              JournalEntriesFamily._allTransitiveDependencies,
          pairId: pairId,
        );

  JournalEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pairId,
  }) : super.internal();

  final String pairId;

  @override
  Override overrideWith(
    List<JournalEntryLocal> Function(JournalEntriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JournalEntriesProvider._internal(
        (ref) => create(ref as JournalEntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pairId: pairId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<JournalEntryLocal>> createElement() {
    return _JournalEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalEntriesProvider && other.pairId == pairId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pairId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin JournalEntriesRef on AutoDisposeProviderRef<List<JournalEntryLocal>> {
  /// The parameter `pairId` of this provider.
  String get pairId;
}

class _JournalEntriesProviderElement
    extends AutoDisposeProviderElement<List<JournalEntryLocal>>
    with JournalEntriesRef {
  _JournalEntriesProviderElement(super.provider);

  @override
  String get pairId => (origin as JournalEntriesProvider).pairId;
}

String _$sharedJournalEntriesHash() =>
    r'335f21747dd886c40388b2128da31bd56be8ebbb';

/// See also [sharedJournalEntries].
@ProviderFor(sharedJournalEntries)
const sharedJournalEntriesProvider = SharedJournalEntriesFamily();

/// See also [sharedJournalEntries].
class SharedJournalEntriesFamily extends Family<List<JournalEntryLocal>> {
  /// See also [sharedJournalEntries].
  const SharedJournalEntriesFamily();

  /// See also [sharedJournalEntries].
  SharedJournalEntriesProvider call(
    String pairId,
  ) {
    return SharedJournalEntriesProvider(
      pairId,
    );
  }

  @override
  SharedJournalEntriesProvider getProviderOverride(
    covariant SharedJournalEntriesProvider provider,
  ) {
    return call(
      provider.pairId,
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
  String? get name => r'sharedJournalEntriesProvider';
}

/// See also [sharedJournalEntries].
class SharedJournalEntriesProvider
    extends AutoDisposeProvider<List<JournalEntryLocal>> {
  /// See also [sharedJournalEntries].
  SharedJournalEntriesProvider(
    String pairId,
  ) : this._internal(
          (ref) => sharedJournalEntries(
            ref as SharedJournalEntriesRef,
            pairId,
          ),
          from: sharedJournalEntriesProvider,
          name: r'sharedJournalEntriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sharedJournalEntriesHash,
          dependencies: SharedJournalEntriesFamily._dependencies,
          allTransitiveDependencies:
              SharedJournalEntriesFamily._allTransitiveDependencies,
          pairId: pairId,
        );

  SharedJournalEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pairId,
  }) : super.internal();

  final String pairId;

  @override
  Override overrideWith(
    List<JournalEntryLocal> Function(SharedJournalEntriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SharedJournalEntriesProvider._internal(
        (ref) => create(ref as SharedJournalEntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pairId: pairId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<JournalEntryLocal>> createElement() {
    return _SharedJournalEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SharedJournalEntriesProvider && other.pairId == pairId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pairId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SharedJournalEntriesRef
    on AutoDisposeProviderRef<List<JournalEntryLocal>> {
  /// The parameter `pairId` of this provider.
  String get pairId;
}

class _SharedJournalEntriesProviderElement
    extends AutoDisposeProviderElement<List<JournalEntryLocal>>
    with SharedJournalEntriesRef {
  _SharedJournalEntriesProviderElement(super.provider);

  @override
  String get pairId => (origin as SharedJournalEntriesProvider).pairId;
}

String _$privateJournalEntriesHash() =>
    r'354a9b7014e120bd6bc14e7aef85dfd9369e878e';

/// See also [privateJournalEntries].
@ProviderFor(privateJournalEntries)
const privateJournalEntriesProvider = PrivateJournalEntriesFamily();

/// See also [privateJournalEntries].
class PrivateJournalEntriesFamily extends Family<List<JournalEntryLocal>> {
  /// See also [privateJournalEntries].
  const PrivateJournalEntriesFamily();

  /// See also [privateJournalEntries].
  PrivateJournalEntriesProvider call(
    String pairId,
    String userId,
  ) {
    return PrivateJournalEntriesProvider(
      pairId,
      userId,
    );
  }

  @override
  PrivateJournalEntriesProvider getProviderOverride(
    covariant PrivateJournalEntriesProvider provider,
  ) {
    return call(
      provider.pairId,
      provider.userId,
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
  String? get name => r'privateJournalEntriesProvider';
}

/// See also [privateJournalEntries].
class PrivateJournalEntriesProvider
    extends AutoDisposeProvider<List<JournalEntryLocal>> {
  /// See also [privateJournalEntries].
  PrivateJournalEntriesProvider(
    String pairId,
    String userId,
  ) : this._internal(
          (ref) => privateJournalEntries(
            ref as PrivateJournalEntriesRef,
            pairId,
            userId,
          ),
          from: privateJournalEntriesProvider,
          name: r'privateJournalEntriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$privateJournalEntriesHash,
          dependencies: PrivateJournalEntriesFamily._dependencies,
          allTransitiveDependencies:
              PrivateJournalEntriesFamily._allTransitiveDependencies,
          pairId: pairId,
          userId: userId,
        );

  PrivateJournalEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pairId,
    required this.userId,
  }) : super.internal();

  final String pairId;
  final String userId;

  @override
  Override overrideWith(
    List<JournalEntryLocal> Function(PrivateJournalEntriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrivateJournalEntriesProvider._internal(
        (ref) => create(ref as PrivateJournalEntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pairId: pairId,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<JournalEntryLocal>> createElement() {
    return _PrivateJournalEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrivateJournalEntriesProvider &&
        other.pairId == pairId &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pairId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PrivateJournalEntriesRef
    on AutoDisposeProviderRef<List<JournalEntryLocal>> {
  /// The parameter `pairId` of this provider.
  String get pairId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _PrivateJournalEntriesProviderElement
    extends AutoDisposeProviderElement<List<JournalEntryLocal>>
    with PrivateJournalEntriesRef {
  _PrivateJournalEntriesProviderElement(super.provider);

  @override
  String get pairId => (origin as PrivateJournalEntriesProvider).pairId;
  @override
  String get userId => (origin as PrivateJournalEntriesProvider).userId;
}

String _$journalEntryCreatorHash() =>
    r'765acfcceb411182cf76b99230af27566ce926ae';

/// See also [JournalEntryCreator].
@ProviderFor(JournalEntryCreator)
final journalEntryCreatorProvider =
    AutoDisposeAsyncNotifierProvider<JournalEntryCreator, void>.internal(
  JournalEntryCreator.new,
  name: r'journalEntryCreatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalEntryCreatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JournalEntryCreator = AutoDisposeAsyncNotifier<void>;
String _$journalEntryUpdaterHash() =>
    r'3891ee385d6b98d43fff52dc5b12c4b913595092';

/// See also [JournalEntryUpdater].
@ProviderFor(JournalEntryUpdater)
final journalEntryUpdaterProvider =
    AutoDisposeAsyncNotifierProvider<JournalEntryUpdater, void>.internal(
  JournalEntryUpdater.new,
  name: r'journalEntryUpdaterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalEntryUpdaterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JournalEntryUpdater = AutoDisposeAsyncNotifier<void>;
String _$journalEntryDeleterHash() =>
    r'71b16d473e05141d04c85f567b156bc3902dc9ac';

/// See also [JournalEntryDeleter].
@ProviderFor(JournalEntryDeleter)
final journalEntryDeleterProvider =
    AutoDisposeAsyncNotifierProvider<JournalEntryDeleter, void>.internal(
  JournalEntryDeleter.new,
  name: r'journalEntryDeleterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalEntryDeleterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JournalEntryDeleter = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
