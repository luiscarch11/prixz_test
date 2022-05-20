import '../../../core/rule.dart';

class BetweenCharactersRule<F> extends Rule<F, String> {
  BetweenCharactersRule(this.failure, {required this.since, required this.until, required String value}) : super(value);
  final int since;
  final int until;

  @override
  void validate() {
    final length = value.trim().length;
    isValid = (length >= since) && (length <= until);
  }

  @override
  final F failure;
}
