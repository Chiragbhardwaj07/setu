import 'package:flutter/material.dart';
import 'package:vasu/features/learning_section/widget/learning_level_tile.dart';
import 'package:vasu/shared/appbar/view_appbar.dart';
import 'package:vasu/shared/constants/app_proportions.dart';

class BeginnerLevelScreen extends StatefulWidget {
  final String level;
  const BeginnerLevelScreen({super.key, required this.level});

  @override
  State<BeginnerLevelScreen> createState() => _BeginnerLevelScreenState();
}

class _BeginnerLevelScreenState extends State<BeginnerLevelScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                  onTap: () {},
                  ImgPath: 'assets/images/level_photo1.png',
                  level: widget.level,
                  display:'Level 1' ,
                  isLocked: false),
              LevelTile(
                  onTap: () {},
                  ImgPath: 'assets/images/level_photo2.png',
                  level: widget.level,
                  display: 'Level 2',
                  isLocked: true),
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
                  isLocked: false),
              LevelTile(
                  onTap: () {},
                  ImgPath: 'assets/images/level_photo1.png',
                  level: widget.level,
                  display: 'Level 4',
                  isLocked: true),
            ],
          ),
        ),
      ])),
    );
  }
}
