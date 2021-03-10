import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kidaura/business_logic/country_bloc.dart';
import 'package:kidaura/data/services.dart';

void main() {
  CountryBloc countryBloc;
  CountryRepo countryRepo;

  setUp(() {
    countryBloc = CountryBloc(countryRepo);
  });

  group('Country Data Requested', () {
    blocTest(
        'emits [CountryInitState, CountryLoadingState, CountryLoadedState] when '
        'fetchData is added and getCountryList succeeds', build: () {
      countryBloc.add(CountryEvent.fetchData);
    }, expect: [
      CountryInitState(),
      CountryLoadingState(),
      CountryLoadedState()
    ]);
  });

  tearDown(() {
    countryBloc?.close();
  });
}
