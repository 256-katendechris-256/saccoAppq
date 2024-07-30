import 'package:flutter/cupertino.dart';

import 'constants.dart';


class NextButton extends StatelessWidget {
  final VoidCallback nextQuestion;

  const NextButton({super.key, required this.nextQuestion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextQuestion,
      child: Container(
        width: double.infinity,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: nuatral,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Center(
          child: Text(
            "Next Question",
            textAlign: TextAlign.center,
            style: TextStyle(
             fontSize: 26.0,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
      ),
    );
  }
}
