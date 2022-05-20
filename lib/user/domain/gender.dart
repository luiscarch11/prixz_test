enum Gender {
  male,
  female,
  other,
}

extension GenderExt on Gender {
  String get getString {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      default:
        return 'other';
    }
  }
}

class GenderBridge {
  static Gender fromString(String val) {
    if (val == 'male') return Gender.male;
    if (val == 'female') return Gender.female;
    return Gender.other;
  }
}
