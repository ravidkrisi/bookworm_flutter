import 'package:bookworm/features/books/data/repos/datasources/models/book_model.dart';

class ResponseApi {
  final int numFound;
  final int start;
  final bool numFoundExact;
  final int responseNumFound;
  final String documentationUrl;
  final String q;
  final dynamic offset;
  final List<BookModel> books;

  ResponseApi({
    required this.numFound,
    required this.start,
    required this.numFoundExact,
    required this.responseNumFound,
    required this.documentationUrl,
    required this.q,
    required this.offset,
    required this.books,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json) => ResponseApi(
    numFound: json["numFound"] ?? 0,
    start: json["start"] ?? 0,
    numFoundExact: json["numFoundExact"] ?? false,
    responseNumFound: json["num_found"] ?? 0,
    documentationUrl: json["documentation_url"] ?? '',
    q: json["q"] ?? '',
    offset: json["offset"],
    books:
        (json["docs"] ?? []) // Ensure docs is not null
            .map<BookModel>((x) => BookModel.fromJson(x))
            .toList(), // Convert to List<BookModel>
  );

  Map<String, dynamic> toJson() => {
    "numFound": numFound,
    "start": start,
    "numFoundExact": numFoundExact,
    "num_found": responseNumFound,
    "documentation_url": documentationUrl,
    "q": q,
    "offset": offset,
    "docs": List<dynamic>.from(books.map((x) => x.toJson())),
  };
}
