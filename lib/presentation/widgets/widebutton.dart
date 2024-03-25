import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String text;
  final double screenHeight;
  final VoidCallback onPressed;

  const WideButton({
    Key? key,
    required this.text,
    required this.screenHeight,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF644AFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        ),
        child: Text(text),
      ),
    );
  }
}
