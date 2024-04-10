import 'dart:convert';

class ProfileModel {
  Profile profile;

  ProfileModel({
    required this.profile,
  });

  factory ProfileModel.fromRawJson(String str) =>
      ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
      };
}

class Profile {
  String? id;
  String? username;
  String? email;
  String? bio;
  String? dateofbirth;
  String? phoneNumber;
  dynamic profilePicture;
  int? coins;

  Profile(
      {required this.id,
      required this.username,
      required this.email,
      required this.profilePicture,
      required this.bio,
      required this.dateofbirth,
      required this.phoneNumber,
      required this.coins});

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profilePicture: json["profilePicture"],
        bio: json["bio"],
        dateofbirth: json["date_of_birth"],
        phoneNumber: json["phone_number"],
        coins: json["coins"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "profilePicture": profilePicture,
        "bio": bio,
        "date_of_birth": dateofbirth,
        "phone_number": phoneNumber,
        "coins": coins,
      };
}
