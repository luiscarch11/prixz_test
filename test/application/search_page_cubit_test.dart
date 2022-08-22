import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prixz_test/book/application/search_page/search_page_cubit.dart';
import 'package:prixz_test/book/domain/book.dart';
import 'package:prixz_test/book/domain/book_search_failure.dart';
import 'package:prixz_test/book/domain/search_option.dart';
import 'package:prixz_test/core/core.dart';
import 'package:prixz_test/shared/domain/generic_name/generic_name.dart';
import 'package:prixz_test/shared/domain/paginated_item_response.dart';
import 'package:prixz_test/shared/domain/uint/uint.dart';

import '../book/domain/book_search_repository_test.mocks.dart';

void main() {
  final repository = MockBookSearchRepository();
  group(
    "Tests on the search cubit",
    () {
      final cubit = SearchPageCubit(repository);
      test(
        "When the search text changes, a new state should be emitted with that value in state",
        () {
          final initialState = cubit.state;
          const searchText = "Any text";
          cubit.changedSearchText(searchText);
          expect(
            cubit.state,
            equals(
              initialState.copyWith(
                searchText: GenericName(searchText),
              ),
            ),
          );
        },
      );
      test(
        "When the searchOption changes, a new state should be emitted with that value in state",
        () {
          final initialState = cubit.state;
          const searchOption = SearchOption.byAuthor;
          cubit.changedSearchOption(searchOption);
          expect(
            cubit.state,
            equals(
              initialState.copyWith(
                searchOption: searchOption,
              ),
            ),
          );
        },
      );

      test(
        "When new data is requested and response is success, currentpage should increase 1",
        () async {
          when(
            repository.search(any, any, any),
          ).thenAnswer(
            (_) async => Resource<BookSearchFailure, PaginatedItemResponse<Book>>.success(
              PaginatedItemResponse(
                responseData: [],
                totalData: Uint(20),
              ),
            ),
          );
          final currentPage = cubit.currentPage;
          await cubit.requestedSearch();
          expect(
            cubit.currentPage,
            equals(currentPage + 1),
          );
        },
      );
      test(
        "When new data is requested and response is failure, currentpage should remain with same value",
        () async {
          when(
            repository.search(any, any, any),
          ).thenAnswer(
            (_) async =>
                const Resource<BookSearchFailure, PaginatedItemResponse<Book>>.failure(BookSearchFailure.serverError()),
          );
          final currentPage = cubit.currentPage;
          await cubit.requestedSearch();
          expect(
            cubit.currentPage,
            equals(currentPage),
          );
        },
      );
      blocTest<SearchPageCubit, SearchPageState>(
        "When search method is called, state should emit loading state and then the result",
        build: () => SearchPageCubit(repository),
        setUp: () {
          final response = Resource<BookSearchFailure, PaginatedItemResponse<Book>>.success(
            PaginatedItemResponse(
              responseData: [],
              totalData: Uint(20),
            ),
          );
          when(
            repository.search(any, any, any),
          ).thenAnswer(
            (_) async => response,
          );
        },
        act: (cubit) async => await cubit.requestedSearch(),
        verify: (cubit) => verify(repository.search(any, any, any)).called(1),
        expect: () => [
          const TypeMatcher<SearchPageState>().having(
            (state) => state.booksOrFailure,
            'booksOrFailure  ',
            isA<ResourceLoading>(),
          ),
          const TypeMatcher<SearchPageState>().having(
            (state) => state.booksOrFailure,
            'booksOrFailure  ',
            isA<ResourceSuccess>(),
          ),
        ],
      );
    },
  );
}
