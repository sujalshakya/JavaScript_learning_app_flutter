import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Coin extends StatelessWidget {
  final String text;
  const Coin({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        image: const DecorationImage(
          image: AssetImage('assets/icons/coin.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 4.0),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.abrilFatface(fontSize: 10, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
