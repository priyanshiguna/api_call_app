import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/users_model.dart';

class CardOpreationScreen extends StatefulWidget {
  const CardOpreationScreen({Key? key}) : super(key: key);

  @override
  State<CardOpreationScreen> createState() => _CardOpreationScreenState();
}

class _CardOpreationScreenState extends State<CardOpreationScreen> {
  final dio = Dio();
  int page = 1;
  List<UsersData>? userdata;

  @override
  void initState() {
    //TODO implement initState
    getApiData();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("api calling"),
        ),
        body: (userdata != null)
            ? Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          getApiData();
                          setState(() {});
                          putApiCall();
                          setState(() {});
                          postApiCall();
                          setState(() {});
                          deleteApiCall();
                          setState(() {});
                        },
                        leading: ClipOval(
                          child: Image.network(userdata![index].avatar!),
                        ),
                        title: Text(userdata![index].name!),
                        trailing: Text(userdata![index].id.toString()),
                      ),
                      itemCount: userdata!.length,
                      separatorBuilder: (context, index) => const SizedBox(),
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator());
  }

  getApiData() async {
    await dio
        .get('https://644cccf6cfdddac970968b84.mockapi.io/api/users')
        .then((value) {
      debugPrint("value ---> $value");
      if (value.statusCode == 200) {
        userdata = usersDataFromMap(jsonEncode(value.data));
        setState(() {});
      } else if (value.statusCode == 500) {
        debugPrint("Server Not Connect");
      }
    });
  }

  deleteApiCall() async {
    await dio
        .delete('https://644e59994e86e9a4d8f69b1b.mockapi.io/api/users')
        .then((value) {
      debugPrint("value ---> $value");
      if (value.statusCode == 200) {
        userdata = usersDataFromMap(jsonEncode(value.data));
        setState(() {});
      } else if (value.statusCode == 500) {
        debugPrint("Server Not Connect");
      }
    });
  }

  putApiCall() async {
    final FormData formData = FormData.fromMap({
      "name": "Wilbert Bins",
      "createAt": "2023-04-30T02:28:56.112Z",
      "avatar":
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/67.jpg",
      "id": "1",
    });
    await dio
        .put(
      'https://644cccf6cfdddac970968b84.mockapi.io/api/users/1',
      data: formData,
    )
        .then((value) {
      debugPrint("value ---> $value");
      if (value.statusCode == 200) {
        userdata = usersDataFromMap(jsonEncode(value.data));
        setState(() {});
      } else if (value.statusCode == 500) {
        debugPrint("Server Not Connect");
      }
    });
  }

  postApiCall() async {
    final FormData formData = FormData.fromMap({
      "email": "Wilbert Bins",
      "password": "2023-04-30T02:28:56.112Z",
    });
    await dio
        .put(
      'https://644cccf6cfdddac970968b84.mockapi.io/api/users',
      options: Options(
        headers: {
          // 'Authorization': 'Bearer ${YOUR_ACCESS_TOKEN}',
        },
      ),
      data: formData,
    )
        .then((value) {
      debugPrint("value ---> $value");
      if (value.statusCode == 200) {
        //userdata = userDataFromMap(jsonEncode(value.data));
        setState(() {});
      } else if (value.statusCode == 500) {
        debugPrint("Server Not Connect");
      }
    });
  }
}
