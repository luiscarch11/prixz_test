part of 'user_registration_cubit.dart';

class UserState {
  final PersonNameOrSurname name;
  final PersonNameOrSurname surname;
  final Email email;
  final PhoneNumber phoneNumber;
  final DateTime birthDay;
  final Gender gender;
  final ResultOr<SaveUserFailure> saveUserFailureOrSuccess;
  final bool shouldValidate;
  final Resource<FetchUserFailure, User?> userOrFailure;
  const UserState({
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.birthDay,
    required this.gender,
    required this.saveUserFailureOrSuccess,
    required this.shouldValidate,
    required this.userOrFailure,
  });

  bool get valuesAreValid => name.isValid && surname.isValid && email.isValid && phoneNumber.isValid;

  UserState copyWith({
    PersonNameOrSurname? name,
    PersonNameOrSurname? surname,
    Email? email,
    PhoneNumber? phoneNumber,
    DateTime? birthDay,
    Gender? gender,
    ResultOr<SaveUserFailure>? saveUserFailureOrSuccess,
    bool? shouldValidate,
    Resource<FetchUserFailure, User?>? userOrFailure,
  }) {
    return UserState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDay: birthDay ?? this.birthDay,
      gender: gender ?? this.gender,
      saveUserFailureOrSuccess: saveUserFailureOrSuccess ?? this.saveUserFailureOrSuccess,
      shouldValidate: shouldValidate ?? this.shouldValidate,
      userOrFailure: userOrFailure ?? this.userOrFailure,
    );
  }

  @override
  String toString() {
    return 'UserState(name: $name, surname: $surname, email: $email, phoneNumber: $phoneNumber, birthDay: $birthDay, gender: $gender, saveUserFailureOrSuccess: $saveUserFailureOrSuccess, shouldValidate: $shouldValidate, userOrFailure: $userOrFailure)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserState &&
        other.name == name &&
        other.surname == surname &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.birthDay == birthDay &&
        other.gender == gender &&
        other.saveUserFailureOrSuccess == saveUserFailureOrSuccess &&
        other.shouldValidate == shouldValidate &&
        other.userOrFailure == userOrFailure;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surname.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        birthDay.hashCode ^
        gender.hashCode ^
        saveUserFailureOrSuccess.hashCode ^
        shouldValidate.hashCode ^
        userOrFailure.hashCode;
  }
}

class UserInitial extends UserState {
  UserInitial()
      : super(
          name: PersonNameOrSurname(''),
          surname: PersonNameOrSurname(''),
          email: Email(''),
          phoneNumber: PhoneNumber(''),
          birthDay: DateTime.now(),
          gender: Gender.male,
          saveUserFailureOrSuccess: ResultOr.none(),
          shouldValidate: false,
          userOrFailure: Resource.none(),
        );
}
