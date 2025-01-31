import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantai/data/models/abstract/abstract.dart';

class Plant extends BaseModel {
  final String plantId; // Unique plant ID
  final String plantName; // Name of the plant //
  final String imageUrl; // URL for plant image //
  final String wateringFrequency; // e.g., "7 days"
  final String wateringAmount; // e.g., "200 mL"
  final DateTime lastWateredDate; // Last time the plant was watered
  final DateTime nextWateringDate; // Next watering date
  final String wateringStatus; // Overdue or On Schedule
  final bool waterReminderEnabled; // Reminder toggle
  final String growthStage; // e.g., "Seedling", "Mature"
  final bool infected; // Whether the plant is infected
  final String infectionStatus; // Description of the infection
  final List<Map<String, dynamic>> careHistory; // List of past care activities
  final bool favorite; // Whether the plant is marked as a favorite

  Plant({
    required this.plantId,
    required this.plantName,
    this.imageUrl = '',
    required this.wateringFrequency,
    required this.wateringAmount,
    required this.lastWateredDate,
    required this.nextWateringDate,
    required this.wateringStatus,
    this.waterReminderEnabled = true,
    required this.growthStage,
    this.infected = false,
    this.infectionStatus = '',
    this.careHistory = const [],
    this.favorite = false,
  });

  /// Parses a Firestore snapshot into a Plant object.
  static Plant fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    DateTime? parseDate(dynamic value) {
      if (value != null) {
        Timestamp timestamp = value as Timestamp;
        return timestamp.toDate();
      }
      return null;
    }

    return Plant(
      plantId: snap.id,
      plantName: snapshot['plantName'],
      imageUrl: snapshot['imageUrl'] ?? '',
      wateringFrequency: snapshot['wateringFrequency'] ?? '',
      wateringAmount: snapshot['wateringAmount'] ?? '',
      lastWateredDate: parseDate(snapshot['lastWateredDate']) ?? DateTime.now(),
      nextWateringDate: parseDate(snapshot['nextWateringDate']) ?? DateTime.now(),
      wateringStatus: snapshot['wateringStatus'] ?? 'Unknown',
      waterReminderEnabled: snapshot['waterReminderEnabled'] ?? true,
      growthStage: snapshot['growthStage'] ?? 'Unknown',
      infected: snapshot['infected'] ?? false,
      infectionStatus: snapshot['infectionStatus'] ?? '',
      careHistory: (snapshot['careHistory'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      favorite: snapshot['favorite'] ?? false,
    );
  }

  /// Converts the Plant object to a JSON-compatible map for Firestore.
  Map<String, dynamic> toJson() {
    return {
      'plantName': plantName,
      'imageUrl': imageUrl,
      'wateringFrequency': wateringFrequency,
      'wateringAmount': wateringAmount,
      'lastWateredDate': Timestamp.fromDate(lastWateredDate),
      'nextWateringDate': Timestamp.fromDate(nextWateringDate),
      'wateringStatus': wateringStatus,
      'waterReminderEnabled': waterReminderEnabled,
      'growthStage': growthStage,
      'infected': infected,
      'infectionStatus': infectionStatus,
      'careHistory': careHistory,
      'favorite': favorite,
    };
  }
}
