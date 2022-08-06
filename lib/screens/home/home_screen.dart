import 'package:flutter/material.dart';
import 'package:lesson_task/screens/about/about_screen.dart';
import 'package:lesson_task/screens/favourites/favourite_screen.dart';
import 'package:lesson_task/screens/home/widgets/car_item_table.dart';
import 'package:lesson_task/service/api_provider.dart';

import '../../models/car_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Companies"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              child: const Icon(Icons.favorite, color: Colors.red,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavouriteScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: FutureBuilder(
          future: ApiProvider.getAllCars(),
          builder: (context, AsyncSnapshot<List<CarModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 15),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: CarItemTable(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutScreen(
                              id: snapshot.data![index].companyId,
                            ),
                          ),
                        );
                      },
                      carModel: snapshot.data![index],
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.hasError) {
              return const Text("error");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
