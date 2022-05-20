import 'package:prixz_test/book/domain/book_name/book_name.dart';
import 'package:prixz_test/book/domain/year/year.dart';
import 'package:prixz_test/shared/domain/generic_name/generic_name.dart';

import '../../shared/domain/uint/uint.dart';

class Book {
  final Year releasedAt;
  final BookName bookName;
  final Uint edition;
  final Uint? pageCount;
  final GenericName author;
  Book({
    required this.releasedAt,
    required this.bookName,
    required this.edition,
    required this.pageCount,
    required this.author,
  });

  Book copyWith({
    Year? releasedAt,
    BookName? bookName,
    Uint? edition,
    Uint? pageCount,
    GenericName? author,
  }) {
    return Book(
      releasedAt: releasedAt ?? this.releasedAt,
      bookName: bookName ?? this.bookName,
      edition: edition ?? this.edition,
      pageCount: pageCount ?? this.pageCount,
      author: author ?? this.author,
    );
  }

  @override
  String toString() {
    return 'Book(releasedAt: $releasedAt, bookName: $bookName, edition: $edition, pageCount: $pageCount, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.releasedAt == releasedAt &&
        other.bookName == bookName &&
        other.edition == edition &&
        other.pageCount == pageCount &&
        other.author == author;
  }

  @override
  int get hashCode {
    return releasedAt.hashCode ^ bookName.hashCode ^ edition.hashCode ^ pageCount.hashCode ^ author.hashCode;
  }
}
