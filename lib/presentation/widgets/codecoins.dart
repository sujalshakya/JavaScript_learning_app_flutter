import 'package:flutter/material.dart';

class CodeCoin extends StatelessWidget {
  const CodeCoin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        image: const DecorationImage(
          image: AssetImage('assets/icons/codecoins.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
