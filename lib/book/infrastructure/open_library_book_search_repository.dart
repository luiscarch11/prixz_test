import 'package:dio/dio.dart';

import 'package:prixz_test/book/domain/book.dart';
import 'package:prixz_test/book/domain/book_search_failure.dart';
import 'package:prixz_test/book/domain/book_search_repository.dart';
import 'package:prixz_test/core/resource.dart';
import 'package:prixz_test/shared/constants/string_constants.dart';
import 'package:prixz_test/shared/domain/generic_name/generic_name.dart';
import 'package:prixz_test/shared/domain/paginated_item_response.dart';
import 'package:prixz_test/shared/infrastructure/paginated_item_response_dto.dart';

import '../domain/search_option.dart';
import 'book_dto.dart';

class OpenLibraryBookSearchRepository implements BookSearchRepository {
  final Dio _client;
  OpenLibraryBookSearchRepository(
    this._client,
  );
  @override
  Future<Resource<BookSearchFailure, PaginatedItemResponse<Book>>> search(
      GenericName query, SearchOption option, int currentPage) async {
    return Resource.fromRequest(
      () async {
        final params = <String, dynamic>{
          'page': currentPage,
          searchOptionToString(option): query.getOrCrash(),
        };
        final response = await _client.get(
          StringConstants.bookSearchUrl,
          queryParameters: params,
        );

        return Resource.success(
          PaginatedItemResponseDto.fromJson<BookDto, Book>(
            response.data,
            fromJsonTransformer: (json) => BookDto.fromJson(json),
          ).toDomain(
            toDomainTransformer: (dto) => dto.toDomain(),
          ),
        );
      },
      onDioError: (_) => Resource.failure(const BookSearchFailure.serverError()),
    );
  }
}
