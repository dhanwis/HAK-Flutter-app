import 'package:equatable/equatable.dart';

abstract class NewArrivalsEvent extends Equatable {
  const NewArrivalsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewArrivalsEvent extends NewArrivalsEvent {}
