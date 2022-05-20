import 'package:prixz_test/shared/domain/email/email.dart';
import 'package:prixz_test/user/domain/gender.dart';

import '../../shared/domain/person_name_or_surname/person_name_or_surname.dart';
import '../domain/phone_number/phone_number.dart';
import '../domain/user.dart';

class UserDto {
  const UserDto._({
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.birthDay,
    required this.gender,
  });
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final String birthDay;
  final String gender;

  static UserDto fromJson(Map<String, dynamic> json) {
    return UserDto._(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      birthDay: json['birthDay'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDay': birthDay,
      'gender': gender,
    };
  }

  static UserDto fromDomain(User domain) {
    return UserDto._(
      name: domain.name.getOrCrash(),
      surname: domain.surname.getOrCrash(),
      email: domain.email.getOrCrash(),
      phoneNumber: domain.phoneNumber.getOrCrash(),
      birthDay: domain.birthDay.toIso8601String(),
      gender: domain.gender.getString,
    );
  }

  User toDomain() {
    return User(
      name: PersonNameOrSurname(name),
      surname: PersonNameOrSurname(surname),
      email: Email(email),
      phoneNumber: PhoneNumber(phoneNumber),
      birthDay: DateTime.parse(birthDay),
      gender: GenderBridge.fromString(gender),
    );
  }
}
