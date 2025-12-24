import 'package:firebase_auth/firebase_auth.dart';

import '../errors/custom_exception.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomExceptions(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomExceptions(
          message: 'This account already exists for that email.',
        );
      } else if (e.code == 'invalid-email') {
        throw CustomExceptions(message: 'The email address is not valid.');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions(
          message: 'Please check your internet connection.',
        );
      } else {
        throw CustomExceptions(
          message:
              'Something went wrong, please try again. Error: ${e.message}',
        );
      }
    } catch (e) {
      throw CustomExceptions(
        message: 'Something went wrong, please try again. Error: $e',
      );
    }
  }

  Future<User> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw CustomExceptions(message: 'Invalid email or password.');
      } else if (e.code == 'invalid-credential') {
        throw CustomExceptions(
          message: 'Incorrect email or password. Please try again.',
        );
      } else if (e.code == 'user-disabled') {
        throw CustomExceptions(message: 'This account has been disabled.');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions(
          message: 'Please check your internet connection.',
        );
      } else {
        throw CustomExceptions(
          message:
              'Something went wrong, please try again. Error: ${e.message}',
        );
      }
    } catch (e) {
      throw CustomExceptions(
        message: 'Something went wrong, please try again. Error: $e',
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw CustomExceptions(message: 'Failed to sign out. Error: $e');
    }
  }

  User? get currentUser => _auth.currentUser;
}
