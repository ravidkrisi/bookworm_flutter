// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  UserProfile copyWith({
    String? uid,
    String? email,
    String? name,
    String? profileImageUrl,
    List<Book>? books,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name!,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      books: books ?? this.books,
    );
  }
}
