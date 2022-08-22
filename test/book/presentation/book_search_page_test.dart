import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable/expander.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:prixz_test/book/application/search_page/search_page_cubit.dart';
import 'package:prixz_test/book/domain/book_search_repository.dart';
import 'package:prixz_test/book/presentation/book_search_page.dart';
import 'package:prixz_test/core/core.dart';
import 'package:prixz_test/initial_bindings.dart';
import 'package:prixz_test/shared/domain/email/email.dart';
import 'package:prixz_test/shared/domain/paginated_item_response.dart';
import 'package:prixz_test/shared/domain/person_name_or_surname/person_name_or_surname.dart';
import 'package:prixz_test/shared/domain/uint/uint.dart';
import 'package:prixz_test/user/application/user/user_registration_cubit.dart';
import 'package:prixz_test/user/domain/gender.dart';
import 'package:prixz_test/user/domain/phone_number/phone_number.dart';
import 'package:prixz_test/user/domain/user.dart';
import 'package:prixz_test/user/domain/user_repository.dart';

import '../domain/book_search_repository_test.mocks.dart';
import 'book_search_page_test.mocks.dart';

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

class MockBookSearchCubit extends MockCubit<SearchPageState> implements SearchPageCubit {}

@GenerateMocks([UserRepository])
void main() {
  late Widget searchPage;

  setUp(
    () {
      final repository = MockBookSearchRepository();
      final userRepository = MockUserRepository();
      getIt.registerSingleton<BookSearchRepository>(
        repository,
      );
      getIt.registerSingleton<UserRepository>(
        userRepository,
      );
      final userCubit = MockUserCubit();
      whenListen<UserState>(
        userCubit,
        Stream.fromIterable(
          [
            UserInitial().copyWith(
              userOrFailure: Resource.success(
                User(
                  name: PersonNameOrSurname('name'),
                  surname: PersonNameOrSurname('surname'),
                  email: Email('luis@asd.asd'),
                  phoneNumber: PhoneNumber('1231231232'),
                  birthDay: DateTime.now(),
                  gender: Gender.male,
                ),
              ),
            )
          ],
        ),
        initialState: UserInitial(),
      );
      final searchCubit = MockBookSearchCubit();
      whenListen<SearchPageState>(
        searchCubit,
        Stream.fromIterable(
          [
            SearchPageInitial().copyWith(
              booksOrFailure: Resource.success(
                PaginatedItemResponse(
                  responseData: [],
                  totalData: Uint(10),
                ),
              ),
            )
          ],
        ),
        initialState: SearchPageInitial(),
      );
      searchPage = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: BlocProvider<UserCubit>(
            create: (_) => userCubit,
            child: Builder(builder: (context) {
              return BookSearchPage(
                cubit: searchCubit,
              );
            }),
          ),
        ),
      );
    },
  );
  testWidgets(
    "test description",
    (WidgetTester tester) async {
      await tester.pumpWidget(searchPage);
      final expanderFinder = find.byType(Expander);
      expect(expanderFinder, findsOneWidget);
    },
  );
}
