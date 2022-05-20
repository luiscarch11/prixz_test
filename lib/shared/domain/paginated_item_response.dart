import 'package:flutter/foundation.dart';

import 'uint/uint.dart';

class PaginatedItemResponse<T> {
  final List<T> responseData;
  final Uint totalData;

  PaginatedItemResponse({
    required this.responseData,
    required this.totalData,
  });
  bool get dataIsOver => totalData.getOrCrash() == responseData.length;
  PaginatedItemResponse<T> copyWith({
    List<T>? responseData,
    Uint? totalData,
  }) {
    return PaginatedItemResponse<T>(
      responseData: responseData ?? this.responseData,
      totalData: totalData ?? this.totalData,
    );
  }

  @override
  String toString() => 'PaginatedItemResponse(responseData: $responseData, totalData: $totalData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaginatedItemResponse<T> &&
        listEquals(other.responseData, responseData) &&
        other.totalData == totalData;
  }

  @override
  int get hashCode => responseData.hashCode ^ totalData.hashCode;
}
