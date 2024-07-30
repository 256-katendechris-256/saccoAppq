import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../modles/survey.dart';

class SurveyListPage extends StatefulWidget {
  const SurveyListPage({super.key});

  @override
  State<SurveyListPage> createState() => _SurveyListPageState();
}

class _SurveyListPageState extends State<SurveyListPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _selectedSurveyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _firstItem1(),
                const SizedBox(height: 20),
                Expanded(child: _buildSurveyList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _firstItem1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: const Text(
            'Survey Lists',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_survey');
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          child: const Text(
            'Add New Survey',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSurveyList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection("survey").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final surveys = snapshot.data!.docs.map((doc) {
          return Survey.fromFirestore(doc.data() as Map<String, dynamic>);
        }).toList();

        return ListView.builder(
          itemCount: surveys.length,
          itemBuilder: (context, index) {
            final survey = surveys[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSurveyId = _selectedSurveyId == survey.surveyId ? null : survey.surveyId;
                });
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        survey.surveyId,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_selectedSurveyId == survey.surveyId) ...[
                        const SizedBox(height: 8),
                        Text("Respondent ID: ${survey.respondentId}"),
                        Text("Respondent Name: ${survey.respondentName}"),
                        Text("Date: ${survey.date}"),
                        Text("Start Time: ${survey.startTime}"),
                        Text("End Time: ${survey.endTime}"),
                        Text("Score: ${survey.score}"),
                        Text("Status: ${survey.status}"),
                        Text("Total Score: ${survey.totalScore}"),
                        Text("Score Percentage: ${survey.scorePercentage}"),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
