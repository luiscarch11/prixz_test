import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:prixz_test/book/domain/book_search_repository.dart';
import 'package:prixz_test/book/infrastructure/open_library_book_search_repository.dart';
import 'package:prixz_test/user/domain/user_repository.dart';
import 'package:prixz_test/user/infrastructure/shared_preferences_user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.I;

class InitialBindings {
  InitialBindings._(this.sharedPreferences);
  final SharedPreferences sharedPreferences;
  static late InitialBindings _instance;
  static Future<InitialBindings> initialize() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final _client = Dio();
    _instance = InitialBindings._(sharedPrefs);
    getIt
      ..registerSingleton<BookSearchRepository>(OpenLibraryBookSearchRepository(_client))
      ..registerSingleton<UserRepository>(
        SharedPreferencesUserRepository(sharedPrefs),
      );
    return _instance;
  }
}
