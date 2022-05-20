enum SearchOption {
  byAuthor,
  byTitle,
}
String searchOptionToString(SearchOption option) {
  switch (option) {
    case SearchOption.byAuthor:
      return 'author';
    case SearchOption.byTitle:
      return 'title';
  }
}
