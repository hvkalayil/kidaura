import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kidaura/data/country_model.dart';
import 'package:kidaura/data/services.dart';
import 'package:meta/meta.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepo countryRepo;
  List<Country> countryList;

  CountryBloc(this.countryRepo) : super(CountryInitState());

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    switch (event) {
      case CountryEvent.fetchData:
        yield CountryLoadingState();
        try {
          countryList = await countryRepo.getCountryList();
          yield CountryLoadedState(data: countryList);
        } on SocketException {
          yield CountryErrorState(error: 'No Internet');
        } on HttpException {
          yield CountryErrorState(
            error: 'No Service Found',
          );
        } on FormatException {
          yield CountryErrorState(
            error: 'Invalid Response format',
          );
        } catch (e) {
          yield CountryErrorState(
            error: 'Unknown Error',
          );
        }
        break;
    }
  }
}
