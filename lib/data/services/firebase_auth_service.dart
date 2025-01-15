import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantai/data/models/user.dart' as userModel;


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user
  Future<void> registerUser(
      String fullName,
      String phoneNumber,
      String email,
      String password,
      
      String role) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the generated UID
      String uid = userCredential.user!.uid;

      userModel.User user = userModel.User(
        uid: uid,
        fullName: fullName,
        email: email,
        role: role,
        verified: false,
        createdAt: DateTime.now(),
        lastUpdatedAt: DateTime.now(),

      );
      // Save user data to the "users" collection
      await _firestore.collection('users').doc(uid).set(user.toJson());

      // Save patient data to the "patients" collection (if the user is a patient)
     
    } catch (e) {
      print("Error registering user: $e");
      rethrow;
    }
  }
}