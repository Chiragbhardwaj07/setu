class UserModel {
  final String? id; // Nullable
  final String? uid; // Nullable for Google sign-in
  final String? phone; // Nullable
  final String? name; // Nullable
  final String? dob; // Nullable
  final String? email; // Nullable
  final bool emailVerified; // Non-nullable
  final String? region; // Nullable
  final String? language; // Nullable
  final bool firstTime; // Non-nullable

  UserModel({
    this.id,
    this.uid,
    this.phone,
    this.name,
    this.dob,
    this.email,
    required this.emailVerified,
    this.region,
    this.language,
    required this.firstTime,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      uid: json['uid'],
      phone: json['phone'],
      name: json['name'],
      dob: json['dob'],
      email: json['email'],
      emailVerified: json['emailverified'], // Ensure this is non-null
      region: json['region'],
      language: json['language'],
      firstTime: json['first_time'], // Ensure this is non-null
    );
  }
}

class AuthResponseModel {
  final String? token; // Nullable
  final String? refreshToken; // Nullable
  final UserModel user;

  AuthResponseModel({
    this.token,
    this.refreshToken,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'],
      refreshToken: json['refreshToken'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
