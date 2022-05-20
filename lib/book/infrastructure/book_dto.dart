import '../../shared/domain/generic_name/generic_name.dart';
import '../../shared/domain/uint/uint.dart';
import '../domain/book.dart';
import '../domain/book_name/book_name.dart';
import '../domain/year/year.dart';

class BookDto {
  const BookDto._({
    required this.releasedAt,
    required this.bookName,
    required this.author,
    required this.edition,
    required this.pageCount,
  });
  final int releasedAt;
  final String bookName;
  final String author;
  final int edition;
  final int? pageCount;
  static BookDto fromJson(Map<String, dynamic> json) {
    return BookDto._(
      pageCount: json['number_of_pages_median'],
      edition: json['edition_count'],
      releasedAt: json['first_publish_year'] ??
          (json['publish_year'] == null
              ? DateTime.now().year
              : (json['publish_year'] as List).reduce(
                  (a, b) => b < a ? b : a,
                )),
      bookName: json['title'] ?? '',
      author: json['author_name'] == null ? '' : (json['author_name'] as List).first,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'releasedAt': releasedAt,
      'bookName': bookName,
      'author': author,
    };
  }

  static BookDto fromDomain(Book domain) {
    return BookDto._(
      edition: domain.edition.getOrCrash(),
      pageCount: domain.pageCount?.getOrCrash(),
      releasedAt: domain.releasedAt.getOrCrash(),
      bookName: domain.bookName.getOrCrash(),
      author: domain.author.getOrCrash(),
    );
  }

  Book toDomain() {
    return Book(
      edition: Uint(edition),
      pageCount: pageCount == null ? null : Uint(pageCount!),
      releasedAt: Year(releasedAt),
      bookName: BookName(bookName),
      author: GenericName(author),
    );
  }
}
