import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import '../../shared/models/app_error.dart';
import 'base_state.dart';

abstract class BaseCubit<T extends BaseState> extends Cubit<T> {
  BaseCubit(super.initialState);

  AppError _mapFailureToError(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return AppError.network(failure.message);
      case ServerFailure:
        return AppError.server(failure.message);
      case NotFoundFailure:
        return AppError.notFound(failure.message);
      case AuthenticationFailure:
      case AuthorizationFailure:
        return AppError.unauthorized(failure.message);
      case ValidationFailure:
        return AppError.validation(failure.message);
      default:
        return AppError.unknown(failure.message);
    }
  }

  Future<void> handleEither<R>(
    Future<Either<Failure, R>> either,
    T Function(R data) onSuccess,
    T Function(AppError error) onError,
    T loadingState,
  ) async {
    emit(loadingState);
    
    final result = await either;
    
    result.fold(
      (failure) => emit(onError(_mapFailureToError(failure))),
      (data) => emit(onSuccess(data)),
    );
  }
}
