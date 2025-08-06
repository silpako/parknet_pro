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

  // ------------- booking -------------------

  Future<String?> bookParking({
    required String parkingId,
    required String parkingName,
    required String slotTime,
    required int totalDays,
    required String vehicleNumber,
    required double totalAmount,
  }) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      await FirebaseFirestore.instance.collection('bookings').add({
        'userId': uid,
        'parkingId': parkingId,
        'parkingName': parkingName,
        'bookingDate': Timestamp.now(),
        'totalDays': totalDays,
        'vehicleNumber': vehicleNumber,
        'totalAmount': totalAmount,
        'slotTime': slotTime,
        'status': 'active',
      });

      return null;
    } catch (e) {
      print("error while add booking:- $e");
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> getMyBookings() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) return [];

    final snapshot =
        await FirebaseFirestore.instance
            .collection('bookings')
            .where('userId', isEqualTo: uid)
            .where('status', isEqualTo: 'active')
            .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getAllBookingsForAdmin() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('bookings')
              .where('status', isEqualTo: 'active')
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print("error while fetching bookings: $e");
      return [];
    }
  }

  Future<String?> cancelBooking(String bookingId) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return "User not logged in";

      final docRef = FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) return "Booking not found";

      final data = docSnapshot.data();
      if (data == null || data['userId'] != uid) {
        return "You can only cancel your own bookings";
      }

      await docRef.update({'status': 'cancelled'});

      return null;
    } catch (e) {
      print("Error occurred while cancelling: $e");
      return "Failed to cancel booking: $e";
    }
  }

  Future<List<Map<String, dynamic>>> getCancelledBookings() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return [];

      final snapshot =
          await FirebaseFirestore.instance
              .collection('bookings')
              .where('userId', isEqualTo: uid)
              .where('status', isEqualTo: 'cancelled')
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print("Error while fetching cancelled bookings: $e");
      return [];
    }
  }

  // -- complete bookings
  Future<String?> completeBooking(String bookingId) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId);
      await docRef.update({'status': 'completed'});
      return null;
    } catch (e) {
      print("Error completing booking: $e");
      return e.toString();
    }
  }

  // --- scheduler ---

  Future<void> checkAndUpdateBookingStatus() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final now = DateTime.now();

    final snapshot =
        await FirebaseFirestore.instance
            .collection('bookings')
            .where('userId', isEqualTo: uid)
            .where('status', isEqualTo: 'active')
            .get();

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final bookingDate = (data['bookingDate'] as Timestamp).toDate();
      final totalDays = data['totalDays'] as int;

      final endTime = bookingDate.add(Duration(days: totalDays));
      if (now.isAfter(endTime)) {
        final fineAmount = calculateFine(now, endTime);

        await doc.reference.update({
          'status': 'fined',
          'fineAmount': fineAmount,
        });
      }
    }
  }

  int calculateFine(DateTime now, DateTime endTime) {
    final overdueHours = now.difference(endTime).inHours;
    return overdueHours * 10; // ₹10/hour fine
  }

  Future<List<Map<String, dynamic>>> getCompletedBooking() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return [];

      final snapshot =
          await FirebaseFirestore.instance
              .collection('bookings')
              .where('userId', isEqualTo: uid)
              .where('status', isEqualTo: 'completed')
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print("Error while fetching completed bookings: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchDashboardCounts() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final totalParkingsSnap = await firestore.collection('parkings').get();
      final totalParkings = totalParkingsSnap.size;

      final activeBookingsSnap =
          await firestore
              .collection('bookings')
              .where('status', isEqualTo: 'active')
              .get();
      final currentlyParked = activeBookingsSnap.size;

      final cancelledBookingsSnap =
          await firestore
              .collection('bookings')
              .where('status', isEqualTo: 'cancelled')
              .get();
      final cancelledBookings = cancelledBookingsSnap.size;

      final completedBookingsSnap =
          await firestore
              .collection('bookings')
              .where('status', isEqualTo: 'completed')
              .get();
      double totalRevenue = 0.0;
      for (final doc in completedBookingsSnap.docs) {
        final data = doc.data();
        final amount = data['totalAmount'];
        if (amount is int || amount is double) {
          totalRevenue += (amount as num).toDouble();
        }
      }
      return {
        'totalParkings': totalParkings,
        'currentlyParked': currentlyParked,
        'cancelledBookings': cancelledBookings,
        'totalRevenue': totalRevenue,
      };
    } catch (e) {
      print("error occured while fetching the counts:- $e");
      return {
        'totalParkings': 0,
        'currentlyParked': 0,
        'cancelledBookings': 0,
        'totalRevenue': 0.0,
      };
    }
  }
}
