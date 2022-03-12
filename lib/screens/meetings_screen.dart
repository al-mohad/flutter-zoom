import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_clone/resources/jitsi_methods.dart';

import '../widgets/meeting_button.dart';

class MeetingsScreen extends StatelessWidget {
  MeetingsScreen({Key? key}) : super(key: key);

  final JitsiAPI _jitsiAPI = JitsiAPI();

  final TextEditingController _meetingSubject = TextEditingController();

  createNnewMeeting({required BuildContext context}) async {
    Random random = Random();
    String roomName = '${random.nextInt(9999 + 10000000)}';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Meeting Subject'),
            content: TextField(
              autofocus: true,
              controller: _meetingSubject,
              decoration: const InputDecoration(
                hintText: 'Enter Meeting Subject',
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => _jitsiAPI.createNewMeeting(
                  room: roomName,
                  context: context,
                  muteAudio: true,
                  muteVideo: true,
                ),
                child: const Text('No Subject'),
              ),
              ElevatedButton(
                onPressed: () => _jitsiAPI.createNewMeeting(
                  room: roomName,
                  subject: _meetingSubject.text,
                  context: context,
                  muteAudio: true,
                  muteVideo: true,
                ),
                child: const Text('Confirm'),
              ),
            ],
          );
        });
  }

  joinMeeting({required BuildContext context}) async {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MeetinngButtonn(
              onPressed: () => createNnewMeeting(context: context),
              text: 'New Meeting',
              icon: FontAwesomeIcons.video,
            ),
            MeetinngButtonn(
              onPressed: () => joinMeeting(context: context),
              text: 'Join Meeting',
              icon: FontAwesomeIcons.users,
            ),
            MeetinngButtonn(
              onPressed: () {},
              text: 'Schedule',
              icon: FontAwesomeIcons.calendarDay,
            ),
            MeetinngButtonn(
              onPressed: () {},
              text: 'Share Screen',
              icon: FontAwesomeIcons.arrowUp,
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Text(
              'Create or Join Meetings',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
