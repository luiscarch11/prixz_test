import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Resource<F, T> extends Equatable {
  const Resource();
  factory Resource.none() = _ResourceNone;
  factory Resource.loading() = ResourceLoading;
  const factory Resource.success(T resource) = ResourceSuccess;
  const factory Resource.failure(F failure) = ResourceFailure;
  static FutureOr<Resource<F, T>> fromRequest<F, T>(
    FutureOr<Resource<F, T>> Function() request, {
    FutureOr<Resource<F, T>> Function(DioError error)? onDioError,
    Map<String, F>? failureMapper,
    F? defaultError,
  }) async {
    assert((failureMapper == null && defaultError == null) || (failureMapper != null && defaultError != null));
    assert((failureMapper == null && onDioError != null) || (failureMapper != null && onDioError == null));

    try {
      return await request.call();
    } on DioError catch (e) {
      if (failureMapper != null && e.response?.data['error'] != null)
        return Resource.failure(failureMapper[e.response?.data['error']] ?? defaultError!);

      return await onDioError!.call(e);
    }
  }

  bool get isNone => this is _ResourceNone;
  bool get isLoading => this is ResourceLoading;
  bool get isSuccess => this is ResourceSuccess;
  bool get isFailure => this is ResourceFailure;

  void whenIsFailure(void Function(F failure) isFailure) {
    if (this is ResourceFailure) {
      isFailure.call((this as ResourceFailure).failure as F);
    }
  }

  void whenIsSuccess(void Function(T resource) isSuccess) {
    if (this is ResourceSuccess) {
      isSuccess.call((this as ResourceSuccess).value as T);
    }
  }

  void when({
    required void Function() isNone,
    required void Function() isLoading,
    required void Function(T resource) isSuccess,
    required void Function(F failure) isFailure,
  }) {
    if (this is _ResourceNone) {
      return isNone.call();
    }

    if (this is ResourceLoading) {
      return isLoading.call();
    }

    if (this is ResourceSuccess) {
      return isSuccess.call((this as ResourceSuccess).value as T);
    }

    if (this is ResourceFailure) {
      return isFailure.call((this as ResourceFailure).failure as F);
    }
  }

  R map<R>({
    required R Function() isNone,
    required R Function() isLoading,
    required R Function(T resource) isSuccess,
    required R Function(F failure) isFailure,
  }) {
    if (this is _ResourceNone) {
      return isNone.call();
    }

    if (this is ResourceLoading) {
      return isLoading.call();
    }

    if (this is ResourceSuccess) {
      return isSuccess.call((this as ResourceSuccess).value as T);
    }

    if (this is ResourceFailure) {
      return isFailure.call((this as ResourceFailure).failure as F);
    }

    return isNone.call();
  }

  void maybeWhen({
    void Function()? isNone,
    void Function()? isLoading,
    void Function(T resource)? isSuccess,
    void Function(F failure)? isFailure,
    required void Function() orElse,
  }) {
    if (this is _ResourceNone && isNone != null) {
      return isNone.call();
    }

    if (this is ResourceLoading && isLoading != null) {
      return isLoading.call();
    }

    if (this is ResourceSuccess && isSuccess != null) {
      isSuccess.call((this as ResourceSuccess).value as T);
      return;
    }

    if (this is ResourceFailure && isFailure != null) {
      return isFailure.call((this as ResourceFailure).failure as F);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function()? isNone,
    R Function()? isLoading,
    R Function(T resource)? isSuccess,
    R Function(F failure)? isFailure,
    required R Function() orElse,
  }) {
    if (this is _ResourceNone && isNone != null) {
      return isNone.call();
    }

    if (this is ResourceLoading && isLoading != null) {
      return isLoading.call();
    }

    if (this is ResourceSuccess && isSuccess != null) {
      return isSuccess.call((this as ResourceSuccess).value as T);
    }

    if (this is ResourceFailure && isFailure != null) {
      return isFailure.call((this as ResourceFailure).failure as F);
    }

    return orElse.call();
  }
}

class _ResourceNone<F, T> extends Resource<F, T> {
  @override
  List<Object?> get props => [];
}

class ResourceLoading<F, T> extends Resource<F, T> {
  @override
  List<Object?> get props => [];
}

class ResourceSuccess<F, T> extends Resource<F, T> {
  final T value;

  const ResourceSuccess(this.value);

  @override
  List<Object?> get props => [value];
}

class ResourceFailure<F, T> extends Resource<F, T> {
  final F failure;

  const ResourceFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
