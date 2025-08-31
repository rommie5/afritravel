import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_storage/firebase_storage.dart';
import '../models/destination.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get all destinations
  Stream<List<Destination>> getDestinations() {
    return _firestore
        .collection('destinations')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Destination.fromFirestore(doc))
            .toList());
  }

  // Get featured destinations
  Future<List<Destination>> getFeaturedDestinations() async {
    final snapshot = await _firestore
        .collection('destinations')
        .where('isFeatured', isEqualTo: true)
        .limit(5)
        .get();
    
    return snapshot.docs
        .map((doc) => Destination.fromFirestore(doc))
        .toList();
  }

  // Add to favorites
  Future<void> addToFavorites(String destinationId) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(destinationId)
          .set({
        'destinationId': destinationId,
        'addedAt': DateTime.now(),
      });
    }
  }

  // Remove from favorites
  Future<void> removeFromFavorites(String destinationId) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(destinationId)
          .delete();
    }
  }

  // Get user favorites
  Stream<List<String>> getUserFavorites() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);
    
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.id)
            .toList());
  }
}