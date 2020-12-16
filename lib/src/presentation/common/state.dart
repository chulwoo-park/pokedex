import 'package:equatable/equatable.dart';

abstract class AsyncState extends Equatable {
  const AsyncState();
}

class Initial extends AsyncState {
  const Initial();

  @override
  List<Object?> get props => [];
}

class Loading extends AsyncState {
  const Loading();

  @override
  List<Object?> get props => [];
}

class LoadSuccess<T> extends AsyncState {
  const LoadSuccess(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

class LoadFailure extends AsyncState {
  const LoadFailure(this.error, [this.stackTrace]);

  final Object error;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [error, stackTrace];
}
