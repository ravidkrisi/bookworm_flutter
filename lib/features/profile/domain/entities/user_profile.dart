import 'package:bookworm/features/auth/domain/entities/app_user.dart';
import 'package:bookworm/features/books/domain/entities/book.dart';

class UserProfile extends AppUser {
  String? profileImageUrl;
  List<Book>? books;

  UserProfile({
    required String uid,
    required String email,
    required String name,
    this.profileImageUrl,
    this.books,
  }) : super(email: email, uid: uid, name: name);

  // to json
  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      'profile_image_url': profileImageUrl ?? '',
      'books': books?.map((book) => book.toJson()).toList() ?? [],
    });
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      profileImageUrl: json['profile_image_url'] ?? '',
      books:
          (json['books'] as List<dynamic>?)
              ?.map((bookJson) => Book.fromJson(bookJson))
              .toList(),
    );
  }
}
