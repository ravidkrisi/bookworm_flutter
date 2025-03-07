import 'package:bookworm/features/auth/domain/entities/app_user.dart';

class UserProfile extends AppUser {
  String? profileImageUrl;

  UserProfile({
    required String uid,
    required String email,
    required String name,
    this.profileImageUrl,
  }) : super(email: email, uid: uid, name: name);

  // to json
  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({'profile_image_url': profileImageUrl ?? ''});
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      profileImageUrl: json['profile_image_url'] ?? '',
    );
  }
}
