// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);
import 'package:bookworm/features/books/domain/entities/book.dart';

class BookModel {
  final List<String> authorKey;
  final List<String> authorName;
  final String coverEditionKey;
  final int coverI;
  final int editionCount;
  final int firstPublishYear;
  final bool hasFulltext;
  final List<String> ia;
  final String iaCollectionS;
  final String key;
  final List<String> language;
  final String lendingEditionS;
  final String lendingIdentifierS;
  final bool publicScanB;
  final String title;

  BookModel({
    required this.authorKey,
    required this.authorName,
    required this.coverEditionKey,
    required this.coverI,
    required this.editionCount,
    required this.firstPublishYear,
    required this.hasFulltext,
    required this.ia,
    required this.iaCollectionS,
    required this.key,
    required this.language,
    required this.lendingEditionS,
    required this.lendingIdentifierS,
    required this.publicScanB,
    required this.title,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    authorKey:
        json["author_key"] != null
            ? List<String>.from(json["author_key"].map((x) => x))
            : [],
    authorName:
        json["author_name"] != null
            ? List<String>.from(json["author_name"].map((x) => x))
            : [],
    coverEditionKey: json["cover_edition_key"] ?? "",
    coverI: json["cover_i"] ?? 0,
    editionCount: json["edition_count"] ?? 0,
    firstPublishYear: json["first_publish_year"] ?? 0,
    hasFulltext: json["has_fulltext"] ?? false,
    ia: json["ia"] != null ? List<String>.from(json["ia"].map((x) => x)) : [],
    iaCollectionS: json["ia_collection_s"] ?? "",
    key: json["key"] ?? "",
    language:
        json["language"] != null
            ? List<String>.from(json["language"].map((x) => x))
            : [],
    lendingEditionS: json["lending_edition_s"] ?? "",
    lendingIdentifierS: json["lending_identifier_s"] ?? "",
    publicScanB: json["public_scan_b"] ?? false,
    title: json["title"] ?? "Unknown Title",
  );

  Map<String, dynamic> toJson() => {
    "author_key": List<dynamic>.from(authorKey.map((x) => x)),
    "author_name": List<dynamic>.from(authorName.map((x) => x)),
    "cover_edition_key": coverEditionKey,
    "cover_i": coverI,
    "edition_count": editionCount,
    "first_publish_year": firstPublishYear,
    "has_fulltext": hasFulltext,
    "ia": List<dynamic>.from(ia.map((x) => x)),
    "ia_collection_s": iaCollectionS,
    "key": key,
    "language": List<dynamic>.from(language.map((x) => x)),
    "lending_edition_s": lendingEditionS,
    "lending_identifier_s": lendingIdentifierS,
    "public_scan_b": publicScanB,
    "title": title,
  };

  Book toEntity() {
    return Book(
      id: key.replaceAll('/', '_'),
      title: title,
      author: authorName.isEmpty ? '' : authorName.first,
      coverUrl: coverI == 0 ? '' : getCoverUrl(),
      firstPublishYear: firstPublishYear,
    );
  }

  String getCoverUrl() => 'https://covers.openlibrary.org/b/id/$coverI-M.jpg';
}
