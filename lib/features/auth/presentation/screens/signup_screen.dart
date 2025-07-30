import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_state_provider.dart';
import '../widgets/auth_form.dart';
import '../widgets/social_login_buttons.dart';
import '../../../../shared/widgets/loading_overlay.dart';

/// 회원가입 화면
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final displayName = _displayNameController.text.trim();

    await ref.read(authNotifierProvider.notifier).signUpWithEmail(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      displayName: displayName.isNotEmpty ? displayName : null,
    );
  }

  Future<void> _handleGoogleSignUp() async {
    await ref.read(authNotifierProvider.notifier).signInWithGoogle();
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    
    // 회원가입 성공 시 자동으로 이전 화면으로 돌아가기
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.user != null && !next.user!.isAnonymous) {
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: LoadingOverlay(
        isLoading: authState.isSigningIn,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // 로고 및 제목
                Icon(
                  Icons.games,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Stepping Stone Game',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '새 계정을 만들어 게임을 시작하세요',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 48),
                
                // 회원가입 폼
                AuthForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  displayNameController: _displayNameController,
                  onSubmit: _handleEmailSignUp,
                  buttonText: '회원가입',
                  isLoading: authState.isSigningIn,
                  isSignUp: true,
                ),
                
                const SizedBox(height: 24),
                
                // 오류 메시지
                if (authState.errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      authState.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                const SizedBox(height: 24),
                
                // 소셜 로그인
                SocialLoginButtons(
                  onGoogleSignIn: _handleGoogleSignUp,
                  isLoading: authState.isSigningIn,
                ),
                
                const SizedBox(height: 32),
                
                // 로그인 링크
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '이미 계정이 있으신가요? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: authState.isSigningIn ? null : _goToLogin,
                      child: const Text('로그인'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // 익명으로 계속하기
                TextButton(
                  onPressed: authState.isSigningIn ? null : () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('나중에 가입하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}