import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class Failure implements Exception {}

class InternalErrorException implements Failure {
  InternalErrorException({this.cause = ''});

  final String cause;
}

class ServerFailure implements Failure {
  final int statusCode;
  final String title;
  final String description;

  ServerFailure({
    this.statusCode = 0,
    this.title = "Error",
    this.description = '',
  });
}

Either<Failure, T> handleDioException<T>(DioException error) {
  try {
    if (error.response == null) {
      return Left(InternalErrorException());
    }

    //TODO get title and description error from BE
    return Left(
      ServerFailure(
        statusCode: error.response?.statusCode ?? 0,
        title: "Error Title",
        description: "Error Description",
      ),
    );
  } catch (e) {
    return Left(InternalErrorException());
  }
}
