// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameStateNotifierHash() => r'a6f72ec79bf2c044eef5453903a7a0711019a266';

/// 게임 상태 Provider
///
/// Copied from [GameStateNotifier].
@ProviderFor(GameStateNotifier)
final gameStateNotifierProvider =
    AutoDisposeNotifierProvider<GameStateNotifier, GameState>.internal(
  GameStateNotifier.new,
  name: r'gameStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameStateNotifier = AutoDisposeNotifier<GameState>;
String _$gameBridgeNotifierHash() =>
    r'444a97bb12308bf78c922492f7129b7e30141ef8';

/// JavaScript Bridge용 게임 이벤트 Provider
///
/// Copied from [GameBridgeNotifier].
@ProviderFor(GameBridgeNotifier)
final gameBridgeNotifierProvider = AutoDisposeNotifierProvider<
    GameBridgeNotifier, Map<String, dynamic>>.internal(
  GameBridgeNotifier.new,
  name: r'gameBridgeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameBridgeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameBridgeNotifier = AutoDisposeNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
