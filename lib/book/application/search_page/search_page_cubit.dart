import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:prixz_test/book/domain/book.dart';
import 'package:prixz_test/book/domain/book_search_failure.dart';
import 'package:prixz_test/book/domain/book_search_repository.dart';
import 'package:prixz_test/book/domain/search_option.dart';
import 'package:prixz_test/shared/domain/generic_name/generic_name.dart';
import 'package:prixz_test/shared/domain/paginated_item_response.dart';

import '../../../core/resource.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit(this._bookSearchRepository) : super(SearchPageInitial());
  final BookSearchRepository _bookSearchRepository;
  var currentPage = 1;

  void changedSearchText(String value) {
    emit(
      state.copyWith(
        searchText: GenericName(value),
      ),
    );
  }

  void changedSearchOption(SearchOption searchOption) {
    emit(
      state.copyWith(
        searchOption: searchOption,
      ),
    );
  }

  void submittedSearchButton() {
    if (state.searchText.isInvalid) {
      emit(
        state.copyWith(
          shouldValidateInput: true,
        ),
      );
      return;
    }
    currentPage = 1;
    requestedSearch(
      state.copyWith(
        fetchedBooks: [],
      ),
    );
  }

  void requestedSearch([SearchPageState? defaultState]) async {
    emit(
      (defaultState ?? state).copyWith(
        booksOrFailure: Resource.loading(),
      ),
    );
    final result = await _bookSearchRepository.search(
      state.searchText,
      state.searchOption,
      currentPage,
    );
    final newListOfBooks = state.fetchedBooks;
    result.whenIsSuccess(
      (resource) {
        newListOfBooks.addAll(resource.responseData);
        currentPage++;
      },
    );
    emit(
      state.copyWith(
        fetchedBooks: newListOfBooks,
        booksOrFailure: result,
      ),
    );
  }
}
