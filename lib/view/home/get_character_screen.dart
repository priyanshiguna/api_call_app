import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/new_app_model.dart';

class GetCharacterScreen extends StatefulWidget {
  final int? id;
  const GetCharacterScreen({Key? key, this.id}) : super(key: key);

  @override
  State<GetCharacterScreen> createState() => _GetCharacterScreenState();
}

class _GetCharacterScreenState extends State<GetCharacterScreen> {
  final dio = Dio();
  int page = 5;
  SingleCharacterModel? singleCharacterModel;

  @override
  void initState() {
    // TODO: implement initState
    getSingleCharacter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Single Character"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: getSingleCharacter,
            child: const Text("get api call"),
          ),
          if (singleCharacterModel != null)
            Expanded(
                child: Center(
              child: Column(
                children: [
                  // Image.network(singleCharacterModel!.image!),
                  //  Text(singleCharacterModel!.name!),
                  //  Text(singleCharacterModel!.gender!),
                  //  Text(singleCharacterModel!.id!.toString()),
                  Text(singleCharacterModel!.toJson().toString()),
                ],
              ),
            )),
        ],
      ),
    );
  }

  getSingleCharacter() async {
    await dio
        .get("https://rickandmortyapi.com/api/character/${widget.id}")
        .then((value) {
      debugPrint("value --->> $value");
      if (value.statusCode == 200) {
        singleCharacterModel = SingleCharacterModel.fromJson(value.data);
        setState(() {});
      } else if (value.statusCode == 500) {
        debugPrint("Server Not Connected");
      }
    });
  }
}
