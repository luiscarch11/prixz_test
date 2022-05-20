import '../domain/paginated_item_response.dart';
import '../domain/uint/uint.dart';

class PaginatedItemResponseDto<T, D> {
  const PaginatedItemResponseDto._({
    required this.responseData,
    required this.totalData,
  });
  final List<T> responseData;
  final int totalData;

  static PaginatedItemResponseDto<T, D> fromJson<T, D>(
    Map<String, dynamic> json, {
    required T Function(Map<String, dynamic> json) fromJsonTransformer,
  }) {
    return PaginatedItemResponseDto._(
      totalData: json['numFound'],
      responseData: (json['docs'] as List)
          .map(
            (e) => fromJsonTransformer.call(e),
          )
          .toList(),
    );
  }

  PaginatedItemResponse<D> toDomain({required D Function(T dto) toDomainTransformer}) {
    return PaginatedItemResponse(
      responseData: responseData
          .map(
            (e) => toDomainTransformer.call(e),
          )
          .toList(),
      totalData: Uint(totalData),
    );
  }
}
