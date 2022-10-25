import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foxbyte_event/models/event.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  Rx<List<Event>> eventList = Rx<List<Event>>([]);
  Rxn<Event> eventItem = Rxn<Event>();

  var isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getUserVisitedEvents() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('visited_events')
        .get()
        .then((QuerySnapshot querySnapshot) async {
          eventList.value = [];

          for (var event in querySnapshot.docs) {
            Event eventModel = Event.fromDocumentSnapshot(documentSnapshot: event);
            eventList.value.add(eventModel);
          }
        });
        
    return Future.delayed(const Duration(microseconds: 500), () {});
  }

  Future<Event?> getEventByQr({required String qrcode}) async {
    isLoading.value = true;
    await _firestore
        .collection('events')
        .where('qrcode', isEqualTo: qrcode)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        eventItem.value =
            Event.fromDocumentSnapshot(documentSnapshot: querySnapshot.docs[0]);

        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('visited_events')
            .doc(eventItem.value!.documentId)
            .set({
              'name': eventItem.value!.name,
              'description': eventItem.value!.description,
              'image_url': eventItem.value!.imageUrl,
              'lat': eventItem.value!.lat,
              'lng': eventItem.value!.lng,
              'qrcode': eventItem.value!.qrcode,
              'event_datetime': eventItem.value!.eventDatetime,
              'created_at': Timestamp.now(),
              'updated_at': Timestamp.now(),
            });
      }
    });

    isLoading.value = false;
    return eventItem.value;
  }
}
