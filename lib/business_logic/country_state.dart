part of 'country_bloc.dart';

@immutable
abstract class CountryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CountryInitState extends CountryState {}

class CountryLoadingState extends CountryState {}

class CountryLoadedState extends CountryState {
  final List<Country> data;

  CountryLoadedState({this.data});
}

class CountryErrorState extends CountryState {
  final String error;

  CountryErrorState({this.error});
}
