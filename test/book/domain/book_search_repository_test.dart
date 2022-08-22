import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prixz_test/book/domain/book.dart';
import 'package:prixz_test/book/domain/book_search_failure.dart';
import 'package:prixz_test/book/domain/book_search_repository.dart';
import 'package:prixz_test/book/domain/search_option.dart';
import 'package:prixz_test/core/core.dart';
import 'package:prixz_test/shared/domain/generic_name/generic_name.dart';

import 'package:prixz_test/shared/domain/paginated_item_response.dart';
import 'package:prixz_test/shared/domain/uint/uint.dart';

import 'book_search_repository_test.mocks.dart';

@GenerateMocks([BookSearchRepository])
void main() {
  final repository = MockBookSearchRepository();
  group(
    'Tests on book repository',
    () {
      test(
        'should receive a success',
        () async {
          when(repository.search(any, any, any)).thenAnswer(
            (_) async => Resource.success(
              PaginatedItemResponse(
                responseData: [],
                totalData: Uint(1),
              ),
            ),
          );
          final nameToSearch = GenericName("Any name");
          const optionToSearch = SearchOption.byAuthor;
          const currentPage = 1;
          expect(
              await repository.search(
                nameToSearch,
                optionToSearch,
                currentPage,
              ),
              isA<ResourceSuccess<BookSearchFailure, PaginatedItemResponse<Book>>>());
        },
      );
    },
  );
}
