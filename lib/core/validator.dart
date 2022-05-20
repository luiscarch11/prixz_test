import 'package:flutter/cupertino.dart';
import 'package:prixz_test/shared/domain/extensions/iterable_extension.dart';

import 'either.dart';
import 'rule.dart';

abstract class Validator<F, T> {
  Validator(this.value, {required this.rules});

  final T value;
  final List<Rule<F, dynamic>> rules;

  Rule<F, dynamic>? get invalidRule => rules.firstWhereOrNull(
        (rule) => !(rule.isValid),
      );

  bool get isValid => !rules.any((rule) => !(rule.isValid));

  @protected
  void validate() {
    _rulesValidator.call();
  }

  Either<F, T> get valueAfterValidation {
    if (_error != null) return left(_error!);
    return right(value);
  }

  void _rulesValidator() {
    var validRules = 0;
    for (var rule in rules) {
      rule.validate();
      if (!rule.isValid && _error == null) {
        _error = rule.failure;
        return;
      }
      validRules++;
    }
    if (validRules == rules.length) _error = null;
  }

  F? _error;
}
