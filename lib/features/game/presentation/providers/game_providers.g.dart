// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firestoreHash() => r'57116d7f1e2dda861cf1362ca8fe50edc7a149b3';

/// Firebase 인스턴스 Provider들
///
/// Copied from [firestore].
@ProviderFor(firestore)
final firestoreProvider = AutoDisposeProvider<FirebaseFirestore>.internal(
  firestore,
  name: r'firestoreProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$firestoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirestoreRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$gameRemoteDataSourceHash() =>
    r'005b8ee9ebf305952541d0544eeae3853663cd52';

/// 게임 데이터 소스 Provider
///
/// Copied from [gameRemoteDataSource].
@ProviderFor(gameRemoteDataSource)
final gameRemoteDataSourceProvider =
    AutoDisposeProvider<GameRemoteDataSource>.internal(
  gameRemoteDataSource,
  name: r'gameRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GameRemoteDataSourceRef = AutoDisposeProviderRef<GameRemoteDataSource>;
String _$gameRepositoryHash() => r'd440e30ed14b4b85b20145875bb328466699d3ce';

/// 게임 리포지토리 Provider
///
/// Copied from [gameRepository].
@ProviderFor(gameRepository)
final gameRepositoryProvider = AutoDisposeProvider<GameRepository>.internal(
  gameRepository,
  name: r'gameRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GameRepositoryRef = AutoDisposeProviderRef<GameRepository>;
String _$saveGameRecordHash() => r'4ebf3fd95211debb245732bcd3f72650d649f0e8';

/// 게임 기록 저장 Use Case Provider
///
/// Copied from [saveGameRecord].
@ProviderFor(saveGameRecord)
final saveGameRecordProvider = AutoDisposeProvider<SaveGameRecord>.internal(
  saveGameRecord,
  name: r'saveGameRecordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveGameRecordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SaveGameRecordRef = AutoDisposeProviderRef<SaveGameRecord>;
String _$getRankingHash() => r'38ec4b2c39b9d52274a9bea643661b1687b759a6';

/// 랭킹 조회 Use Case Provider
///
/// Copied from [getRanking].
@ProviderFor(getRanking)
final getRankingProvider = AutoDisposeProvider<GetRanking>.internal(
  getRanking,
  name: r'getRankingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getRankingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetRankingRef = AutoDisposeProviderRef<GetRanking>;
String _$globalRankingHash() => r'4a2a348c8d45aa07cd1316935d27c9730d891072';

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

/// 전체 랭킹 Provider
///
/// Copied from [globalRanking].
@ProviderFor(globalRanking)
const globalRankingProvider = GlobalRankingFamily();

/// 전체 랭킹 Provider
///
/// Copied from [globalRanking].
class GlobalRankingFamily extends Family<AsyncValue<List<GameRecord>>> {
  /// 전체 랭킹 Provider
  ///
  /// Copied from [globalRanking].
  const GlobalRankingFamily();

  /// 전체 랭킹 Provider
  ///
  /// Copied from [globalRanking].
  GlobalRankingProvider call({
    int limit = 100,
  }) {
    return GlobalRankingProvider(
      limit: limit,
    );
  }

  @override
  GlobalRankingProvider getProviderOverride(
    covariant GlobalRankingProvider provider,
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
  String? get name => r'globalRankingProvider';
}

/// 전체 랭킹 Provider
///
/// Copied from [globalRanking].
class GlobalRankingProvider
    extends AutoDisposeFutureProvider<List<GameRecord>> {
  /// 전체 랭킹 Provider
  ///
  /// Copied from [globalRanking].
  GlobalRankingProvider({
    int limit = 100,
  }) : this._internal(
          (ref) => globalRanking(
            ref as GlobalRankingRef,
            limit: limit,
          ),
          from: globalRankingProvider,
          name: r'globalRankingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$globalRankingHash,
          dependencies: GlobalRankingFamily._dependencies,
          allTransitiveDependencies:
              GlobalRankingFamily._allTransitiveDependencies,
          limit: limit,
        );

  GlobalRankingProvider._internal(
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
    FutureOr<List<GameRecord>> Function(GlobalRankingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GlobalRankingProvider._internal(
        (ref) => create(ref as GlobalRankingRef),
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
  AutoDisposeFutureProviderElement<List<GameRecord>> createElement() {
    return _GlobalRankingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GlobalRankingProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GlobalRankingRef on AutoDisposeFutureProviderRef<List<GameRecord>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _GlobalRankingProviderElement
    extends AutoDisposeFutureProviderElement<List<GameRecord>>
    with GlobalRankingRef {
  _GlobalRankingProviderElement(super.provider);

  @override
  int get limit => (origin as GlobalRankingProvider).limit;
}

String _$dailyRankingHash() => r'236c5e1a881f886e9f1dda5b383cb8bace77d8b5';

/// 일간 랭킹 Provider
///
/// Copied from [dailyRanking].
@ProviderFor(dailyRanking)
const dailyRankingProvider = DailyRankingFamily();

/// 일간 랭킹 Provider
///
/// Copied from [dailyRanking].
class DailyRankingFamily extends Family<AsyncValue<List<GameRecord>>> {
  /// 일간 랭킹 Provider
  ///
  /// Copied from [dailyRanking].
  const DailyRankingFamily();

  /// 일간 랭킹 Provider
  ///
  /// Copied from [dailyRanking].
  DailyRankingProvider call({
    int limit = 100,
  }) {
    return DailyRankingProvider(
      limit: limit,
    );
  }

  @override
  DailyRankingProvider getProviderOverride(
    covariant DailyRankingProvider provider,
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
  String? get name => r'dailyRankingProvider';
}

/// 일간 랭킹 Provider
///
/// Copied from [dailyRanking].
class DailyRankingProvider extends AutoDisposeFutureProvider<List<GameRecord>> {
  /// 일간 랭킹 Provider
  ///
  /// Copied from [dailyRanking].
  DailyRankingProvider({
    int limit = 100,
  }) : this._internal(
          (ref) => dailyRanking(
            ref as DailyRankingRef,
            limit: limit,
          ),
          from: dailyRankingProvider,
          name: r'dailyRankingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dailyRankingHash,
          dependencies: DailyRankingFamily._dependencies,
          allTransitiveDependencies:
              DailyRankingFamily._allTransitiveDependencies,
          limit: limit,
        );

  DailyRankingProvider._internal(
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
    FutureOr<List<GameRecord>> Function(DailyRankingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DailyRankingProvider._internal(
        (ref) => create(ref as DailyRankingRef),
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
  AutoDisposeFutureProviderElement<List<GameRecord>> createElement() {
    return _DailyRankingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyRankingProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DailyRankingRef on AutoDisposeFutureProviderRef<List<GameRecord>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _DailyRankingProviderElement
    extends AutoDisposeFutureProviderElement<List<GameRecord>>
    with DailyRankingRef {
  _DailyRankingProviderElement(super.provider);

  @override
  int get limit => (origin as DailyRankingProvider).limit;
}

String _$userGameRecordsHash() => r'a788deeeb2218856d59ec5f39dcf7f890c638821';

/// 사용자 게임 기록 Provider
///
/// Copied from [userGameRecords].
@ProviderFor(userGameRecords)
const userGameRecordsProvider = UserGameRecordsFamily();

/// 사용자 게임 기록 Provider
///
/// Copied from [userGameRecords].
class UserGameRecordsFamily extends Family<AsyncValue<List<GameRecord>>> {
  /// 사용자 게임 기록 Provider
  ///
  /// Copied from [userGameRecords].
  const UserGameRecordsFamily();

  /// 사용자 게임 기록 Provider
  ///
  /// Copied from [userGameRecords].
  UserGameRecordsProvider call(
    String userId, {
    int limit = 10,
  }) {
    return UserGameRecordsProvider(
      userId,
      limit: limit,
    );
  }

  @override
  UserGameRecordsProvider getProviderOverride(
    covariant UserGameRecordsProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'userGameRecordsProvider';
}

/// 사용자 게임 기록 Provider
///
/// Copied from [userGameRecords].
class UserGameRecordsProvider
    extends AutoDisposeFutureProvider<List<GameRecord>> {
  /// 사용자 게임 기록 Provider
  ///
  /// Copied from [userGameRecords].
  UserGameRecordsProvider(
    String userId, {
    int limit = 10,
  }) : this._internal(
          (ref) => userGameRecords(
            ref as UserGameRecordsRef,
            userId,
            limit: limit,
          ),
          from: userGameRecordsProvider,
          name: r'userGameRecordsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userGameRecordsHash,
          dependencies: UserGameRecordsFamily._dependencies,
          allTransitiveDependencies:
              UserGameRecordsFamily._allTransitiveDependencies,
          userId: userId,
          limit: limit,
        );

  UserGameRecordsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.limit,
  }) : super.internal();

  final String userId;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<GameRecord>> Function(UserGameRecordsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserGameRecordsProvider._internal(
        (ref) => create(ref as UserGameRecordsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<GameRecord>> createElement() {
    return _UserGameRecordsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserGameRecordsProvider &&
        other.userId == userId &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserGameRecordsRef on AutoDisposeFutureProviderRef<List<GameRecord>> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _UserGameRecordsProviderElement
    extends AutoDisposeFutureProviderElement<List<GameRecord>>
    with UserGameRecordsRef {
  _UserGameRecordsProviderElement(super.provider);

  @override
  String get userId => (origin as UserGameRecordsProvider).userId;
  @override
  int get limit => (origin as UserGameRecordsProvider).limit;
}

String _$userBestRecordHash() => r'6ea3a86b44a7e75771942d7452d9da4a5fd8dcb2';

/// 사용자 최고 기록 Provider
///
/// Copied from [userBestRecord].
@ProviderFor(userBestRecord)
const userBestRecordProvider = UserBestRecordFamily();

/// 사용자 최고 기록 Provider
///
/// Copied from [userBestRecord].
class UserBestRecordFamily extends Family<AsyncValue<GameRecord?>> {
  /// 사용자 최고 기록 Provider
  ///
  /// Copied from [userBestRecord].
  const UserBestRecordFamily();

  /// 사용자 최고 기록 Provider
  ///
  /// Copied from [userBestRecord].
  UserBestRecordProvider call(
    String userId,
  ) {
    return UserBestRecordProvider(
      userId,
    );
  }

  @override
  UserBestRecordProvider getProviderOverride(
    covariant UserBestRecordProvider provider,
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
  String? get name => r'userBestRecordProvider';
}

/// 사용자 최고 기록 Provider
///
/// Copied from [userBestRecord].
class UserBestRecordProvider extends AutoDisposeFutureProvider<GameRecord?> {
  /// 사용자 최고 기록 Provider
  ///
  /// Copied from [userBestRecord].
  UserBestRecordProvider(
    String userId,
  ) : this._internal(
          (ref) => userBestRecord(
            ref as UserBestRecordRef,
            userId,
          ),
          from: userBestRecordProvider,
          name: r'userBestRecordProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userBestRecordHash,
          dependencies: UserBestRecordFamily._dependencies,
          allTransitiveDependencies:
              UserBestRecordFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserBestRecordProvider._internal(
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
    FutureOr<GameRecord?> Function(UserBestRecordRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserBestRecordProvider._internal(
        (ref) => create(ref as UserBestRecordRef),
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
  AutoDisposeFutureProviderElement<GameRecord?> createElement() {
    return _UserBestRecordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserBestRecordProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserBestRecordRef on AutoDisposeFutureProviderRef<GameRecord?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserBestRecordProviderElement
    extends AutoDisposeFutureProviderElement<GameRecord?>
    with UserBestRecordRef {
  _UserBestRecordProviderElement(super.provider);

  @override
  String get userId => (origin as UserBestRecordProvider).userId;
}

String _$userRankingDataHash() => r'3e29ab8bf1702ec6b09922a51f95db6507e2330c';

/// 사용자 랭킹 데이터 Provider
///
/// Copied from [userRankingData].
@ProviderFor(userRankingData)
const userRankingDataProvider = UserRankingDataFamily();

/// 사용자 랭킹 데이터 Provider
///
/// Copied from [userRankingData].
class UserRankingDataFamily extends Family<AsyncValue<UserRankingData>> {
  /// 사용자 랭킹 데이터 Provider
  ///
  /// Copied from [userRankingData].
  const UserRankingDataFamily();

  /// 사용자 랭킹 데이터 Provider
  ///
  /// Copied from [userRankingData].
  UserRankingDataProvider call(
    String userId,
  ) {
    return UserRankingDataProvider(
      userId,
    );
  }

  @override
  UserRankingDataProvider getProviderOverride(
    covariant UserRankingDataProvider provider,
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
  String? get name => r'userRankingDataProvider';
}

/// 사용자 랭킹 데이터 Provider
///
/// Copied from [userRankingData].
class UserRankingDataProvider
    extends AutoDisposeFutureProvider<UserRankingData> {
  /// 사용자 랭킹 데이터 Provider
  ///
  /// Copied from [userRankingData].
  UserRankingDataProvider(
    String userId,
  ) : this._internal(
          (ref) => userRankingData(
            ref as UserRankingDataRef,
            userId,
          ),
          from: userRankingDataProvider,
          name: r'userRankingDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userRankingDataHash,
          dependencies: UserRankingDataFamily._dependencies,
          allTransitiveDependencies:
              UserRankingDataFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserRankingDataProvider._internal(
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
    FutureOr<UserRankingData> Function(UserRankingDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserRankingDataProvider._internal(
        (ref) => create(ref as UserRankingDataRef),
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
  AutoDisposeFutureProviderElement<UserRankingData> createElement() {
    return _UserRankingDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserRankingDataProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserRankingDataRef on AutoDisposeFutureProviderRef<UserRankingData> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserRankingDataProviderElement
    extends AutoDisposeFutureProviderElement<UserRankingData>
    with UserRankingDataRef {
  _UserRankingDataProviderElement(super.provider);

  @override
  String get userId => (origin as UserRankingDataProvider).userId;
}

String _$currentUserGameRecordsHash() =>
    r'8bf454401d24f480d763875a913d0ff0f8af9740';

/// 현재 사용자의 게임 기록 Provider (로그인한 사용자)
///
/// Copied from [currentUserGameRecords].
@ProviderFor(currentUserGameRecords)
const currentUserGameRecordsProvider = CurrentUserGameRecordsFamily();

/// 현재 사용자의 게임 기록 Provider (로그인한 사용자)
///
/// Copied from [currentUserGameRecords].
class CurrentUserGameRecordsFamily
    extends Family<AsyncValue<List<GameRecord>>> {
  /// 현재 사용자의 게임 기록 Provider (로그인한 사용자)
  ///
  /// Copied from [currentUserGameRecords].
  const CurrentUserGameRecordsFamily();

  /// 현재 사용자의 게임 기록 Provider (로그인한 사용자)
  ///
  /// Copied from [currentUserGameRecords].
  CurrentUserGameRecordsProvider call({
    int limit = 10,
  }) {
    return CurrentUserGameRecordsProvider(
      limit: limit,
    );
  }

  @override
  CurrentUserGameRecordsProvider getProviderOverride(
    covariant CurrentUserGameRecordsProvider provider,
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
  String? get name => r'currentUserGameRecordsProvider';
}

/// 현재 사용자의 게임 기록 Provider (로그인한 사용자)
///
/// Copied from [currentUserGameRecords].
class CurrentUserGameRecordsProvider
    extends AutoDisposeFutureProvider<List<GameRecord>> {
  /// 현재 사용자의 게임 기록 Provider (로그인한 사용자)
  ///
  /// Copied from [currentUserGameRecords].
  CurrentUserGameRecordsProvider({
    int limit = 10,
  }) : this._internal(
          (ref) => currentUserGameRecords(
            ref as CurrentUserGameRecordsRef,
            limit: limit,
          ),
          from: currentUserGameRecordsProvider,
          name: r'currentUserGameRecordsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentUserGameRecordsHash,
          dependencies: CurrentUserGameRecordsFamily._dependencies,
          allTransitiveDependencies:
              CurrentUserGameRecordsFamily._allTransitiveDependencies,
          limit: limit,
        );

  CurrentUserGameRecordsProvider._internal(
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
    FutureOr<List<GameRecord>> Function(CurrentUserGameRecordsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentUserGameRecordsProvider._internal(
        (ref) => create(ref as CurrentUserGameRecordsRef),
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
  AutoDisposeFutureProviderElement<List<GameRecord>> createElement() {
    return _CurrentUserGameRecordsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentUserGameRecordsProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CurrentUserGameRecordsRef
    on AutoDisposeFutureProviderRef<List<GameRecord>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _CurrentUserGameRecordsProviderElement
    extends AutoDisposeFutureProviderElement<List<GameRecord>>
    with CurrentUserGameRecordsRef {
  _CurrentUserGameRecordsProviderElement(super.provider);

  @override
  int get limit => (origin as CurrentUserGameRecordsProvider).limit;
}

String _$currentUserBestRecordHash() =>
    r'4c078c1a4ce0c656c2f931bf09163caede01686f';

/// 현재 사용자의 최고 기록 Provider
///
/// Copied from [currentUserBestRecord].
@ProviderFor(currentUserBestRecord)
final currentUserBestRecordProvider =
    AutoDisposeFutureProvider<GameRecord?>.internal(
  currentUserBestRecord,
  name: r'currentUserBestRecordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserBestRecordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserBestRecordRef = AutoDisposeFutureProviderRef<GameRecord?>;
String _$currentUserRankingDataHash() =>
    r'19e55915ede18e088f75b6af73d7c6ceaea8f96f';

/// 현재 사용자의 랭킹 데이터 Provider
///
/// Copied from [currentUserRankingData].
@ProviderFor(currentUserRankingData)
final currentUserRankingDataProvider =
    AutoDisposeFutureProvider<UserRankingData?>.internal(
  currentUserRankingData,
  name: r'currentUserRankingDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserRankingDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRankingDataRef
    = AutoDisposeFutureProviderRef<UserRankingData?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
