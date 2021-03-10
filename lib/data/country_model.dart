import 'dart:convert';

class Country {
  String name, capital, flag, region, subRegion, population;
  List<String> borders, languages;

  Country(
      {this.name,
      this.capital,
      this.flag,
      this.region,
      this.subRegion,
      this.population,
      this.borders,
      this.languages});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json['name'],
        capital: json['capital'],
        flag: json['flag'],
        region: json['region'],
        subRegion: json['subregion'],
        population: json['population'].toString(),
        borders:
            List<String>.from(json['borders'].map((bord) => bord.toString())),
        languages: List<String>.from(
            json['languages'].map((lang) => lang['name'].toString())),
      );
}

List<Country> countryFromJson(String jsonData) => List<Country>.from(
    jsonDecode(jsonData).map((dataElement) => Country.fromJson(dataElement)));
