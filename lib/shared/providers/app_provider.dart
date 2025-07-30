import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/theme/app_theme.dart';

part 'app_provider.g.dart';
part 'app_provider.freezed.dart';

/// 앱 전역 상태
@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(Locale('ko', 'KR')) Locale locale,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _AppState;
}

/// 앱 전역 상태 관리 Provider
@riverpod
class AppNotifier extends _$AppNotifier {
  @override
  AppState build() {
    return const AppState();
  }

  /// 테마 모드 변경
  void setThemeMode(AppThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    // TODO: SharedPreferences에 저장
  }

  /// 언어 설정 변경
  void setLocale(Locale locale) {
    state = state.copyWith(locale: locale);
    // TODO: SharedPreferences에 저장
  }

  /// 로딩 상태 설정
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  /// 에러 메시지 설정
  void setError(String? message) {
    state = state.copyWith(errorMessage: message);
  }

  /// 에러 메시지 초기화
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}