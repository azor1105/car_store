import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lesson_task/data/db/database.dart';
import 'package:lesson_task/models/car_model.dart';
import 'package:lesson_task/utils/utility_functions.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<CarModel> favouriteCars = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Cars"),
      ),
      body: FutureBuilder(
        future: LocalDataBase.getFavouriteCars(),
        builder: (context, AsyncSnapshot<List<CarModel>> snapshot) {
          if (snapshot.hasData) {
            favouriteCars = snapshot.data!;
            return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemCount: favouriteCars.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (v) {
                      LocalDataBase.deleteFavouriteCarById(
                          favouriteCars[index].databaseId!);
                      UtilityFunctions.getMyToast(
                          message: "Successfully deleted");
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 5,
                              blurRadius: 5,
                              color: Colors.grey.shade300,
                              offset: const Offset(1, 3),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 70,
                              child: CachedNetworkImage(
                                imageUrl: favouriteCars[index].logo,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  favouriteCars[index].carModel,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${favouriteCars[index].establishedYear} year",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Center(
                            child: Text(
                              '\$ ${favouriteCars[index].price}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
