import 'dart:convert';

import 'package:prixz_test/shared/constants/string_constants.dart';
import 'package:prixz_test/user/domain/save_user_failure.dart';
import 'package:prixz_test/user/domain/phone_number/phone_number.dart';
import 'package:prixz_test/user/domain/fetch_user_failure.dart';
import 'package:prixz_test/shared/domain/person_name_or_surname/person_name_or_surname.dart';
import 'package:prixz_test/shared/domain/email/email.dart';
import 'package:prixz_test/core/result_or.dart';
import 'package:prixz_test/core/resource.dart';
import 'package:prixz_test/user/domain/user_repository.dart';
import 'package:prixz_test/user/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/gender.dart';
import 'user_dto.dart';

class SharedPreferencesUserRepository implements UserRepository {
  final SharedPreferences sharedPreferences;

  SharedPreferencesUserRepository(this.sharedPreferences);
  @override
  Resource<FetchUserFailure, User?> fetchUser() {
    if (!sharedPreferences.containsKey(StringConstants.userKey)) return Resource.success(null);
    final user = jsonDecode(sharedPreferences.getString(StringConstants.userKey)!);
    return Resource.success(UserDto.fromJson(user).toDomain());
  }

  @override
  Future<ResultOr<SaveUserFailure>> saveUser(
    PersonNameOrSurname name,
    PersonNameOrSurname surname,
    Email email,
    PhoneNumber phoneNumber,
    DateTime birthDay,
    Gender gender,
  ) async {
    final userDto = UserDto.fromDomain(
      User(
        name: name,
        surname: surname,
        email: email,
        phoneNumber: phoneNumber,
        birthDay: birthDay,
        gender: gender,
      ),
    );
    final result = await sharedPreferences.setString(
      StringConstants.userKey,
      jsonEncode(userDto.toJson()),
    );
    if (result) return ResultOr.success();
    return ResultOr.failure(const SaveUserFailure.unexpectedError());
  }
}
