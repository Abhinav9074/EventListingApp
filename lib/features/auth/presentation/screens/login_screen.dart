import 'package:event_listing_app/features/auth/presentation/controller/auth_controller.dart';
import 'package:event_listing_app/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    ref.listen(authStateProvider, (prev, next) {
      if (next.value != null) {
        context.go('/home');
      }
    });

    return Scaffold(
      body:
          authState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Discover events, meet new people and\nmake memories',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    _buildSocialButton(
                      icon: Icons.facebook,
                      text: 'Continue with Facebook',
                      color: Colors.blue[800]!,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 16),
                    _buildSocialButton(
                      icon: Icons.g_mobiledata,
                      text: 'Sign in with Google',
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () async {
                        await ref
                            .read(authControllerProvider)
                            .signInWithGoogle();
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildSocialButton(
                      icon: Icons.email,
                      text: 'Sign in with Email',
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 24),
                    const Text.rich(
                      TextSpan(
                        text: 'By signing in, I agree to Allevents\'s ',
                        children: [
                          TextSpan(
                            text: 'Privacy policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Terms of services',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required Color color,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side:
              color == Colors.white
                  ? const BorderSide(color: Colors.grey)
                  : BorderSide.none,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon), const SizedBox(width: 8), Text(text)],
      ),
    );
  }
}
