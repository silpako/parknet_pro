import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Register
  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);

      // Or store name in Firestore:
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userCredential.user!.uid)
      //     .set({'name': name, 'email': email});

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Login
  Future<String?> loginUser({
    required String emaill,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: emaill, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign Out
  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
