
import 'package:event_listing_app/features/auth/data/auth_repository.dart';
import 'package:event_listing_app/features/auth/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthController(repo);
});

class AuthController {
  final AuthRepository _repo;
  AuthController(this._repo);

  Future<void> signInWithGoogle() async {
    await _repo.signInWithGoogle();
  }
  Future<void> signOut() async {
    await _repo.signOut();
  }
}