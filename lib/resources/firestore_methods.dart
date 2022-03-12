import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_clone/models/meeting.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingsHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('meetings')
      .snapshots();

  void saveMeetingToHistory({required Meeting meeting}) async {
    try {
      DocumentReference _ref = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('meetings')
          .add({
        'meetingName': meeting.subject,
        'createdAt': meeting.timeStamp,
      });
      await _ref.set({
        'meetingId': _ref.id,
        'meetingName': meeting.subject,
        'createdAt': meeting.timeStamp,
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }
}
