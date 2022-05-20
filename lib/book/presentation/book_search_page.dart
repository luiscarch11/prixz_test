import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable/expandable.dart';
import 'package:flutter_expandable/expander.dart';
import 'package:prixz_test/book/domain/book.dart';
import 'package:prixz_test/book/domain/search_option.dart';
import 'package:prixz_test/initial_bindings.dart';
import 'package:prixz_test/shared/presentation/color_constants.dart';
import 'package:prixz_test/shared/presentation/rounded_button.dart';
import 'package:prixz_test/shared/presentation/style_constants.dart';
import 'package:prixz_test/shared/presentation/text_field_widget.dart';
import 'package:prixz_test/user/presentation/save_user_page.dart';
import 'package:prixz_test/user/presentation/view_user_page.dart';

import '../../user/application/user/user_registration_cubit.dart';
import '../application/search_page/search_page_cubit.dart';
import '../domain/book_search_repository.dart';
part './widgets/individual_book.dart';

class BookSearchPage extends StatelessWidget {
  const BookSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SearchPageCubit(getIt<BookSearchRepository>()),
        child: const CustomScrollView(
          slivers: [
            _SearchWidget(),
            _BookListWidget(),
          ],
        ),
      ),
    );
  }
}

class _BookListWidget extends StatefulWidget {
  const _BookListWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<_BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<_BookListWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Expander.builder(
            controller: controller,
            builder: (_, arrow) => Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorConstants.primaryColorLight,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.settings,
                    color: ColorConstants.textColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Advanced Search',
                    style: StyleConstants.settingsTextStyle,
                  ),
                  const Spacer(),
                  arrow,
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Expandable(
              controller: controller,
              height: 140,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorConstants.primaryColorLight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Search by:',
                      style: StyleConstants.settingsTextStyle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<SearchPageCubit, SearchPageState>(
                      buildWhen: (previous, current) => (previous.searchOption != current.searchOption),
                      builder: (context, state) {
                        return RadioListTile<SearchOption>(
                          contentPadding: EdgeInsets.zero,
                          activeColor: ColorConstants.textColor,
                          title: const Text(
                            'By title',
                            style: StyleConstants.settingsTextStyle,
                          ),
                          value: SearchOption.byTitle,
                          groupValue: state.searchOption,
                          onChanged: (val) =>
                              val == null ? null : context.read<SearchPageCubit>().changedSearchOption(val),
                        );
                      },
                    ),
                    BlocBuilder<SearchPageCubit, SearchPageState>(
                      buildWhen: (previous, current) => (previous.searchOption != current.searchOption),
                      builder: (context, state) {
                        return RadioListTile<SearchOption>(
                          contentPadding: EdgeInsets.zero,
                          activeColor: ColorConstants.textColor,
                          title: const Text(
                            'By author',
                            style: StyleConstants.settingsTextStyle,
                          ),
                          value: SearchOption.byAuthor,
                          groupValue: state.searchOption,
                          onChanged: (val) =>
                              val == null ? null : context.read<SearchPageCubit>().changedSearchOption(val),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<SearchPageCubit, SearchPageState>(
                buildWhen: (previous, current) =>
                    (previous.fetchedBooks != current.fetchedBooks) ||
                    (previous.booksOrFailure != current.booksOrFailure),
                builder: (context, state) {
                  return state.fetchedBooks.isEmpty
                      ? state.booksOrFailure.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Center(
                              child: Text('No books found'),
                            )
                      : Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 127 / 265,
                                ),
                                itemCount: state.dataIsOver ? state.fetchedBooks.length : state.fetchedBooks.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < state.fetchedBooks.length) {
                                    final currentBook = state.fetchedBooks[index];
                                    return _IndividualBook(
                                      book: currentBook,
                                    );
                                  }
                                  return state.booksOrFailure.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : RoundedButton(
                                          onPressed: context.read<SearchPageCubit>().requestedSearch,
                                          text: 'Fetch more',
                                        );
                                },
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: ColorConstants.primaryColor,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Searcher',
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorConstants.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<UserCubit, UserState>(
                    buildWhen: (previous, current) => (previous.userOrFailure != current.userOrFailure),
                    builder: (context, state) {
                      return state.userOrFailure.maybeMap(
                        orElse: () => const Text(
                          'Unknown error',
                        ),
                        isLoading: () => const CircularProgressIndicator(),
                        isSuccess: (user) => GestureDetector(
                          onTap: user == null
                              ? () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const SaveUserPage(),
                                    ),
                                  )
                              : null,
                          child: Column(
                            children: [
                              Text(
                                user == null ? 'Register here' : 'Welcome, ${user.name.getOrCrash()}!',
                                style: const TextStyle(
                                  color: ColorConstants.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (user != null)
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const SaveUserPage(),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.edit,
                                        color: ColorConstants.whiteColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    IconButton(
                                      onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const ViewUserPage(),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  // BlocBuilder<SearchPageCubit, SearchPageState>(
                  //   buildWhen: (previous, current) => (previous.searchOption != current.searchOption),
                  //   builder: (context, state) {
                  //     return DropdownButton<SearchOption>(
                  //       value: state.searchOption,
                  //       items: const [
                  //         DropdownMenuItem(
                  //           value: SearchOption.byTitle,
                  //           child: Text('By Title'),
                  //         ),
                  //         DropdownMenuItem(
                  //           value: SearchOption.byAuthor,
                  //           child: Text('By Author'),
                  //         ),
                  //       ],
                  //       onChanged: (val) => context.read<SearchPageCubit>().changedSearchOption(val!),
                  //     );
                  //   },
                  // ),
                  Expanded(
                    child: SizedBox(
                      child: BlocBuilder<SearchPageCubit, SearchPageState>(
                        buildWhen: (previous, current) =>
                            (previous.shouldValidateInput != current.shouldValidateInput) ||
                            (previous.searchText != current.searchText),
                        builder: (context, state) {
                          return TextFieldWidget(
                            prefix: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            onChanged: context.read<SearchPageCubit>().changedSearchText,
                            hintText: 'Search',
                            shouldValidate: state.shouldValidateInput,
                            validator: (_) {
                              return state.searchText.validationResult;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  RoundedButton(
                    onPressed: context.read<SearchPageCubit>().submittedSearchButton,
                    text: 'Search',
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
