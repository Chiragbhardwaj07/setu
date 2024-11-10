import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  final String level;
  final List<dynamic> questions;

  const QuestionScreen({Key? key, required this.level, required this.questions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$level Questions')),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return ListTile(
            title: Text(question['text']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  List.generate(question['options'].length, (optionIndex) {
                final option = question['options'][optionIndex];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Image.network(option['imageUrl'], width: 120, height: 120),
                      SizedBox(width: 10),
                      Text('Option ${optionIndex + 1}'),
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
