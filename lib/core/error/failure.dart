import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int code;
  final String message;

  const Failure(this.code, this.message);

  @override
  List<Object> get props => [code, message];

  @override
  String toString() => 'Failure(code: $code, message: $message)';
}
