class Option<T> {
  final T? value;
  const Option._({this.value});
  factory Option._some(T value) {
    return Option._(value: value);
  }
  factory Option._none() {
    return const Option._();
  }
  bool get isNone => value == null;
  bool get isSome => value != null;
  P fold<P>(
    P Function() isNone,
    P Function(T value) isSome,
  ) {
    return value == null ? isNone() : isSome(value!);
  }
}

Option<T> some<T>(T value) => Option._some(value);
Option<T> none<T>() => Option._none();
