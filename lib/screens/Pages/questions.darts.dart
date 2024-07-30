import 'package:flutter/material.dart';


import '../../modles/questions.dart';
import '../../widgets/constants.dart';
import '../../widgets/next_button.dart';
import '../../widgets/option_card_widget.dart';
import '../../widgets/question_widget.dart';
import 'items.dart';

class LoanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loan Page')),
      body: Center(child: Text('Welcome to the Loan Page')),
    );
  }
}



class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final List<Questions> _questions = [
    Questions(id: '10', title: 'What is your age bracket?', options: {
      '18-23': 0,
      '24-29': 0,
      '30-33': 3,
      '34-above': 1,
    }, weight: 1.0),
    Questions(id: '11', title: 'Do you have a business?', options: {
      'Yes': 1,
      'No': 0,
      'Not yet': 1,
      'I don’t know': 1,
    }, weight: 2.0),
    Questions(id: '12', title: 'What is your age bracket?', options: {
      '18-23': 0,
      '24-29': 0,
      '30-33': 1,
      '34-above': 1,
    }, weight: 1.0),
  ];

  int index = 0;
  String selectedOption = '';
  double weightedScore = 0.0;
  double totalWeight = 0.0;

  @override
  void initState() {
    super.initState();
    totalWeight = _questions.fold(0.0, (sum, item) => sum + item.weight);
  }

  void nextQuestionN() {
    if (selectedOption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an option to continue'),
        ),
      );
      return;
    }

    setState(() {
      if (index < _questions.length - 1) {
        index++;
        selectedOption = '';
      } else {
        // Show dialog with final score
        double finalScore = weightedScore / totalWeight;
        String riskLevel = finalScore < 0.2 ? 'Low Risk' : 'High Risk';

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Quiz Completed'),
            content: Text('Your final weighted score is ${finalScore.toStringAsFixed(2)}. Risk level: $riskLevel'),
            actions: [
              TextButton(
                onPressed: () {
                  if (riskLevel == 'Low Risk') {
                    Navigator.popAndPushNamed(context, 'items');

                  } else {
                    Navigator.popAndPushNamed(context, 'GetAlOAN');
                  }
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  void selectOption(String option) {
    setState(() {
      double totalOptionsWeight = _questions[index].options.values.fold(0, (sum, item) => sum + item).toDouble();

      if (selectedOption.isNotEmpty) {
        weightedScore -= ((_questions[index].options[selectedOption] ?? 0) / totalOptionsWeight) * _questions[index].weight;
      }
      selectedOption = option;
      weightedScore += ((_questions[index].options[selectedOption] ?? 0) / totalOptionsWeight) * _questions[index].weight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text('Score: ${weightedScore.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
          )
        ],
        title: const Text('Loan Questions',
          style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Question_widget(
              indexofaction: index,
              question: _questions[index].title,
              totalquestions: _questions.length,
            ),
            const Divider(color: Colors.white),
            const SizedBox(height: 25.0),
            // Adding the options
            Column(
              children: _questions[index].options.keys.map((option) {

                return OptionCardWidget(
                  option: option,
                  onTap: () => selectOption(option),
                  color: selectedOption == option ? Colors.blue : Colors.white,
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(nextQuestion: nextQuestionN),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
