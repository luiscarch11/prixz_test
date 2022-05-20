import 'package:prixz_test/user/domain/fetch_user_failure.dart';

import '../../core/core.dart';
import '../../shared/domain/email/email.dart';

import '../../shared/domain/person_name_or_surname/person_name_or_surname.dart';
import 'gender.dart';
import 'phone_number/phone_number.dart';
import 'save_user_failure.dart';
import 'user.dart';

abstract class UserRepository {
  Future<ResultOr<SaveUserFailure>> saveUser(
    PersonNameOrSurname name,
    PersonNameOrSurname surname,
    Email email,
    PhoneNumber phoneNumber,
    DateTime birthDay,
    Gender gender,
  );
  Resource<FetchUserFailure, User?> fetchUser();
}
