import 'package:http/http.dart' as http;
import 'package:kidaura/data/country_model.dart';

abstract class CountryRepo {
  Future<List<Country>> getCountryList();
}

class CountryServices implements CountryRepo {
  static const authority = 'restcountries.eu';
  static const region = '/rest/v2/region/asia';

  @override
  Future<List<Country>> getCountryList() async {
    Uri uri = Uri.https(authority, region);
    final res = await http.get(uri);
    return countryFromJson(res.body);
  }
}
