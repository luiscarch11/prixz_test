part of 'search_page_cubit.dart';

class SearchPageState {
  const SearchPageState({
    required this.booksOrFailure,
    required this.searchText,
    required this.fetchedBooks,
    required this.searchOption,
    required this.shouldValidateInput,
  });
  final Resource<BookSearchFailure, PaginatedItemResponse<Book>> booksOrFailure;
  final GenericName searchText;
  final List<Book> fetchedBooks;
  final SearchOption searchOption;
  final bool shouldValidateInput;
  bool get dataIsOver => booksOrFailure.maybeMap(
        orElse: () => false,
        isSuccess: (value) => value.dataIsOver,
      );
  SearchPageState copyWith({
    Resource<BookSearchFailure, PaginatedItemResponse<Book>>? booksOrFailure,
    GenericName? searchText,
    List<Book>? fetchedBooks,
    SearchOption? searchOption,
    bool? shouldValidateInput,
  }) {
    return SearchPageState(
      booksOrFailure: booksOrFailure ?? this.booksOrFailure,
      searchText: searchText ?? this.searchText,
      fetchedBooks: fetchedBooks ?? this.fetchedBooks,
      searchOption: searchOption ?? this.searchOption,
      shouldValidateInput: shouldValidateInput ?? this.shouldValidateInput,
    );
  }

  @override
  String toString() {
    return 'SearchPageState(booksOrFailure: $booksOrFailure, searchText: $searchText, fetchedBooks: $fetchedBooks, searchOption: $searchOption, shouldValidateInput: $shouldValidateInput)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchPageState &&
        other.booksOrFailure == booksOrFailure &&
        other.searchText == searchText &&
        listEquals(other.fetchedBooks, fetchedBooks) &&
        other.searchOption == searchOption &&
        other.shouldValidateInput == shouldValidateInput;
  }

  @override
  int get hashCode {
    return booksOrFailure.hashCode ^
        searchText.hashCode ^
        fetchedBooks.hashCode ^
        searchOption.hashCode ^
        shouldValidateInput.hashCode;
  }
}

class SearchPageInitial extends SearchPageState {
  SearchPageInitial()
      : super(
          booksOrFailure: Resource.none(),
          searchText: GenericName(''),
          fetchedBooks: [],
          searchOption: SearchOption.byTitle,
          shouldValidateInput: false,
        );
}
