import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<String?> postParking({
    required String parkingName,
    required String description,
    required String location,
    required double amount,
    required double fineAmount,
  }) async {
    try {
      // Check if parkingName already exists
      final existing =
          await FirebaseFirestore.instance
              .collection('parkings')
              .where('parkingName', isEqualTo: parkingName)
              .get();

      if (existing.docs.isNotEmpty) {
        return "Parking name already exists.";
      }

      final docRef = FirebaseFirestore.instance.collection('parkings').doc();
      final String newId = docRef.id;

      await docRef.set({
        'id': newId,
        'parkingName': parkingName,
        'description': description,
        'location': location,
        'amount': amount,
        'fineAmount': fineAmount,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("--> added completed with id: $newId");
      return null; // success
    } catch (e) {
      print("error -> $e");
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> getParking() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('parkings')
              .orderBy('createdAt', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        return {'id': doc.id, ...doc.data()};
      }).toList();
    } catch (e) {
      print("getParking error -> $e");
      return [];
    }
  }

  Future<String?> deleteParking(String id) async {
    try {
      await FirebaseFirestore.instance.collection('parkings').doc(id).delete();
      return null;
    } catch (e) {
      print("deleteParking error -> $e");
      return e.toString();
    }
  }

  Future<String?> updateParking(
    String id,
    String name,
    String description,
    String location,
    String amount,
    String fineAmount,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('parkings').doc(id).update({
        'parkingName': name,
        'description': description,
        'location': location,
        'amount': double.tryParse(amount) ?? 0,
        'fineAmount': double.tryParse(fineAmount) ?? 0,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
