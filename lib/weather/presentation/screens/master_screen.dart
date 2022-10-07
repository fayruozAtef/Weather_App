import 'package:flutter/material.dart';

import '../../data/data_source/remote_datasource.dart';
import '../../data/repository/weather_repository.dart';
import '../../domain/entity/weather.dart';
import '../../domain/repository/base_weather_repository.dart';
import '../../domain/use_cases/get_weather_by_countery.dart';

class MasterScreen extends StatefulWidget {
  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  List<String> countries=['Egypt', 'London'];
  String dropDownValue='Egypt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Weather App'),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0,),
            Row(
              children: [
                const Text('Pick the country: ',style: TextStyle(fontSize: 18.0),),
                const SizedBox(width: 5.0,),
                Expanded(
                  child: DropdownButton(
                    value: dropDownValue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,

                    // Array list of items
                    items: countries.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0,),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blue
              ),
              child: MaterialButton(
                onPressed: () async {
                  BaseRemoteDataSource baseRemoteDataSource=RemoteDataSource();
                  BaseWeatherRepository repository=WeatherRepository(baseRemoteDataSource);
                  Weather weather= await GetWeatherByCountry(repository).execute(dropDownValue);
                  weatherDataResult(context, weather);
                },
                child: Text(
                  'Get Weather'.toUpperCase(),
                  style: TextStyle(fontSize: 22.0,color: Colors.white),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future weatherDataResult(BuildContext context,Weather weather){
    return showModalBottomSheet(
      context: context,
      shape:const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(40.0),
          topRight:Radius.circular(40.0),
        ),
      ),
      builder: (context) {
        return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10.0,),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                    const Icon(Icons.location_city_outlined),
                    const SizedBox(width: 20.0,),
                    const Text('City name  ',style: TextStyle(fontSize: 19.0),),
                    Text(' ${weather.cityName} ',style: const TextStyle(fontSize: 18.0, color: Colors.blue),),
                  ],),
                  const SizedBox(height: 30.0,),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                    const Icon(Icons.sunny),
                    const SizedBox(width: 20.0,),
                    const Text('Temperature ',style: TextStyle(fontSize: 19.0),),
                    Text(' ${weather.temp} ',style: const TextStyle(fontSize: 18.0, color: Colors.blue),),
                  ],),
                  const SizedBox(height: 30.0,),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                    const Icon(Icons.compress_outlined),
                    const SizedBox(width: 20.0,),
                    const Text('Pressure ',style: TextStyle(fontSize: 19.0),),
                    Text(' ${weather.pressure} ',style: const TextStyle(fontSize: 18.0, color: Colors.blue),),
                  ],),
                  const SizedBox(height: 30.0,),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                    const Icon(Icons.description),
                    const SizedBox(width: 20.0,),
                    const Text('Description ',style: TextStyle(fontSize: 19.0),),
                    Text(' ${weather.description} ',style: const TextStyle(fontSize: 18.0, color: Colors.blue),),
                  ],),
                  const SizedBox(height: 30.0,),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                    const Icon(Icons.star),
                    const SizedBox(width: 20.0,),
                    const Text('Main ',style: TextStyle(fontSize: 19.0),),
                    Text(' ${weather.main} ',style: const TextStyle(fontSize: 18.0, color: Colors.blue),),
                  ],),
                ],
              ),
            )
        );
      },
    );
  }
}
