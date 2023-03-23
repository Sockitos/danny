import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() {
    return firebaseAuth.authStateChanges();
  }

  Future<User> signInAnonymously() async {
    final userCredential = await firebaseAuth.signInAnonymously();
    return userCredential.user!;
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user!;
  }

  Future<User> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user!;
  }

  Future<void> sendPasswordResetEmail(String email) =>
      firebaseAuth.sendPasswordResetEmail(email: email);

  User? get currentUser => firebaseAuth.currentUser;

  Future<void> signOut() => firebaseAuth.signOut();
}
