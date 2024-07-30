import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Question_widget extends StatelessWidget {
  const Question_widget({
    super.key,
    required this.question,
    required this.indexofaction,
    required this.totalquestions,
  });

  final String question;
  final int indexofaction;
  final int totalquestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Question ${indexofaction + 1}/$totalquestions: $question',
        style: TextStyle(
          fontSize: 24,
          color: Colors.white
        ),
      ),
    );
  }
}
