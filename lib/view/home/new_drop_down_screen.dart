import 'package:api_call_app/model/new_model_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewDropDownScreen extends StatefulWidget {
  const NewDropDownScreen({Key? key}) : super(key: key);

  @override
  State<NewDropDownScreen> createState() => _NewDropDownScreenState();
}

class _NewDropDownScreenState extends State<NewDropDownScreen> {
  Dio dio = Dio();
  int page = 1;
  List data = [];
  int value = 0;
  NewCharacterModel newCharacterModel = NewCharacterModel();

  getApiCall() async {
    await dio
        .get('https://rickandmortyapi.com/api/character?page=$page')
        .then((value) {
      debugPrint("value --->> $value");
      if (value.statusCode == 200) {
        newCharacterModel = NewCharacterModel.fromMap(value.data);
        setState(() {});
      } else if (value.statusCode == 500) {
        debugPrint("Server Not Connected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButton(
          items: data.map((e) {
            return DropdownMenuItem(
              value: e[newCharacterModel],
              child: Text(e[Result]),
            );
          }).toList(),
          value: value,
          onChanged: (v) {
            value = v as int;
            setState(() {});
          },
        ),
      ),
    );
  }
}
