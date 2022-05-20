import 'package:bloc/bloc.dart';
import 'package:prixz_test/core/core.dart';
import 'package:prixz_test/shared/domain/email/email.dart';
import 'package:prixz_test/user/domain/fetch_user_failure.dart';

import 'package:prixz_test/user/domain/phone_number/phone_number.dart';
import 'package:prixz_test/user/domain/user_repository.dart';

import '../../../shared/domain/person_name_or_surname/person_name_or_surname.dart';
import '../../domain/gender.dart';
import '../../domain/save_user_failure.dart';
import '../../domain/user.dart';

part 'user_registration_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(UserInitial());
  final UserRepository _userRepository;
  User? get user => state.userOrFailure.maybeMap(
        orElse: () => null,
        isSuccess: (user) => user,
      );
  void requestedUser() {
    emit(
      state.copyWith(
        userOrFailure: Resource.loading(),
      ),
    );
    final result = _userRepository.fetchUser();
    emit(
      state.copyWith(
        userOrFailure: result,
      ),
    );
  }

  void changedNameValue(String value) {
    emit(
      state.copyWith(
        name: PersonNameOrSurname(value),
      ),
    );
  }

  void changedSurnameValue(String value) {
    emit(
      state.copyWith(
        surname: PersonNameOrSurname(value),
      ),
    );
  }

  void changedPhoneNumber(String value) {
    emit(
      state.copyWith(
        phoneNumber: PhoneNumber(value),
      ),
    );
  }

  void changedEmail(String value) {
    emit(
      state.copyWith(
        email: Email(value),
      ),
    );
  }

  void changedBirthDay(DateTime value) {
    emit(
      state.copyWith(
        birthDay: value,
      ),
    );
  }

  void changedGender(Gender value) {
    emit(
      state.copyWith(
        gender: value,
      ),
    );
  }

  void submittedButton() async {
    if (!state.valuesAreValid) {
      emit(
        state.copyWith(
          shouldValidate: true,
        ),
      );
      return;
    }
    final result = await _userRepository.saveUser(
      state.name,
      state.surname,
      state.email,
      state.phoneNumber,
      state.birthDay,
      state.gender,
    );
    var userToEmit = state.userOrFailure;
    result.whenIsSuccess(
      () {
        userToEmit = Resource.success(
          User(
            name: state.name,
            surname: state.surname,
            email: state.email,
            phoneNumber: state.phoneNumber,
            birthDay: state.birthDay,
            gender: state.gender,
          ),
        );
      },
    );
    emit(
      state.copyWith(
        userOrFailure: userToEmit,
        saveUserFailureOrSuccess: result,
      ),
    );
  }
}
