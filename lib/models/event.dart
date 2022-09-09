import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  String? documentId;
  late String name;
  late String description;
  late String imageUrl;
  late String lat;
  late String lng;
  late String qrcode;
  late Timestamp eventDatetime;
  late Timestamp createdAt;
  late Timestamp updatedAt;

  Event({
    required this.documentId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.lat,
    required this.lng,
    required this.qrcode,
    required this.eventDatetime,
    required this.createdAt,
    required this.updatedAt,
  });

  Event.fromDocumentSnapshot({required QueryDocumentSnapshot<Object?> documentSnapshot}){
    documentId = documentSnapshot.id;
    name = documentSnapshot["name"];
    description = documentSnapshot["description"];
    imageUrl = documentSnapshot["image_url"];
    lat = documentSnapshot["lat"];
    lng = documentSnapshot["lng"];
    qrcode = documentSnapshot["qrcode"];
    eventDatetime = documentSnapshot["event_datetime"];
    createdAt = documentSnapshot["created_at"];
    updatedAt = documentSnapshot["updated_at"];
  }
}