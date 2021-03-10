import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidaura/business_logic/country_bloc.dart';
import 'package:kidaura/data/country_model.dart';

class ScreenTwo extends StatefulWidget {
  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  void initState() {
    super.initState();
    _loadCountry();
  }

  void _loadCountry() =>
      BlocProvider.of<CountryBloc>(context).add(CountryEvent.fetchData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9f6f7),
      appBar: AppBar(
        title: Text('Screen Two'),
      ),
      body: SafeArea(
        child: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            //Error
            if (state is CountryErrorState)
              return _showError(errMsg: state.error);

            //Data fetched
            if (state is CountryLoadedState)
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, n) => _countryItemBuilder(
                    context: context, data: state.data, index: n),
              );

            //Data fetching
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Center _showError({String errMsg}) => Center(
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
            padding: MaterialStateProperty.all(EdgeInsets.all(20)),
          ),
          onPressed: () {},
          child: Text(
            '$errMsg\n Try Again?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
      );

  Container _countryItemBuilder(
      {BuildContext context, List<Country> data, int index}) {
    final Country country = data[index];
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 3, spreadRadius: 1),
          ],
          border:
              Border.all(color: Colors.blueAccent.withOpacity(0.2), width: 5),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          //Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.network(
                  country.flag,
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(
                    country.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
                  )),
              SizedBox()
            ],
          ),
          Divider(thickness: 5),

          //Details
          singleValueDetail(title: 'Capital', detail: country.capital),
          singleValueDetail(title: 'Region', detail: country.region),
          singleValueDetail(title: 'SubRegion', detail: country.subRegion),
          singleValueDetail(title: 'Population', detail: country.population),
          multiValueDetail(title: 'Languages', detail: country.languages),
          multiValueDetail(title: 'Borders', detail: country.borders)
        ],
      ),
    );
  }

  Padding singleValueDetail({String title, String detail}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            Text(
              detail,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      );

  Container multiValueDetail({String title, List<String> detail}) => Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: detail
                  .asMap()
                  .entries
                  .map((e) => Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        e.value,
                        style: TextStyle(color: Colors.white),
                      )))
                  .toList(),
            )
          ],
        ),
      );
}
