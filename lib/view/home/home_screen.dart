import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/app_model.dart';
import 'get_character_screen.dart';

class ApiCallingScreen extends StatefulWidget {
  const ApiCallingScreen({Key? key}) : super(key: key);

  @override
  State<ApiCallingScreen> createState() => _ApiCallingScreenState();
}

class _ApiCallingScreenState extends State<ApiCallingScreen> {
  final dio = Dio();
  CharacterModel? characterModel;
  int page = 5;

  @override
  void initState() {
    // TODO: implement initState
    getApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Calling"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: getApiCall,
            child: const Text("get api call"),
          ),
          if (characterModel != null)
            Expanded(
              child: ListView.builder(
                itemCount: characterModel!.results!.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetCharacterScreen(
                            id: characterModel!.results![index].id!,
                          ),
                        ));
                  },
                  leading: ClipOval(
                    child:
                        Image.network(characterModel!.results![index].image!),
                  ),
                  title: Text(characterModel!.results![index].origin!.name!),
                  subtitle:
                      Text(characterModel!.results![index].id!.toString()),
                ),
              ),
            ),
        ],
      ),
    );
  }

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
}
