abstract class Rule<F, T> {
  Rule(this.value);
  final T value;

  late bool isValid;
  F get failure;
  void validate();
}
