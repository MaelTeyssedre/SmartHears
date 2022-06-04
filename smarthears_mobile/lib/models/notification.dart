import 'package:equatable/equatable.dart';

class ExparienceNotification extends Equatable {
  final String id;
  final String exparienceId;
  final String imageUrl;
  final DateTime createdDate;
  final bool read;
  final String title;
  final String body;

  ExparienceNotification(
      {required this.id,
      required this.exparienceId,
      required this.imageUrl,
      required this.createdDate,
      required this.read,
      required this.title,
      required this.body});

  factory ExparienceNotification.fromJson(Map<String, dynamic> json) {
    try {
      var exparience = ExparienceNotification(
          id: json['id'],
          exparienceId: json['exparienceId'],
          imageUrl: json['imageUrl'],
          createdDate: DateTime.parse(json['createdDate']),
          read: json['read'],
          title: json['title'],
          body: json['body']);
      return exparience;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  List<Object> get props => [id, exparienceId, imageUrl, createdDate, read, title, body];

  @override
  String toString() {
    return "$id, $exparienceId, $imageUrl, $createdDate, $read, $title, $body";
  }
}

class Subscription extends Equatable {
  final String id;
  final int userId;
  final List<String> expariences;
  final List<int> myDesigns;
  final List<FirebaseDevice> deviceIds;
  final DateTime createdDate;

  Subscription(
      {required this.id,
      required this.userId,
      required this.expariences,
      required this.myDesigns,
      required this.deviceIds,
      required this.createdDate});

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
        id: json['id'],
        userId: json['userId'],
        expariences: List<String>.from(json['expariences']),
        myDesigns: List<int>.from(json['myDesigns']),
        deviceIds: List<FirebaseDevice>.from((json['deviceIds'] as List).map((e) => FirebaseDevice.fromJson(e))),
        createdDate: DateTime.parse(json['createdDate']));
  }

  @override
  List<Object> get props => [userId, expariences, myDesigns, deviceIds, createdDate];

  @override
  String toString() {
    return "$id, $userId, $expariences, $myDesigns, ${deviceIds.map((e) => e.toString())}, ${createdDate.toString()}";
  }
}

class FirebaseDevice extends Equatable {
  final String id;
  final String deviceId;
  final String firebaseToken;
  final String phoneModel;
  final String sdkVersion;
  final String language;
  final String application;
  final DateTime createdDate;

  FirebaseDevice(
      {required this.id,
      required this.deviceId,
      required this.firebaseToken,
      required this.phoneModel,
      required this.sdkVersion,
      required this.language,
      required this.application,
      required this.createdDate});

  factory FirebaseDevice.fromJson(Map<String, dynamic> json) => FirebaseDevice(
      id: json['_id'],
      deviceId: json['deviceId'],
      firebaseToken: json['firebaseToken'],
      phoneModel: json['phoneModel'],
      sdkVersion: json['sdkVersion'],
      language: json['language'],
      application: json['application'],
      createdDate: DateTime.parse(json['createdDate']));

  @override
  List<Object> get props => [id, deviceId, firebaseToken, phoneModel, sdkVersion, language, application, createdDate];

  @override
  String toString() =>
      "$id, $deviceId, $firebaseToken, $phoneModel, $sdkVersion, $language, $application, ${createdDate.toString()}";
}
