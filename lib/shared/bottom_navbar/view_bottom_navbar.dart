import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:vasu/features/dictonary/views/dictonary_screen.dart';
import 'package:vasu/features/home_screen/views/home-page.dart';
import 'package:vasu/features/learning_section/views/learning_section_screen.dart';
import 'package:vasu/features/profile/views/profile_page.dart';
import 'package:vasu/features/video_calling/views/video_calling_page.dart';
import 'package:vasu/shared/bottom_navbar/controller_bottom_navbar.dart';
import 'package:vasu/shared/constants/app_colors.dart';

// GetX Controller for managing the navigation state

// Main Bottom Navbar
class BottomNavbar extends StatefulWidget {
  BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final controller = Get.put(BottomNavController());

  @override
  void dispose() {
    controller.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Extend body to make FAB float over bottom bar
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // Dock FAB to the center
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.onTabSelected(2); // FAB navigates to 'Home' at index 2
        },
        backgroundColor: AppColors.PrimaryColor,
        child: Icon(Icons.home, color: Colors.white),
        shape: CircleBorder(),
      ),
      bottomNavigationBar: Obx(() {
        return StylishBottomBar(
          elevation: 26,
          option: AnimatedBarOptions(
            iconStyle: IconStyle.Default,
            //barAnimation: BarAnimation.liquid,
            opacity: 0.3, // Opacity for unselected icons
          ),
          items: [
            // Video Call
            BottomBarItem(
              showBadge: false,
              icon: Icon(Icons.videocam_rounded),
              selectedIcon: Icon(Icons.videocam_rounded),
              selectedColor: AppColors.PrimaryColor,
              unSelectedColor: Colors.grey,
              title: Text(
                'Connect'.tr,
              ),
            ),
            // Learning
            BottomBarItem(
              showBadge: false,
              icon: Icon(Icons.workspace_premium_rounded),
              selectedIcon: Icon(Icons.workspace_premium_rounded),
              selectedColor: AppColors.PrimaryColor,
              unSelectedColor: Colors.grey,
              title: Text(
                'Learning'.tr,
              ),
            ),
            // Placeholder for FAB
            BottomBarItem(
              showBadge: false,
              icon: SizedBox(
                width: 1, // Smaller width for closer icons
                height: 1, // Smaller height for closer alignment
              ),
              selectedIcon: Icon(null), // No icon for selected state
              selectedColor: Colors.transparent,
              unSelectedColor: Colors.transparent,
              title: Text(''), // Empty title
            ),
            // Dictionary
            BottomBarItem(
              showBadge: false,
              icon: Icon(Icons.menu_book_rounded),
              selectedIcon: Icon(Icons.menu_book_rounded),
              selectedColor: AppColors.PrimaryColor,
              unSelectedColor: Colors.grey,
              title: Text(
                'Dictionary'.tr,
              ),
            ),
            // Profile
            BottomBarItem(
              showBadge: false,
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person_outline),
              selectedColor: AppColors.PrimaryColor,
              unSelectedColor: Colors.grey,
              title: Text(
                'Profile'.tr,
              ),
            ),
          ],
          hasNotch: true, // Notch for FAB

          fabLocation: StylishBarFabLocation.center, // Center FAB location
          notchStyle: NotchStyle.circle, // Circle notch style
          currentIndex: controller.selectedIndex.value, // Sync index
          onTap: (index) {
            if (index != 2) {
              // Ignore FAB index as it's handled separately
              controller.onTabSelected(index);
            }
          },
          backgroundColor: Theme.of(context).colorScheme.surface,
        );
      }),

      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.selectedIndex.value = index;
          },
          children: [
            VideoCallingPage(), // Index 0
            LearningSectionScreen(), // Index 1
            Home_page(), // Index 2 (Home for FAB)
            DictionaryScreen(), // Index 3
            ProfilePage(), // Index 4
          ],
        ),
      ),
    );
  }
}
