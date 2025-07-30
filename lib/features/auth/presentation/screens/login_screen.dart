import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_state_provider.dart';
import '../widgets/auth_form.dart';
import '../widgets/social_login_buttons.dart';
import '../../../../shared/widgets/loading_overlay.dart';

/// 로그인 화면
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    await ref.read(authNotifierProvider.notifier).signInWithEmail(
      email: email,
      password: password,
    );
  }

  Future<void> _handleGoogleLogin() async {
    await ref.read(authNotifierProvider.notifier).signInWithGoogle();
  }

  void _goToSignUp() {
    Navigator.of(context).pushReplacementNamed('/signup');
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    
    // 로그인 성공 시 자동으로 이전 화면으로 돌아가기
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
                  '로그인하여 게임을 즐겨보세요',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 48),
                
                // 이메일 로그인 폼
                AuthForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onSubmit: _handleEmailLogin,
                  buttonText: '로그인',
                  isLoading: authState.isSigningIn,
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
                  onGoogleSignIn: _handleGoogleLogin,
                  isLoading: authState.isSigningIn,
                ),
                
                const SizedBox(height: 32),
                
                // 회원가입 링크
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '계정이 없으신가요? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: authState.isSigningIn ? null : _goToSignUp,
                      child: const Text('회원가입'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // 익명으로 계속하기
                TextButton(
                  onPressed: authState.isSigningIn ? null : () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('나중에 로그인하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}