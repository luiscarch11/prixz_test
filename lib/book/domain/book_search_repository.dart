import 'package:prixz_test/book/domain/search_option.dart';
import 'package:prixz_test/core/core.dart';
import 'package:prixz_test/shared/domain/generic_name/generic_name.dart';
import 'package:prixz_test/shared/domain/paginated_item_response.dart';

import 'book.dart';
import 'book_search_failure.dart';

abstract class BookSearchRepository {
  Future<Resource<BookSearchFailure, PaginatedItemResponse<Book>>> search(
    GenericName query,
    SearchOption option,
    int currentPage,
  );
}
