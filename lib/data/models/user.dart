import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid; // Unique user ID
  final String fullName; // User's full name
  final String email; // User's email
  final String profileImageUrl; // Optional: Profile picture URL
  final String role; // User type: regular, guest, premium, admin, botanist
  final bool verified; // Whether the user is verified
  final DateTime createdAt; // Account creation timestamp
  final DateTime lastUpdatedAt; // Last profile update timestamp

  // Preferences
  final String preferredLanguage; // Preferred language (e.g., 'en', 'es')
  final bool notificationsEnabled; // Notification preference

  // Search History
  final List<Map<String, dynamic>> searchHistory; // List of past searches

  const User({
    required this.uid,
    required this.fullName,
    required this.email,
    this.profileImageUrl = '',
    required this.role,
    required this.verified,
    required this.createdAt,
    required this.lastUpdatedAt,
    this.preferredLanguage = 'en',
    this.notificationsEnabled = true,
    this.searchHistory = const [],
  });

  /// Parses a Firestore snapshot into a User object.
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    DateTime? parseDate(dynamic value) {
      if (value != null) {
        Timestamp timestamp = value as Timestamp;
        return timestamp.toDate();
      }
      return null;
    }

    return User(
      uid: snap.id,
      fullName: snapshot['fullName'],
      email: snapshot['email'],
      profileImageUrl: snapshot['profileImageUrl'] ?? '',
      role: snapshot['role'] ?? 'regular',
      verified: snapshot['verified'] ?? false,
      createdAt: parseDate(snapshot['createdAt']) ?? DateTime.now(),
      lastUpdatedAt: parseDate(snapshot['lastUpdatedAt']) ?? DateTime.now(),
      preferredLanguage: snapshot['preferredLanguage'] ?? 'en',
      notificationsEnabled: snapshot['notificationsEnabled'] ?? true,
      searchHistory: (snapshot['searchHistory'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
    );
  }

  /// Converts the User object to a JSON-compatible map for Firestore.
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'role': role,
      'verified': verified,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastUpdatedAt': Timestamp.fromDate(lastUpdatedAt),
      'preferredLanguage': preferredLanguage,
      'notificationsEnabled': notificationsEnabled,
      'searchHistory': searchHistory,
    };
  }

  /// Adds a new search record to the user's search history.
  User addSearchHistory(Map<String, dynamic> search) {
    return User(
      uid: uid,
      fullName: fullName,
      email: email,
      profileImageUrl: profileImageUrl,
      role: role,
      verified: verified,
      createdAt: createdAt,
      lastUpdatedAt: lastUpdatedAt,
      preferredLanguage: preferredLanguage,
      notificationsEnabled: notificationsEnabled,
      searchHistory: [...searchHistory, search],
    );
  }
}
