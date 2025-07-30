import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../../domain/usecases/sign_out.dart';
import 'auth_providers.dart';
import '../../../../core/error/failures.dart';

part 'auth_state_provider.g.dart';

// =============================================================================
// Use Cases Providers
// =============================================================================

/// Get Current User Use Case
@riverpod
GetCurrentUser getCurrentUser(Ref ref) {
  return GetCurrentUser(ref.watch(authRepositoryProvider));
}

/// Sign In With Email Use Case
@riverpod
SignInWithEmail signInWithEmail(Ref ref) {
  return SignInWithEmail(ref.watch(authRepositoryProvider));
}

/// Sign In With Google Use Case
@riverpod
SignInWithGoogle signInWithGoogle(Ref ref) {
  return SignInWithGoogle(ref.watch(authRepositoryProvider));
}

/// Sign Up With Email Use Case
@riverpod
SignUpWithEmail signUpWithEmail(Ref ref) {
  return SignUpWithEmail(ref.watch(authRepositoryProvider));
}

/// Sign Out Use Case
@riverpod
SignOut signOut(Ref ref) {
  return SignOut(ref.watch(authRepositoryProvider));
}

// =============================================================================
// Current User Stream Provider
// =============================================================================

/// 현재 사용자 실시간 스트림
@riverpod
Stream<User?> currentUserStream(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.currentUserStream;
}

// =============================================================================
// Auth State
// =============================================================================

class AuthState {
  final User? user;
  final bool isLoading;
  final bool isSigningIn;
  final bool isSigningOut;
  final String? errorMessage;
  final AuthResult? lastAuthResult;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.isSigningIn = false,
    this.isSigningOut = false,
    this.errorMessage,
    this.lastAuthResult,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    bool? isSigningIn,
    bool? isSigningOut,
    String? errorMessage,
    AuthResult? lastAuthResult,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isSigningIn: isSigningIn ?? this.isSigningIn,
      isSigningOut: isSigningOut ?? this.isSigningOut,
      errorMessage: errorMessage ?? this.errorMessage,
      lastAuthResult: lastAuthResult ?? this.lastAuthResult,
    );
  }
}

// =============================================================================
// Auth State Notifier
// =============================================================================

/// 인증 상태 관리 Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(const AuthState()) {
    // 현재 사용자 스트림 구독
    _listenToUserStream();
  }

  void _listenToUserStream() {
    ref.listen(currentUserStreamProvider, (previous, next) {
      next.when(
        data: (user) {
          if (state.user?.id != user?.id) {
            state = state.copyWith(
              user: user,
              isLoading: false,
              errorMessage: null,
            );
          }
        },
        loading: () {
          if (!state.isLoading) {
            state = state.copyWith(isLoading: true);
          }
        },
        error: (error, stackTrace) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: error.toString(),
          );
        },
      );
    });
  }

  /// 이메일로 로그인
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (state.isSigningIn) return;

    state = state.copyWith(
      isSigningIn: true,
      errorMessage: null,
    );

    try {
      final useCase = ref.read(signInWithEmailProvider);
      final result = await useCase(SignInWithEmailParams(
        email: email,
        password: password,
      ));

      result.fold(
        (failure) {
          state = state.copyWith(
            isSigningIn: false,
            errorMessage: failure.userMessage,
          );
        },
        (authResult) {
          state = state.copyWith(
            isSigningIn: false,
            lastAuthResult: authResult,
            errorMessage: null,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isSigningIn: false,
        errorMessage: '로그인 중 오류가 발생했습니다: $e',
      );
    }
  }

  /// 이메일로 회원가입
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String confirmPassword,
    String? displayName,
  }) async {
    if (state.isSigningIn) return;

    state = state.copyWith(
      isSigningIn: true,
      errorMessage: null,
    );

    try {
      final useCase = ref.read(signUpWithEmailProvider);
      final result = await useCase(SignUpWithEmailParams(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        displayName: displayName,
      ));

      result.fold(
        (failure) {
          state = state.copyWith(
            isSigningIn: false,
            errorMessage: failure.userMessage,
          );
        },
        (authResult) {
          // 회원가입 성공 시 user 상태도 업데이트하여 화면 전환 트리거
          state = state.copyWith(
            isSigningIn: false,
            user: authResult.user,
            lastAuthResult: authResult,
            errorMessage: null,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isSigningIn: false,
        errorMessage: '회원가입 중 오류가 발생했습니다: $e',
      );
    }
  }

  /// 구글로 로그인
  Future<void> signInWithGoogle() async {
    if (state.isSigningIn) return;

    state = state.copyWith(
      isSigningIn: true,
      errorMessage: null,
    );

    try {
      final useCase = ref.read(signInWithGoogleProvider);
      final result = await useCase();

      result.fold(
        (failure) {
          state = state.copyWith(
            isSigningIn: false,
            errorMessage: failure.userMessage,
          );
        },
        (authResult) {
          state = state.copyWith(
            isSigningIn: false,
            lastAuthResult: authResult,
            errorMessage: null,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isSigningIn: false,
        errorMessage: '구글 로그인 중 오류가 발생했습니다: $e',
      );
    }
  }

  /// 로그아웃
  Future<void> signOut() async {
    if (state.isSigningOut) return;

    state = state.copyWith(
      isSigningOut: true,
      errorMessage: null,
    );

    try {
      final useCase = ref.read(signOutProvider);
      final result = await useCase();

      result.fold(
        (failure) {
          state = state.copyWith(
            isSigningOut: false,
            errorMessage: failure.userMessage,
          );
        },
        (_) {
          state = state.copyWith(
            isSigningOut: false,
            user: null,
            lastAuthResult: null,
            errorMessage: null,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isSigningOut: false,
        errorMessage: '로그아웃 중 오류가 발생했습니다: $e',
      );
    }
  }

  /// 오류 메시지 초기화
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// 로딩 상태 초기화
  void clearLoading() {
    state = state.copyWith(
      isLoading: false,
      isSigningIn: false,
      isSigningOut: false,
    );
  }
}

/// Auth State Provider
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

// =============================================================================
// Helper Providers
// =============================================================================

/// 사용자 로그인 여부
final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserStreamProvider).value;
  return user != null && !user.isAnonymous;
});

/// 익명 사용자 여부
final isAnonymousUserProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserStreamProvider).value;
  return user != null && user.isAnonymous;
});

/// 사용자 로그아웃 상태
final isLoggedOutProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserStreamProvider).value;
  return user == null;
});