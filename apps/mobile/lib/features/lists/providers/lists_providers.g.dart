// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listsRepositoryHash() => r'93250cc07e8f8418a6f67907ee34e995ba438979';

/// See also [listsRepository].
@ProviderFor(listsRepository)
final listsRepositoryProvider = AutoDisposeProvider<ListsRepository>.internal(
  listsRepository,
  name: r'listsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ListsRepositoryRef = AutoDisposeProviderRef<ListsRepository>;
String _$listsLocalRepositoryHash() =>
    r'544bf6d38dbe8ad150636b583dd1aa1db9a301bf';

/// See also [listsLocalRepository].
@ProviderFor(listsLocalRepository)
final listsLocalRepositoryProvider =
    AutoDisposeProvider<ListsLocalRepository>.internal(
  listsLocalRepository,
  name: r'listsLocalRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listsLocalRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ListsLocalRepositoryRef = AutoDisposeProviderRef<ListsLocalRepository>;
String _$listsForPairHash() => r'd0239343f715bb1229c398c3c111b59ab543f73a';

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

/// Stream of lists for a pair (real-time)
///
/// Copied from [listsForPair].
@ProviderFor(listsForPair)
const listsForPairProvider = ListsForPairFamily();

/// Stream of lists for a pair (real-time)
///
/// Copied from [listsForPair].
class ListsForPairFamily extends Family<AsyncValue<List<CollaborativeList>>> {
  /// Stream of lists for a pair (real-time)
  ///
  /// Copied from [listsForPair].
  const ListsForPairFamily();

  /// Stream of lists for a pair (real-time)
  ///
  /// Copied from [listsForPair].
  ListsForPairProvider call(
    String pairId,
  ) {
    return ListsForPairProvider(
      pairId,
    );
  }

  @override
  ListsForPairProvider getProviderOverride(
    covariant ListsForPairProvider provider,
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
  String? get name => r'listsForPairProvider';
}

/// Stream of lists for a pair (real-time)
///
/// Copied from [listsForPair].
class ListsForPairProvider
    extends AutoDisposeStreamProvider<List<CollaborativeList>> {
  /// Stream of lists for a pair (real-time)
  ///
  /// Copied from [listsForPair].
  ListsForPairProvider(
    String pairId,
  ) : this._internal(
          (ref) => listsForPair(
            ref as ListsForPairRef,
            pairId,
          ),
          from: listsForPairProvider,
          name: r'listsForPairProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listsForPairHash,
          dependencies: ListsForPairFamily._dependencies,
          allTransitiveDependencies:
              ListsForPairFamily._allTransitiveDependencies,
          pairId: pairId,
        );

  ListsForPairProvider._internal(
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
    Stream<List<CollaborativeList>> Function(ListsForPairRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListsForPairProvider._internal(
        (ref) => create(ref as ListsForPairRef),
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
  AutoDisposeStreamProviderElement<List<CollaborativeList>> createElement() {
    return _ListsForPairProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListsForPairProvider && other.pairId == pairId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pairId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListsForPairRef on AutoDisposeStreamProviderRef<List<CollaborativeList>> {
  /// The parameter `pairId` of this provider.
  String get pairId;
}

class _ListsForPairProviderElement
    extends AutoDisposeStreamProviderElement<List<CollaborativeList>>
    with ListsForPairRef {
  _ListsForPairProviderElement(super.provider);

  @override
  String get pairId => (origin as ListsForPairProvider).pairId;
}

String _$listsLocalHash() => r'd4623aaf8db69d3902592453375219783f0c9061';

/// Get lists from local storage
///
/// Copied from [listsLocal].
@ProviderFor(listsLocal)
const listsLocalProvider = ListsLocalFamily();

/// Get lists from local storage
///
/// Copied from [listsLocal].
class ListsLocalFamily extends Family<List<ListLocal>> {
  /// Get lists from local storage
  ///
  /// Copied from [listsLocal].
  const ListsLocalFamily();

  /// Get lists from local storage
  ///
  /// Copied from [listsLocal].
  ListsLocalProvider call(
    String pairId,
  ) {
    return ListsLocalProvider(
      pairId,
    );
  }

  @override
  ListsLocalProvider getProviderOverride(
    covariant ListsLocalProvider provider,
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
  String? get name => r'listsLocalProvider';
}

/// Get lists from local storage
///
/// Copied from [listsLocal].
class ListsLocalProvider extends AutoDisposeProvider<List<ListLocal>> {
  /// Get lists from local storage
  ///
  /// Copied from [listsLocal].
  ListsLocalProvider(
    String pairId,
  ) : this._internal(
          (ref) => listsLocal(
            ref as ListsLocalRef,
            pairId,
          ),
          from: listsLocalProvider,
          name: r'listsLocalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listsLocalHash,
          dependencies: ListsLocalFamily._dependencies,
          allTransitiveDependencies:
              ListsLocalFamily._allTransitiveDependencies,
          pairId: pairId,
        );

  ListsLocalProvider._internal(
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
    List<ListLocal> Function(ListsLocalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListsLocalProvider._internal(
        (ref) => create(ref as ListsLocalRef),
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
  AutoDisposeProviderElement<List<ListLocal>> createElement() {
    return _ListsLocalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListsLocalProvider && other.pairId == pairId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pairId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListsLocalRef on AutoDisposeProviderRef<List<ListLocal>> {
  /// The parameter `pairId` of this provider.
  String get pairId;
}

class _ListsLocalProviderElement
    extends AutoDisposeProviderElement<List<ListLocal>> with ListsLocalRef {
  _ListsLocalProviderElement(super.provider);

  @override
  String get pairId => (origin as ListsLocalProvider).pairId;
}

String _$listByIdHash() => r'5cfe48ed628110e942fb3e2906da663ea3e96ac4';

/// Get a single list
///
/// Copied from [listById].
@ProviderFor(listById)
const listByIdProvider = ListByIdFamily();

/// Get a single list
///
/// Copied from [listById].
class ListByIdFamily extends Family<AsyncValue<CollaborativeList?>> {
  /// Get a single list
  ///
  /// Copied from [listById].
  const ListByIdFamily();

  /// Get a single list
  ///
  /// Copied from [listById].
  ListByIdProvider call(
    String listId,
  ) {
    return ListByIdProvider(
      listId,
    );
  }

  @override
  ListByIdProvider getProviderOverride(
    covariant ListByIdProvider provider,
  ) {
    return call(
      provider.listId,
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
  String? get name => r'listByIdProvider';
}

/// Get a single list
///
/// Copied from [listById].
class ListByIdProvider extends AutoDisposeFutureProvider<CollaborativeList?> {
  /// Get a single list
  ///
  /// Copied from [listById].
  ListByIdProvider(
    String listId,
  ) : this._internal(
          (ref) => listById(
            ref as ListByIdRef,
            listId,
          ),
          from: listByIdProvider,
          name: r'listByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listByIdHash,
          dependencies: ListByIdFamily._dependencies,
          allTransitiveDependencies: ListByIdFamily._allTransitiveDependencies,
          listId: listId,
        );

  ListByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  Override overrideWith(
    FutureOr<CollaborativeList?> Function(ListByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListByIdProvider._internal(
        (ref) => create(ref as ListByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CollaborativeList?> createElement() {
    return _ListByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListByIdProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListByIdRef on AutoDisposeFutureProviderRef<CollaborativeList?> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _ListByIdProviderElement
    extends AutoDisposeFutureProviderElement<CollaborativeList?>
    with ListByIdRef {
  _ListByIdProviderElement(super.provider);

  @override
  String get listId => (origin as ListByIdProvider).listId;
}

String _$itemsForListHash() => r'439b2785a4e2659e80dad573526825fd78f7f4c5';

/// Stream of items for a list (real-time)
///
/// Copied from [itemsForList].
@ProviderFor(itemsForList)
const itemsForListProvider = ItemsForListFamily();

/// Stream of items for a list (real-time)
///
/// Copied from [itemsForList].
class ItemsForListFamily extends Family<AsyncValue<List<ListItem>>> {
  /// Stream of items for a list (real-time)
  ///
  /// Copied from [itemsForList].
  const ItemsForListFamily();

  /// Stream of items for a list (real-time)
  ///
  /// Copied from [itemsForList].
  ItemsForListProvider call(
    String listId,
  ) {
    return ItemsForListProvider(
      listId,
    );
  }

  @override
  ItemsForListProvider getProviderOverride(
    covariant ItemsForListProvider provider,
  ) {
    return call(
      provider.listId,
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
  String? get name => r'itemsForListProvider';
}

/// Stream of items for a list (real-time)
///
/// Copied from [itemsForList].
class ItemsForListProvider extends AutoDisposeStreamProvider<List<ListItem>> {
  /// Stream of items for a list (real-time)
  ///
  /// Copied from [itemsForList].
  ItemsForListProvider(
    String listId,
  ) : this._internal(
          (ref) => itemsForList(
            ref as ItemsForListRef,
            listId,
          ),
          from: itemsForListProvider,
          name: r'itemsForListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemsForListHash,
          dependencies: ItemsForListFamily._dependencies,
          allTransitiveDependencies:
              ItemsForListFamily._allTransitiveDependencies,
          listId: listId,
        );

  ItemsForListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  Override overrideWith(
    Stream<List<ListItem>> Function(ItemsForListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemsForListProvider._internal(
        (ref) => create(ref as ItemsForListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ListItem>> createElement() {
    return _ItemsForListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemsForListProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemsForListRef on AutoDisposeStreamProviderRef<List<ListItem>> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _ItemsForListProviderElement
    extends AutoDisposeStreamProviderElement<List<ListItem>>
    with ItemsForListRef {
  _ItemsForListProviderElement(super.provider);

  @override
  String get listId => (origin as ItemsForListProvider).listId;
}

String _$itemsLocalHash() => r'aca190bcd47b6c8362680de4283e27103f2dbca1';

/// Get items from local storage
///
/// Copied from [itemsLocal].
@ProviderFor(itemsLocal)
const itemsLocalProvider = ItemsLocalFamily();

/// Get items from local storage
///
/// Copied from [itemsLocal].
class ItemsLocalFamily extends Family<List<ListItemLocal>> {
  /// Get items from local storage
  ///
  /// Copied from [itemsLocal].
  const ItemsLocalFamily();

  /// Get items from local storage
  ///
  /// Copied from [itemsLocal].
  ItemsLocalProvider call(
    String listId,
  ) {
    return ItemsLocalProvider(
      listId,
    );
  }

  @override
  ItemsLocalProvider getProviderOverride(
    covariant ItemsLocalProvider provider,
  ) {
    return call(
      provider.listId,
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
  String? get name => r'itemsLocalProvider';
}

/// Get items from local storage
///
/// Copied from [itemsLocal].
class ItemsLocalProvider extends AutoDisposeProvider<List<ListItemLocal>> {
  /// Get items from local storage
  ///
  /// Copied from [itemsLocal].
  ItemsLocalProvider(
    String listId,
  ) : this._internal(
          (ref) => itemsLocal(
            ref as ItemsLocalRef,
            listId,
          ),
          from: itemsLocalProvider,
          name: r'itemsLocalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemsLocalHash,
          dependencies: ItemsLocalFamily._dependencies,
          allTransitiveDependencies:
              ItemsLocalFamily._allTransitiveDependencies,
          listId: listId,
        );

  ItemsLocalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  Override overrideWith(
    List<ListItemLocal> Function(ItemsLocalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemsLocalProvider._internal(
        (ref) => create(ref as ItemsLocalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<ListItemLocal>> createElement() {
    return _ItemsLocalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemsLocalProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemsLocalRef on AutoDisposeProviderRef<List<ListItemLocal>> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _ItemsLocalProviderElement
    extends AutoDisposeProviderElement<List<ListItemLocal>> with ItemsLocalRef {
  _ItemsLocalProviderElement(super.provider);

  @override
  String get listId => (origin as ItemsLocalProvider).listId;
}

String _$incompleteItemsCountHash() =>
    r'd526972a3dc43680bd26a3e1646af4176b74599d';

/// Get incomplete items count for a list
///
/// Copied from [incompleteItemsCount].
@ProviderFor(incompleteItemsCount)
const incompleteItemsCountProvider = IncompleteItemsCountFamily();

/// Get incomplete items count for a list
///
/// Copied from [incompleteItemsCount].
class IncompleteItemsCountFamily extends Family<int> {
  /// Get incomplete items count for a list
  ///
  /// Copied from [incompleteItemsCount].
  const IncompleteItemsCountFamily();

  /// Get incomplete items count for a list
  ///
  /// Copied from [incompleteItemsCount].
  IncompleteItemsCountProvider call(
    String listId,
  ) {
    return IncompleteItemsCountProvider(
      listId,
    );
  }

  @override
  IncompleteItemsCountProvider getProviderOverride(
    covariant IncompleteItemsCountProvider provider,
  ) {
    return call(
      provider.listId,
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
  String? get name => r'incompleteItemsCountProvider';
}

/// Get incomplete items count for a list
///
/// Copied from [incompleteItemsCount].
class IncompleteItemsCountProvider extends AutoDisposeProvider<int> {
  /// Get incomplete items count for a list
  ///
  /// Copied from [incompleteItemsCount].
  IncompleteItemsCountProvider(
    String listId,
  ) : this._internal(
          (ref) => incompleteItemsCount(
            ref as IncompleteItemsCountRef,
            listId,
          ),
          from: incompleteItemsCountProvider,
          name: r'incompleteItemsCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$incompleteItemsCountHash,
          dependencies: IncompleteItemsCountFamily._dependencies,
          allTransitiveDependencies:
              IncompleteItemsCountFamily._allTransitiveDependencies,
          listId: listId,
        );

  IncompleteItemsCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  Override overrideWith(
    int Function(IncompleteItemsCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IncompleteItemsCountProvider._internal(
        (ref) => create(ref as IncompleteItemsCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _IncompleteItemsCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IncompleteItemsCountProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IncompleteItemsCountRef on AutoDisposeProviderRef<int> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _IncompleteItemsCountProviderElement
    extends AutoDisposeProviderElement<int> with IncompleteItemsCountRef {
  _IncompleteItemsCountProviderElement(super.provider);

  @override
  String get listId => (origin as IncompleteItemsCountProvider).listId;
}

String _$unassignedItemsCountHash() =>
    r'6c7c80b03c5b62b44f1027764b9ea0d3b7730a97';

/// Get unassigned items count for Chit Jar mode
///
/// Copied from [unassignedItemsCount].
@ProviderFor(unassignedItemsCount)
const unassignedItemsCountProvider = UnassignedItemsCountFamily();

/// Get unassigned items count for Chit Jar mode
///
/// Copied from [unassignedItemsCount].
class UnassignedItemsCountFamily extends Family<AsyncValue<int>> {
  /// Get unassigned items count for Chit Jar mode
  ///
  /// Copied from [unassignedItemsCount].
  const UnassignedItemsCountFamily();

  /// Get unassigned items count for Chit Jar mode
  ///
  /// Copied from [unassignedItemsCount].
  UnassignedItemsCountProvider call(
    String listId,
  ) {
    return UnassignedItemsCountProvider(
      listId,
    );
  }

  @override
  UnassignedItemsCountProvider getProviderOverride(
    covariant UnassignedItemsCountProvider provider,
  ) {
    return call(
      provider.listId,
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
  String? get name => r'unassignedItemsCountProvider';
}

/// Get unassigned items count for Chit Jar mode
///
/// Copied from [unassignedItemsCount].
class UnassignedItemsCountProvider extends AutoDisposeFutureProvider<int> {
  /// Get unassigned items count for Chit Jar mode
  ///
  /// Copied from [unassignedItemsCount].
  UnassignedItemsCountProvider(
    String listId,
  ) : this._internal(
          (ref) => unassignedItemsCount(
            ref as UnassignedItemsCountRef,
            listId,
          ),
          from: unassignedItemsCountProvider,
          name: r'unassignedItemsCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$unassignedItemsCountHash,
          dependencies: UnassignedItemsCountFamily._dependencies,
          allTransitiveDependencies:
              UnassignedItemsCountFamily._allTransitiveDependencies,
          listId: listId,
        );

  UnassignedItemsCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  Override overrideWith(
    FutureOr<int> Function(UnassignedItemsCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UnassignedItemsCountProvider._internal(
        (ref) => create(ref as UnassignedItemsCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _UnassignedItemsCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnassignedItemsCountProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UnassignedItemsCountRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _UnassignedItemsCountProviderElement
    extends AutoDisposeFutureProviderElement<int> with UnassignedItemsCountRef {
  _UnassignedItemsCountProviderElement(super.provider);

  @override
  String get listId => (origin as UnassignedItemsCountProvider).listId;
}

String _$listCreatorHash() => r'ce109c19c9fcb6b6419ec7877ad63a176d7b5719';

/// See also [ListCreator].
@ProviderFor(ListCreator)
final listCreatorProvider =
    AutoDisposeAsyncNotifierProvider<ListCreator, void>.internal(
  ListCreator.new,
  name: r'listCreatorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$listCreatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListCreator = AutoDisposeAsyncNotifier<void>;
String _$listUpdaterHash() => r'1f6452a4c565aa95c0626947fc413ef5650a5f39';

/// See also [ListUpdater].
@ProviderFor(ListUpdater)
final listUpdaterProvider =
    AutoDisposeAsyncNotifierProvider<ListUpdater, void>.internal(
  ListUpdater.new,
  name: r'listUpdaterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$listUpdaterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListUpdater = AutoDisposeAsyncNotifier<void>;
String _$listDeleterHash() => r'c389b4872bd947f39aa29001f29e7a5164d1edc2';

/// See also [ListDeleter].
@ProviderFor(ListDeleter)
final listDeleterProvider =
    AutoDisposeAsyncNotifierProvider<ListDeleter, void>.internal(
  ListDeleter.new,
  name: r'listDeleterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$listDeleterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListDeleter = AutoDisposeAsyncNotifier<void>;
String _$listItemCreatorHash() => r'acf631956100ce8f92c3f27c16d89f5a403d8029';

/// See also [ListItemCreator].
@ProviderFor(ListItemCreator)
final listItemCreatorProvider =
    AutoDisposeAsyncNotifierProvider<ListItemCreator, void>.internal(
  ListItemCreator.new,
  name: r'listItemCreatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listItemCreatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListItemCreator = AutoDisposeAsyncNotifier<void>;
String _$listItemUpdaterHash() => r'bb4c2754ef3adffb2c8a9d3284748320fb667d06';

/// See also [ListItemUpdater].
@ProviderFor(ListItemUpdater)
final listItemUpdaterProvider =
    AutoDisposeAsyncNotifierProvider<ListItemUpdater, void>.internal(
  ListItemUpdater.new,
  name: r'listItemUpdaterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listItemUpdaterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListItemUpdater = AutoDisposeAsyncNotifier<void>;
String _$listItemDeleterHash() => r'b30ec31d8c22423b73b675731f2bd71e68f12a62';

/// See also [ListItemDeleter].
@ProviderFor(ListItemDeleter)
final listItemDeleterProvider =
    AutoDisposeAsyncNotifierProvider<ListItemDeleter, void>.internal(
  ListItemDeleter.new,
  name: r'listItemDeleterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listItemDeleterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListItemDeleter = AutoDisposeAsyncNotifier<void>;
String _$chitJarPickerHash() => r'8e87eb2d3e4321e0e3805353513df2a40f4de361';

/// See also [ChitJarPicker].
@ProviderFor(ChitJarPicker)
final chitJarPickerProvider =
    AutoDisposeAsyncNotifierProvider<ChitJarPicker, void>.internal(
  ChitJarPicker.new,
  name: r'chitJarPickerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chitJarPickerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChitJarPicker = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
