import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jitsi_methods.dart';
import 'package:zoom_clone/utilities/colors.dart';
import 'package:zoom_clone/widgets/meeting_options.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiAPI _jitsiAPI = JitsiAPI();
  late TextEditingController _meetingIdController;
  late TextEditingController _nameController;

  bool muteAudio = true;
  bool muteVideo = true;

  onAudioMuted(_) => setState(() => muteAudio = !muteAudio);

  onVideoMuted(_) => setState(() => muteVideo = !muteVideo);

  _joinMeeting({required BuildContext context}) async {
    _jitsiAPI.createNewMeeting(
      context: context,
      muteAudio: muteAudio,
      muteVideo: muteVideo,
      username: _nameController.text,
      room: _meetingIdController.text,
    );
  }

  @override
  void initState() {
    _meetingIdController = TextEditingController();
    _nameController =
        TextEditingController(text: _authMethods.currentUser?.displayName);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _meetingIdController.dispose();
    _nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          'Join a Meeting',
          style: GoogleFonts.nunito(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: _meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Meeting ID',
                fillColor: secondaryBackgrounndColor,
                filled: true,
                hintStyle: GoogleFonts.nunito(fontSize: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: _nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                fillColor: secondaryBackgrounndColor,
                filled: true,
                hintStyle: GoogleFonts.nunito(fontSize: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => _joinMeeting(context: context),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Join',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MeetingOption(
            text: 'Mute Audio?',
            mute: muteAudio,
            onChanged: onAudioMuted,
          ),
          MeetingOption(
            text: 'Mute Video?',
            mute: muteVideo,
            onChanged: onVideoMuted,
          ),
        ],
      ),
    );
  }
}
