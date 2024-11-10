import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vasu/features/authentication/controllers/language_selection_controller.dart';
import 'package:vasu/features/authentication/controllers/login_controller.dart';
import 'package:vasu/features/authentication/data/models/user_auth_model.dart';
import 'package:vasu/features/authentication/data/services/user_local_service.dart';
import 'package:vasu/features/profile/controllers/settings_controller.dart';
import 'package:vasu/shared/appbar/view_appbar.dart';
import 'package:vasu/shared/constants/app_colors.dart';
import 'package:vasu/shared/constants/app_proportions.dart';
import 'package:vasu/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vasu/utils/ui_hepers.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserLocalService _userLocalService = UserLocalService();
  final LanguageSelectionController _languageController = Get.find();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final SettingsController settingsController = Get.find();
  final LoginController loginController = Get.find();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();

  bool isGoogleSignIn = false;
  RxBool isUpdating = false.obs;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    var user = await _userLocalService.getUserFromHive();
    if (user != null) {
      setState(() {
        _nameController.text = user.name ?? '';
        _emailController.text = user.email ?? '';
        _phoneController.text = user.phone ?? '';
        _dobController.text = user.dob ?? '';

        isGoogleSignIn = user.uid != null;
        debugPrint(isGoogleSignIn.toString());
        debugPrint(user.uid);
      });
    }
  }

  void _saveUserInfo() async {
    isUpdating.value = true;
    // Trigger API call to update user info (implementation not shown here)

    try {
      // Fetch the token from secure storage
      var user = await _userLocalService.getUserFromHive();
      String? token = await SecureStorage.getAccessToken();
      debugPrint("Token retrieved: $token");

      if (token == null) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: 'No access token found!',
          backgroundColor: Colors.red,
        );
        return;
      }
      if (_nameController.text == user?.name &&
          _emailController.text == user?.email &&
          _phoneController.text == user?.phone &&
          _dobController.text == user?.dob &&
          _languageController.selectedLanguage.value == user?.language) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: 'No changes made!',
          backgroundColor: Colors.red,
        );
        return;
      }

      // Prepare data for the API call
      final Map<String, dynamic> requestData = {
        "phone": _phoneController.text.trim(),
        "name": _nameController.text.trim(),
        "dob": _dobController.text.trim(),
        "email": _emailController.text.trim(),
        "region": "India",
        "language": _languageController.selectedLanguage.value,
      };

      // Making the API request
      final response = await http.post(
        Uri.parse('https://snaket-backend-4.onrender.com/update-info-first'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestData),
      );

      // Handle the response
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        var user = UserModel.fromJson(jsonResponse['user']);

        // Store user information locally using Hive
        await _userLocalService.storeUserInHive(user);

        // Show success message
        UIHelpers.showToast(
          message: 'Info Updated',
        );
      } else {
        final errorResponse = jsonDecode(response.body);
        debugPrint("API Error: ${errorResponse['message']}");

        // Show error message
        UIHelpers.showSnackbar(
          title: 'Update Failed',
          message: 'Unable to update profile. Please try again.',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      UIHelpers.showSnackbar(
        title: 'Error',
        message: 'An error occurred: $e',
        backgroundColor: Colors.red,
      );
      debugPrint("Exception: $e");
    } finally {
      isUpdating.value = false;
    }
  }

  @override
  void dispose() {
    // Dispose of FocusNodes
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    dobFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // appbar(
              //   initialFloatingIcon: Icons.person,
              //   onFloatingButtonPressed: () {},
              //   Title: 'Profile'.tr,
              // ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                height: AppProportions.screenHeight * 0.9,
                child: ContainedTabBarView(
                  tabBarProperties: TabBarProperties(),
                  tabs: [
                    Text('Profile'.tr),
                    Text('Settings'.tr),
                  ],
                  views: [
                    //Profile Page
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppProportions.verticalSpacing),
                              TextField(
                                focusNode: nameFocusNode,
                                controller: _nameController,
                                decoration: InputDecoration(
                                    fillColor:
                                        Theme.of(context).colorScheme.surface,
                                    filled: true,
                                    labelText: 'Full Name'.tr,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.person,
                                          color: AppColors.PrimaryColor),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelStyle: GoogleFonts.mulish(),
                                    suffixIcon: Icon(Icons.edit)),
                              ),
                              SizedBox(height: AppProportions.verticalSpacing),
                              TextField(
                                focusNode: phoneFocusNode,
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  fillColor:
                                      Theme.of(context).colorScheme.surface,
                                  filled: true,
                                  labelText: 'Phone Number'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.phone,
                                        color: AppColors.PrimaryColor),
                                  ),
                                  border: OutlineInputBorder(),
                                  labelStyle: GoogleFonts.mulish(),
                                  suffixIcon:
                                      Icon(Icons.edit, color: Colors.grey),
                                ),
                                enabled: isGoogleSignIn,

                                // Disable if Phone sign-in
                              ),
                              SizedBox(height: AppProportions.verticalSpacing),
                              TextField(
                                focusNode: emailFocusNode,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  fillColor:
                                      Theme.of(context).colorScheme.surface,
                                  filled: true,
                                  labelText: 'Email'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.email,
                                        color: AppColors.PrimaryColor),
                                  ),
                                  border: OutlineInputBorder(),
                                  labelStyle: GoogleFonts.mulish(),
                                  suffixIcon: Icon(Icons.verified),
                                ),
                                enabled: false, // Disable if Google sign-in
                              ),
                              SizedBox(height: AppProportions.verticalSpacing),
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                  FocusScope.of(context).unfocus();
                                },
                                child: AbsorbPointer(
                                  child: TextField(
                                    focusNode: dobFocusNode,
                                    controller: _dobController,
                                    // focusNode: dobFocusNode,
                                    decoration: InputDecoration(
                                        fillColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        filled: true,
                                        labelText:
                                            'Date of Birth (DD-MM-YYYY)'.tr,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.calendar_today,
                                              color: AppColors.PrimaryColor),
                                        ),
                                        border: OutlineInputBorder(),
                                        labelStyle: GoogleFonts.mulish(),
                                        suffixIcon: Icon(Icons.edit)),
                                  ),
                                ),
                              ),
                              SizedBox(height: AppProportions.verticalSpacing),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('Language',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .labelMedium),
                              ),
                              Obx(
                                () => Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(10),
                                      value: _languageController
                                          .selectedLanguage.value,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyLarge,
                                      underline: Container(),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          _languageController
                                              .setSelectedLanguage(newValue);
                                        }
                                      },
                                      items: _languageController.languages
                                          .map<DropdownMenuItem<String>>(
                                              (language) {
                                        String displayName =
                                            language.keys.first;
                                        String languageCode =
                                            language.values.first;

                                        return DropdownMenuItem<String>(
                                          value: languageCode,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AppProportions
                                                        .screenHeight *
                                                    0.1),
                                            child: Center(
                                              child: Text(displayName,
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _saveUserInfo,
                                child: Obx(() => isUpdating.value
                                    ? CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      )
                                    : Text('Save'.tr)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Settings Page
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Other settings options (placeholders)
                          Text("Appearance".tr,
                              style: Theme.of(context).textTheme.titleSmall),
                          ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              "Dark Mode".tr,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyLarge,
                            ),
                            onTap: () {
                              settingsController.toggleTheme();
                            },
                            trailing: Obx(
                              () => Switch(
                                value: settingsController.isDarkMode.value,
                                onChanged: (value) {
                                  settingsController.toggleTheme();
                                },
                              ),
                            ),
                          ),
                          Text("Alerts".tr,
                              style: Theme.of(context).textTheme.titleSmall),
                          ListTile(
                            title: Text(
                              "Notifications".tr,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyLarge,
                            ),
                            trailing:
                                Switch(value: false, onChanged: (value) {}),
                          ),
                          Text("Download".tr,
                              style: Theme.of(context).textTheme.titleSmall),
                          ListTile(
                            titleTextStyle:
                                Theme.of(context).primaryTextTheme.bodyLarge,
                            leading: Icon(
                              Icons.download,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              "Download".tr,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyLarge,
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.local_movies_sharp,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text("Video Download Quality".tr),
                            onTap: () {},
                          ),
                          Text("Support".tr,
                              style: Theme.of(context).textTheme.titleSmall),
                          ListTile(
                            leading: Icon(Icons.question_mark,
                                color: Theme.of(context).colorScheme.primary),
                            title: Text("Learner Help Center".tr),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: Icon(Icons.bug_report,
                                color: Theme.of(context).colorScheme.primary),
                            title: Text("Report Bug".tr),
                            onTap: () {},
                          ),
                          Text("About".tr,
                              style: Theme.of(context).textTheme.titleSmall),
                          ListTile(
                            leading: Icon(Icons.info,
                                color: Theme.of(context).colorScheme.primary),
                            title: Text("Terms and Conditions".tr),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: AppProportions.verticalSpacing / 2,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              loginController.handleLogout();
                            },
                            child: Text('Logout'.tr),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onChange: (index) => print(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      _dobController.text = formattedDate;
    }
  }
}
