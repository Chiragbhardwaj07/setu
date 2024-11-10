import 'package:flutter/material.dart';
import 'package:vasu/features/learning_section/views/beginner_level_screen.dart';
import 'package:vasu/shared/appbar/view_appbar.dart';
import 'package:vasu/shared/constants/app_colors.dart';
import 'package:vasu/shared/constants/app_proportions.dart';

class LearningSectionScreen extends StatefulWidget {
  const LearningSectionScreen({super.key});

  @override
  State<LearningSectionScreen> createState() => _LearningSectionScreenState();
}

class _LearningSectionScreenState extends State<LearningSectionScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        appbar(
          initialFloatingIcon: Icons.tips_and_updates_rounded,
          onFloatingButtonPressed: () {},
          Title: "Learning Section",
          ImgPath: "assets/icons/Hamburger.png",
          HamBurgerAction: () {},
        ),
        SizedBox(height: AppProportions.verticalSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Custom Tab for "Learning Paths" with dynamic styling based on _selectedIndex
              GestureDetector(
                onTap: () {
                  _tabController?.animateTo(0);
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0
                        ? AppColors.PrimaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Learning Paths",
                    style: TextStyle(
                      color: _selectedIndex == 0
                          ? Colors.white
                          : AppColors.PrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Custom Tab for "Gamify Quiz" with dynamic styling based on _selectedIndex
              GestureDetector(
                onTap: () {
                  _tabController?.animateTo(1);
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 1
                        ? AppColors.PrimaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Gamify Quiz",
                    style: TextStyle(
                      color: _selectedIndex == 1
                          ? Colors.white
                          : AppColors.PrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_tabController !=
            null) // Only show TabBarView if _tabController is initialized
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Column(
                  children: [
                    // Learning Paths Content
                    SizedBox(
                      height: AppProportions.verticalSpacing,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 200,
                            width: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/learning_courses.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            height: 200,
                            width: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/learning_img2.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Gamify Quiz Content
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BeginnerLevelScreen(
                                    level: "Beginner Level"))),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/gamify_beginner.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BeginnerLevelScreen(
                                    level: "Intermidiate Level"))),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/gamify_intermidiate.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BeginnerLevelScreen(
                                    level: "Advance Level"))),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/gamify_advance.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
      ],
    ));
  }
}
