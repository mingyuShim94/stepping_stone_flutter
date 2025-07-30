import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';

/// 인증 폼 위젯 (로그인/회원가입 공통)
class AuthForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? confirmPasswordController;
  final TextEditingController? displayNameController;
  final VoidCallback onSubmit;
  final String buttonText;
  final bool isLoading;
  final bool isSignUp;

  const AuthForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    this.confirmPasswordController,
    this.displayNameController,
    required this.onSubmit,
    required this.buttonText,
    this.isLoading = false,
    this.isSignUp = false,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 이름 입력 (회원가입시에만)
          if (widget.isSignUp && widget.displayNameController != null) ...[
            TextFormField(
              controller: widget.displayNameController,
              decoration: const InputDecoration(
                labelText: '이름',
                hintText: '표시될 이름을 입력하세요',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '이름을 입력해주세요';
                }
                if (value.trim().length < 2) {
                  return '이름은 최소 2자 이상이어야 합니다';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
          ],
          
          // 이메일 입력
          TextFormField(
            controller: widget.emailController,
            decoration: const InputDecoration(
              labelText: '이메일',
              hintText: 'example@email.com',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              final validation = FormValidators.validateEmail(value ?? '');
              return validation.isValid ? null : validation.errorMessage;
            },
          ),
          
          const SizedBox(height: 16),
          
          // 비밀번호 입력
          TextFormField(
            controller: widget.passwordController,
            decoration: InputDecoration(
              labelText: '비밀번호',
              hintText: '비밀번호를 입력하세요',
              prefixIcon: const Icon(Icons.lock),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            textInputAction: widget.confirmPasswordController != null 
                ? TextInputAction.next 
                : TextInputAction.done,
            validator: (value) {
              final validation = FormValidators.validatePassword(value ?? '');
              return validation.isValid ? null : validation.errorMessage;
            },
            onFieldSubmitted: (_) {
              if (widget.confirmPasswordController == null) {
                widget.onSubmit();
              }
            },
          ),
          
          // 비밀번호 확인 (회원가입시에만)
          if (widget.confirmPasswordController != null) ...[
            const SizedBox(height: 16),
            TextFormField(
              controller: widget.confirmPasswordController,
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                hintText: '비밀번호를 다시 입력하세요',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              obscureText: _obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호 확인을 입력해주세요';
                }
                if (value != widget.passwordController.text) {
                  return '비밀번호가 일치하지 않습니다';
                }
                return null;
              },
              onFieldSubmitted: (_) => widget.onSubmit(),
            ),
          ],
          
          const SizedBox(height: 24),
          
          // 제출 버튼
          ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onSubmit,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: widget.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    widget.buttonText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}