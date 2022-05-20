class Either<L, R> {
  final L? left;
  final R? right;

  Either._(this.left, this.right);

  factory Either({L? left, R? right}) => Either._(left, right);

  factory Either.right(R right) => Either(right: right);

  factory Either.left(L left) => Either(left: left);

  void when({required void Function(L) isLeft, required void Function(R) isRight}) {
    if (left != null) {
      isLeft.call(left!);
      return;
    }

    isRight.call(right!);
  }

  void whenIsRight(void Function(R) isRight) {
    if (right == null) return;
    isRight.call(right!);
  }

  void whenIsLeft(void Function(L) isLeft) {
    if (left != null) return;
    isLeft.call(left!);
  }

  T map<T>({required T Function(L) isLeft, required T Function(R) isRight}) {
    if (left != null) {
      return isLeft.call(left!);
    }

    return isRight.call(right!);
  }

  bool get isLeft => left != null;

  bool get isRight => right != null;

  R rightOrElse(R Function(L) orElse) {
    if (right != null) {
      return right!;
    }

    return orElse.call(left!);
  }

  L? leftOrElseNullable(L? Function(R) orElse) {
    if (left != null) {
      return left!;
    }

    return orElse.call(right!);
  }

  Either<L, R> copyWith({
    L? left,
    R? right,
  }) {
    return Either<L, R>(
      left: left ?? this.left,
      right: right ?? this.right,
    );
  }

  @override
  String toString() => 'Either(left: $left, right: $right)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Either<L, R> && other.left == left && other.right == right;
  }

  @override
  int get hashCode => left.hashCode ^ right.hashCode;
}

Either<L, R> right<L, R>(R right) => Either.right(right);
Either<L, R> left<L, R>(L left) => Either.left(left);
