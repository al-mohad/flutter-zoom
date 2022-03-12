import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_clone/screens/history_screen.dart';
import 'package:zoom_clone/screens/meetings_screen.dart';
import 'package:zoom_clone/utilities/colors.dart';
import 'package:zoom_clone/widgets/meeting_button.dart';

import '../resources/auth_methods.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  onPageChange({required index}) => setState(() => _currentIndex = index);

  final List<Widget> _pages = [
    MeetingsScreen(),
    const HistoryScreen(),
    const Text('Contacts'),
    CustomButton(text: 'Log Out', onPressed: () => AuthMethods().signOut()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Meet & Chat'),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (i) => onPageChange(index: i),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidCommentAlt),
            label: 'Meet & Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userFriends),
            label: 'Meetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.users),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cogs),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
