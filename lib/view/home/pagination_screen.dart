import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/new_model_screen.dart';

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({Key? key}) : super(key: key);

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  final dio = Dio();
  NewCharacterModel? characterModel;
  ScrollController? scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    getApiCall();
    scrollController!.addListener(pagination);
    super.initState();
  }

  void pagination() {
    debugPrint(
        "scrollController!.position.pixels ---->> ${scrollController!.position.pixels}");
    debugPrint(
        "scrollController!.position.maxScrollExtent ---->> ${scrollController!.position.maxScrollExtent}");

    if ((scrollController!.position.pixels ==
        scrollController!.position.maxScrollExtent)) {
      debugPrint("scroll is max --->>");
      page++;
      getApiCall();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
      ),
      body: characterModel == null
          ? const Text("No data found")
          : ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) => ListTile(
                    leading: ClipOval(
                      child:
                          Image.network(characterModel!.results![index].image!),
                    ),
                    title: Text(characterModel!.results![index].origin!.name!),
                    subtitle:
                        Text(characterModel!.results![index].id!.toString()),
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: characterModel!.results!.length),
    );
  }

  getApiCall() async {
    await dio
        .get('https://rickandmortyapi.com/api/character?page=$page')
        .then((value) {
      debugPrint("value --->> $value");
      if (value.statusCode == 200) {
        if (page == 1) {
          characterModel = NewCharacterModel.fromMap(value.data);
        } else {
          debugPrint(value.data["results"].toString());
          for (var data in value.data["results"]) {
            characterModel!.results!.add(Result.fromMap(data));
          }
          setState(() {});
        }

        if (page == characterModel!.info!.pages) {
          scrollController!.removeListener(pagination);
        }
        setState(() {});
      } else if (value.statusCode == 500) {
        debugPrint("Server Not Connected");
      }
    });
  }
}
