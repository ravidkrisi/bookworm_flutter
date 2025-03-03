// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  String uid;
  String email;
  String? name;

  AppUser({required this.uid, required this.email, this.name});

  // JSON methods
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'name': name ?? ''};
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(uid: json['uid'], email: json['email'], name: json['name']);
  }
}
