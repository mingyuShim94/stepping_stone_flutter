import 'package:flutter/material.dart';

/// 소셜 로그인 버튼들
class SocialLoginButtons extends StatelessWidget {
  final VoidCallback? onGoogleSignIn;
  final bool isLoading;

  const SocialLoginButtons({
    super.key,
    this.onGoogleSignIn,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 구분선
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '또는',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // 구글 로그인 버튼
        OutlinedButton.icon(
          onPressed: isLoading ? null : onGoogleSignIn,
          icon: const Icon(
            Icons.account_circle,
            size: 20,
          ),
          label: const Text('Google로 로그인'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
      ],
    );
  }
}