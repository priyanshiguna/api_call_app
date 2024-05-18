import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/app_model.dart';

class ApiHome extends StatefulWidget {
  const ApiHome({Key? key}) : super(key: key);

  @override
  State<ApiHome> createState() => _ApiHomeState();
}

class _ApiHomeState extends State<ApiHome> {
  Dio dio = Dio();
  int page = 1;
  CharacterModel characterModel = CharacterModel();

  getApiCall() async {
    await dio
        .get('https://rickandmortyapi.com/api/character?page=$page')
        .then((value) {
      debugPrint("value --->> $value");
      if (value.statusCode == 200) {
        characterModel = CharacterModel.fromJson(value.data);
        setState(() {});
      } else if (value.statusCode == 500) {
        debugPrint("Server Not Connected");
      }
    });
  }

  //you can try this
  @override
  void initState() {
    // TODO: implement initState
    getApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //or this
    getApiCall();
    return Scaffold(
      body: ListView.builder(
        itemCount: characterModel.results!.length,
        itemBuilder: (context, index) => ListTile(
          leading: ClipOval(
            child: Image.network(characterModel.results![index].image!),
          ),
          title: Text(characterModel.results![index].origin!.name!),
          subtitle: Text(characterModel.results![index].id!.toString()),
        ),
      ),
    );
  }
}
