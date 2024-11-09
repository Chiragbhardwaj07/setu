import 'package:hive/hive.dart';
import 'package:vasu/features/authentication/data/models/user_model_hive.dart'
    as HiveUserModel;
import 'package:vasu/features/authentication/data/models/user_auth_model.dart'
    as ApiUserModel;

class UserLocalService {
  // Convert API model to Hive model
  HiveUserModel.UserModel convertApiUserToHive(ApiUserModel.UserModel apiUser) {
    return HiveUserModel.UserModel(
      id: apiUser.id,
      uid: apiUser.uid,
      phone: apiUser.phone,
      name: apiUser.name ?? '',
      dob: apiUser.dob,
      email: apiUser.email,
      emailVerified: apiUser.emailVerified,
      region: apiUser.region ?? '',
      language: apiUser.language ?? '',
      firstTime: apiUser.firstTime,
    );
  }

  // Store user data in Hive
  Future<void> storeUserInHive(ApiUserModel.UserModel apiUser) async {
    var hiveUser = convertApiUserToHive(apiUser);
    var box = await Hive.openBox<HiveUserModel.UserModel>('userBox');
    await box.put('user', hiveUser);
  }

  // Retrieve user data from Hive
  Future<HiveUserModel.UserModel?> getUserFromHive() async {
    var box = await Hive.openBox<HiveUserModel.UserModel>('userBox');
    return box.get('user');
  }

  // Optional: Clear user data from Hive
  Future<void> clearUserFromHive() async {
    var box = await Hive.openBox<HiveUserModel.UserModel>('userBox');
    await box.delete('user');
  }
}
