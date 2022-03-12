import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_clone/utilities/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        icon: const Icon(FontAwesomeIcons.google),
        onPressed: () => onPressed(),
        label: Text(
          text,
          style: GoogleFonts.nunito(fontSize: 22),
        ),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: buttonColor),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
