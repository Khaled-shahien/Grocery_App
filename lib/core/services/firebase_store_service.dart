import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/core/constants/backend_endpoints.dart';
import 'package:grocery_app/features/auth/data/models/user_model.dart';

class FirebaseStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserData({
    required Map<String, dynamic> data,
    required String docId,
  }) async {
    try {
      await _firestore
          .collection(BackEndEndPoints.userCollection)
          .doc(docId)
          .set(data);
    } catch (e) {
      throw Exception('Failed to add user data: $e');
    }
  }

  Future<UserModel> getUserData({required String docId}) async {
    try {
      final DocumentSnapshot user = await _firestore
          .collection(BackEndEndPoints.userCollection)
          .doc(docId)
          .get();
      if (!user.exists) {
        throw Exception('User document does not exist');
      }
      final userData = user.data() as Map<String, dynamic>?;
      if (userData == null) {
        throw Exception('User data is null');
      }
      return UserModel.fromJson(userData);
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }
}
