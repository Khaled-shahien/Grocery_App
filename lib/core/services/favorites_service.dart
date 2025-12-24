import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get the current user's UID
  String? get currentUserUID => _auth.currentUser?.uid;

  /// Add a product to the user's favorites
  Future<void> addProductToFavorites(ProductModel product) async {
    final userUID = currentUserUID;
    if (userUID == null) {
      throw Exception('User not authenticated');
    }

    try {
      await _firestore
          .collection('favorites')
          .doc(userUID)
          .collection('userFavorites')
          .doc(product.id)
          .set(product.toJson());
    } catch (e) {
      throw Exception('Failed to add product to favorites: $e');
    }
  }

  /// Remove a product from the user's favorites
  Future<void> removeProductFromFavorites(String productId) async {
    final userUID = currentUserUID;
    if (userUID == null) {
      throw Exception('User not authenticated');
    }

    try {
      await _firestore
          .collection('favorites')
          .doc(userUID)
          .collection('userFavorites')
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove product from favorites: $e');
    }
  }

  /// Check if a product is in the user's favorites
  Future<bool> isProductInFavorites(String productId) async {
    final userUID = currentUserUID;
    if (userUID == null) {
      throw Exception('User not authenticated');
    }

    try {
      final doc = await _firestore
          .collection('favorites')
          .doc(userUID)
          .collection('userFavorites')
          .doc(productId)
          .get();
      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check if product is in favorites: $e');
    }
  }

  /// Get all favorite products for the current user
  Stream<List<ProductModel>> getFavoriteProducts() {
    final userUID = currentUserUID;
    if (userUID == null) {
      throw Exception('User not authenticated');
    }

    return _firestore
        .collection('favorites')
        .doc(userUID)
        .collection('userFavorites')
        .orderBy('name') // Order by name for consistent display
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ProductModel.fromJson(doc.data()))
              .toList();
        });
  }

  /// Toggle favorite status of a product
  Future<bool> toggleFavorite(ProductModel product) async {
    final userUID = currentUserUID;
    if (userUID == null) {
      throw Exception('User not authenticated');
    }

    try {
      final docRef = _firestore
          .collection('favorites')
          .doc(userUID)
          .collection('userFavorites')
          .doc(product.id);

      final doc = await docRef.get();
      if (doc.exists) {
        await docRef.delete();
        return false; // Removed from favorites
      } else {
        await docRef.set(product.toJson());
        return true; // Added to favorites
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite status: $e');
    }
  }

  /// Get favorite products count
  Stream<int> getFavoritesCount() {
    final userUID = currentUserUID;
    if (userUID == null) {
      throw Exception('User not authenticated');
    }

    return _firestore
        .collection('favorites')
        .doc(userUID)
        .collection('userFavorites')
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  /// Batch add multiple products to favorites
  Future<void> addMultipleProductsToFavorites(
    List<ProductModel> products,
  ) async {
    final userUID = currentUserUID;
    if (userUID == null) {
      throw Exception('User not authenticated');
    }

    try {
      final batch = _firestore.batch();
      for (final product in products) {
        batch.set(
          _firestore
              .collection('favorites')
              .doc(userUID)
              .collection('userFavorites')
              .doc(product.id),
          product.toJson(),
        );
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to add multiple products to favorites: $e');
    }
  }

  /// Clear all favorites
  Future<void> clearAllFavorites() async {
    final userUID = currentUserUID;
    if (userUID == null) {
      throw Exception('User not authenticated');
    }

    try {
      final collectionRef = _firestore
          .collection('favorites')
          .doc(userUID)
          .collection('userFavorites');

      final docs = await collectionRef.get();
      final batch = _firestore.batch();

      for (final doc in docs.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to clear all favorites: $e');
    }
  }
}
