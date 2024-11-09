import 'package:hive/hive.dart';

part 'user_model_hive.g.dart'; // Hive type adapter will be generated here

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String? id; // Nullable

  @HiveField(1)
  String? uid; // Nullable for Google sign-in users

  @HiveField(2)
  String? phone; // Nullable

  @HiveField(3)
  String? name; // Nullable

  @HiveField(4)
  String? dob; // Nullable (ISO format)

  @HiveField(5)
  String? email; // Nullable

  @HiveField(6)
  bool emailVerified; // Non-nullable

  @HiveField(7)
  String? region; // Nullable

  @HiveField(8)
  String? language; // Nullable

  @HiveField(9)
  bool firstTime; // Non-nullable

  UserModel({
    this.id,
    this.uid, // nullable field for Google sign-in users
    this.phone,
    this.name,
    this.dob,
    this.email,
    required this.emailVerified,
    this.region,
    this.language,
    required this.firstTime,
  });
}
