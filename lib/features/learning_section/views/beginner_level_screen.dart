import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vasu/features/learning_section/views/questions.dart';
import 'package:vasu/features/learning_section/widget/learning_level_tile.dart';
import 'package:vasu/shared/appbar/view_appbar.dart';
import 'package:vasu/shared/constants/app_proportions.dart';
import 'package:http/http.dart' as http;

class BeginnerLevelScreen extends StatefulWidget {
  final String level;
  const BeginnerLevelScreen({super.key, required this.level});

  @override
  State<BeginnerLevelScreen> createState() => _BeginnerLevelScreenState();
}

class _BeginnerLevelScreenState extends State<BeginnerLevelScreen> {
  final _storage = FlutterSecureStorage();

  Future<void> _fetchQuestions(String difficulty) async {
    final token = await _storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('https://setu-2br3.onrender.com/quiz/questions/$difficulty'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final questions = json.decode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuestionScreen(level: widget.level, questions: questions),
        ),
      );
    } else {
      // Handle error
      print('Failed to load questions');
    }
  }

  String getDifficulty() {
    switch (widget.level) {
      case 'Beginner Level':
        return 'easy';
      case 'Intermediate Level':
        return 'medium';
      case 'Advance Level':
        return 'hard';
      default:
        return 'easy';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            appbar(
              initialFloatingIcon: Icons.compare_arrows_rounded,
              onFloatingButtonPressed: () {},
              Title: widget.level,
              HamBurgerAction: () {
                Navigator.pop(context);
              },
              ImgPath: "assets/icons/back.png",
            ),
            SizedBox(
              height: AppProportions.verticalSpacing,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LevelTile(
                    onTap: () => _fetchQuestions(getDifficulty()),
                    ImgPath: 'assets/images/level_photo1.png',
                    level: widget.level,
                    display: 'Level 1',
                    isLocked: false,
                  ),
                  LevelTile(
                    onTap: () {},
                    ImgPath: 'assets/images/level_photo2.png',
                    level: widget.level,
                    display: 'Level 2',
                    isLocked: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LevelTile(
                    onTap: () {},
                    ImgPath: 'assets/images/level_photo2.png',
                    level: widget.level,
                    display: 'Level 3',
                    isLocked: false,
                  ),
                  LevelTile(
                    onTap: () {},
                    ImgPath: 'assets/images/level_photo1.png',
                    level: widget.level,
                    display: 'Level 4',
                    isLocked: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
