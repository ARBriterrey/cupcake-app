// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nudge_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nudgeRepositoryHash() => r'7c67b71bfa08c001e4241f8a724a2ed6749a0544';

/// See also [nudgeRepository].
@ProviderFor(nudgeRepository)
final nudgeRepositoryProvider = AutoDisposeProvider<NudgeRepository>.internal(
  nudgeRepository,
  name: r'nudgeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nudgeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NudgeRepositoryRef = AutoDisposeProviderRef<NudgeRepository>;
String _$nudgeLocalRepositoryHash() =>
    r'6dd18056c82c9553ac7ac71ffe16a6b62284228f';

/// See also [nudgeLocalRepository].
@ProviderFor(nudgeLocalRepository)
final nudgeLocalRepositoryProvider =
    AutoDisposeProvider<NudgeLocalRepository>.internal(
  nudgeLocalRepository,
  name: r'nudgeLocalRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nudgeLocalRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NudgeLocalRepositoryRef = AutoDisposeProviderRef<NudgeLocalRepository>;
String _$unviewedNudgesHash() => r'4b8fe18ef7e197d12caa74381295fe5b8a6a82bd';

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

/// Stream of unviewed nudges for current user (real-time)
///
/// Copied from [unviewedNudges].
@ProviderFor(unviewedNudges)
const unviewedNudgesProvider = UnviewedNudgesFamily();

/// Stream of unviewed nudges for current user (real-time)
///
/// Copied from [unviewedNudges].
class UnviewedNudgesFamily extends Family<AsyncValue<List<Nudge>>> {
  /// Stream of unviewed nudges for current user (real-time)
  ///
  /// Copied from [unviewedNudges].
  const UnviewedNudgesFamily();

  /// Stream of unviewed nudges for current user (real-time)
  ///
  /// Copied from [unviewedNudges].
  UnviewedNudgesProvider call(
    String userId,
  ) {
    return UnviewedNudgesProvider(
      userId,
    );
  }

  @override
  UnviewedNudgesProvider getProviderOverride(
    covariant UnviewedNudgesProvider provider,
  ) {
    return call(
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
  String? get name => r'unviewedNudgesProvider';
}

/// Stream of unviewed nudges for current user (real-time)
///
/// Copied from [unviewedNudges].
class UnviewedNudgesProvider extends AutoDisposeStreamProvider<List<Nudge>> {
  /// Stream of unviewed nudges for current user (real-time)
  ///
  /// Copied from [unviewedNudges].
  UnviewedNudgesProvider(
    String userId,
  ) : this._internal(
          (ref) => unviewedNudges(
            ref as UnviewedNudgesRef,
            userId,
          ),
          from: unviewedNudgesProvider,
          name: r'unviewedNudgesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$unviewedNudgesHash,
          dependencies: UnviewedNudgesFamily._dependencies,
          allTransitiveDependencies:
              UnviewedNudgesFamily._allTransitiveDependencies,
          userId: userId,
        );

  UnviewedNudgesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<List<Nudge>> Function(UnviewedNudgesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UnviewedNudgesProvider._internal(
        (ref) => create(ref as UnviewedNudgesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Nudge>> createElement() {
    return _UnviewedNudgesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnviewedNudgesProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UnviewedNudgesRef on AutoDisposeStreamProviderRef<List<Nudge>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UnviewedNudgesProviderElement
    extends AutoDisposeStreamProviderElement<List<Nudge>>
    with UnviewedNudgesRef {
  _UnviewedNudgesProviderElement(super.provider);

  @override
  String get userId => (origin as UnviewedNudgesProvider).userId;
}

String _$recentNudgesLocalHash() => r'4783d24a3d8e7cc0c08ee5526ee4fb32819b925f';

/// Get recent nudges from local storage
///
/// Copied from [recentNudgesLocal].
@ProviderFor(recentNudgesLocal)
const recentNudgesLocalProvider = RecentNudgesLocalFamily();

/// Get recent nudges from local storage
///
/// Copied from [recentNudgesLocal].
class RecentNudgesLocalFamily extends Family<List<NudgeLocal>> {
  /// Get recent nudges from local storage
  ///
  /// Copied from [recentNudgesLocal].
  const RecentNudgesLocalFamily();

  /// Get recent nudges from local storage
  ///
  /// Copied from [recentNudgesLocal].
  RecentNudgesLocalProvider call(
    String pairId,
  ) {
    return RecentNudgesLocalProvider(
      pairId,
    );
  }

  @override
  RecentNudgesLocalProvider getProviderOverride(
    covariant RecentNudgesLocalProvider provider,
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
  String? get name => r'recentNudgesLocalProvider';
}

/// Get recent nudges from local storage
///
/// Copied from [recentNudgesLocal].
class RecentNudgesLocalProvider extends AutoDisposeProvider<List<NudgeLocal>> {
  /// Get recent nudges from local storage
  ///
  /// Copied from [recentNudgesLocal].
  RecentNudgesLocalProvider(
    String pairId,
  ) : this._internal(
          (ref) => recentNudgesLocal(
            ref as RecentNudgesLocalRef,
            pairId,
          ),
          from: recentNudgesLocalProvider,
          name: r'recentNudgesLocalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recentNudgesLocalHash,
          dependencies: RecentNudgesLocalFamily._dependencies,
          allTransitiveDependencies:
              RecentNudgesLocalFamily._allTransitiveDependencies,
          pairId: pairId,
        );

  RecentNudgesLocalProvider._internal(
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
    List<NudgeLocal> Function(RecentNudgesLocalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecentNudgesLocalProvider._internal(
        (ref) => create(ref as RecentNudgesLocalRef),
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
  AutoDisposeProviderElement<List<NudgeLocal>> createElement() {
    return _RecentNudgesLocalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecentNudgesLocalProvider && other.pairId == pairId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pairId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecentNudgesLocalRef on AutoDisposeProviderRef<List<NudgeLocal>> {
  /// The parameter `pairId` of this provider.
  String get pairId;
}

class _RecentNudgesLocalProviderElement
    extends AutoDisposeProviderElement<List<NudgeLocal>>
    with RecentNudgesLocalRef {
  _RecentNudgesLocalProviderElement(super.provider);

  @override
  String get pairId => (origin as RecentNudgesLocalProvider).pairId;
}

String _$unviewedNudgesCountHash() =>
    r'53643ad9b28e7e9c9d0431d7241baf8c92ecf767';

/// Get unviewed nudges count
///
/// Copied from [unviewedNudgesCount].
@ProviderFor(unviewedNudgesCount)
const unviewedNudgesCountProvider = UnviewedNudgesCountFamily();

/// Get unviewed nudges count
///
/// Copied from [unviewedNudgesCount].
class UnviewedNudgesCountFamily extends Family<int> {
  /// Get unviewed nudges count
  ///
  /// Copied from [unviewedNudgesCount].
  const UnviewedNudgesCountFamily();

  /// Get unviewed nudges count
  ///
  /// Copied from [unviewedNudgesCount].
  UnviewedNudgesCountProvider call(
    String userId,
  ) {
    return UnviewedNudgesCountProvider(
      userId,
    );
  }

  @override
  UnviewedNudgesCountProvider getProviderOverride(
    covariant UnviewedNudgesCountProvider provider,
  ) {
    return call(
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
  String? get name => r'unviewedNudgesCountProvider';
}

/// Get unviewed nudges count
///
/// Copied from [unviewedNudgesCount].
class UnviewedNudgesCountProvider extends AutoDisposeProvider<int> {
  /// Get unviewed nudges count
  ///
  /// Copied from [unviewedNudgesCount].
  UnviewedNudgesCountProvider(
    String userId,
  ) : this._internal(
          (ref) => unviewedNudgesCount(
            ref as UnviewedNudgesCountRef,
            userId,
          ),
          from: unviewedNudgesCountProvider,
          name: r'unviewedNudgesCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$unviewedNudgesCountHash,
          dependencies: UnviewedNudgesCountFamily._dependencies,
          allTransitiveDependencies:
              UnviewedNudgesCountFamily._allTransitiveDependencies,
          userId: userId,
        );

  UnviewedNudgesCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    int Function(UnviewedNudgesCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UnviewedNudgesCountProvider._internal(
        (ref) => create(ref as UnviewedNudgesCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _UnviewedNudgesCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnviewedNudgesCountProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UnviewedNudgesCountRef on AutoDisposeProviderRef<int> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UnviewedNudgesCountProviderElement
    extends AutoDisposeProviderElement<int> with UnviewedNudgesCountRef {
  _UnviewedNudgesCountProviderElement(super.provider);

  @override
  String get userId => (origin as UnviewedNudgesCountProvider).userId;
}

String _$nudgeSenderHash() => r'13a8ba884e643592835c118858ef6424026ced6c';

/// See also [NudgeSender].
@ProviderFor(NudgeSender)
final nudgeSenderProvider =
    AutoDisposeAsyncNotifierProvider<NudgeSender, void>.internal(
  NudgeSender.new,
  name: r'nudgeSenderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nudgeSenderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NudgeSender = AutoDisposeAsyncNotifier<void>;
String _$nudgeViewerHash() => r'3ae78ab1e288fafd5ebda091416a66e96de83014';

/// See also [NudgeViewer].
@ProviderFor(NudgeViewer)
final nudgeViewerProvider =
    AutoDisposeAsyncNotifierProvider<NudgeViewer, void>.internal(
  NudgeViewer.new,
  name: r'nudgeViewerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nudgeViewerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NudgeViewer = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
