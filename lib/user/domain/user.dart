import 'package:prixz_test/user/domain/gender.dart';

import '../../shared/domain/email/email.dart';
import '../../shared/domain/person_name_or_surname/person_name_or_surname.dart';
import 'phone_number/phone_number.dart';

class User {
  final PersonNameOrSurname name;
  final PersonNameOrSurname surname;
  final Email email;
  final PhoneNumber phoneNumber;
  final DateTime birthDay;
  final Gender gender;
  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.birthDay,
    required this.gender,
  });

  User copyWith({
    PersonNameOrSurname? name,
    PersonNameOrSurname? surname,
    Email? email,
    PhoneNumber? phoneNumber,
    DateTime? birthDay,
    Gender? gender,
  }) {
    return User(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDay: birthDay ?? this.birthDay,
      gender: gender ?? this.gender,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, surname: $surname, email: $email, phoneNumber: $phoneNumber, birthDay: $birthDay, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.surname == surname &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.birthDay == birthDay &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surname.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        birthDay.hashCode ^
        gender.hashCode;
  }
}
