import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vasu/features/authentication/controllers/language_selection_controller.dart';
import 'package:vasu/shared/constants/app_colors.dart';
import 'package:typing_text/typing_text.dart';
import 'package:vasu/shared/constants/app_proportions.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final LanguageSelectionController _languageController =
      Get.put(LanguageSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: AppProportions.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: AppProportions.screenWidth * 0.75,
                  height: AppProportions.screenHeight * 0.15,
                  child: TypingText(
                    words: [
                      ' Welcome',
                      '    स्वागत',
                      '    স্বাগত',
                      '    ಸ್ವಾಗತ',
                      'സ്വാഗതം',
                      '  સ્વાગત છે',
                    ],
                    letterSpeed: Duration(milliseconds: 100),
                    wordSpeed: Duration(milliseconds: 800),
                    style: GoogleFonts.mulish(
                        color: AppColors.PrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppProportions.screenWidth * 0.15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Choose Language'.tr,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Center(
                child: Obx(
                  () => Container(
                    width: AppProportions.screenWidth * 0.6,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        value: _languageController.selectedLanguage.value,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: Theme.of(context).primaryTextTheme.bodyLarge,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          _languageController.setSelectedLanguage(newValue!);
                        },
                        items: _languageController.languages
                            .map<DropdownMenuItem<String>>((language) {
                          String nativeName = language.keys.first;
                          return DropdownMenuItem<String>(
                            value: language.values.first,
                            child: Text(nativeName),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
                child: SizedBox(
                  width: AppProportions.screenWidth * 0.8,
                  child: ElevatedButton(
                      onPressed: () {
                        _languageController.proceedToNextScreen();
                      },
                      child: Text(
                        'Continue'.tr,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
