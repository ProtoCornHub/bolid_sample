import 'package:equatable/equatable.dart';


// UseCase - abstract class that takes two paarms Type & Params

abstract class UseCase<Type, Params> {
  call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}