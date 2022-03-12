import 'package:another_flushbar/flushbar_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/models/meeting.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class JitsiAPI {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  void createNewMeeting({
    bool? muteAudio,
    bool? muteVideo,
    String? username,
    required String room,
    required BuildContext context,
    String? subject,
  }) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      // user def chk
      String? name = '';
      String? meetingId = '';
      if (username != null) {
        name = username;
      } else {
        name = _authMethods.currentUser!.displayName;
      }

      if (subject != null && subject.trim().isNotEmpty) {
        meetingId = subject;
      } else {
        meetingId = 'Meeting has no subject';
      }
      var options = JitsiMeetingOptions(room: room)
        ..subject = meetingId
        ..userDisplayName = name
        ..userEmail = _authMethods.currentUser?.email
        ..userAvatarURL = _authMethods.currentUser?.photoURL
        ..audioMuted = muteAudio
        ..videoMuted = muteVideo;
      // ..featureFlag = featureFlag;
      Meeting meeting = Meeting(
        subject: meetingId,
        timeStamp: Timestamp.now(),
      );
      _firestoreMethods.saveMeetingToHistory(meeting: meeting);
      FlushbarHelper.createSuccess(message: 'Welcome $name').show(context);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      FlushbarHelper.createError(message: error.toString()).show(context);
    }
  }
}
