import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lesson_task/data/db/database.dart';
import 'package:lesson_task/service/api_provider.dart';

import '../../models/car_model.dart';
import '../../utils/utility_functions.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late CarModel carModel;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiProvider.getCarModelById(
        companyId: widget.id,
      ),
      builder: (context, AsyncSnapshot<CarModel> snapshot) {
        if (snapshot.hasData) {
          carModel = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text("About ${snapshot.data!.carModel}"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await LocalDataBase.insertCar(carModel: carModel);
                UtilityFunctions.getMyToast(message: 'Successfully added');
              },
              child: const Icon(Icons.add),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider.builder(
                  itemCount: snapshot.data!.carPics.length,
                  itemBuilder: (context, index, realIndex) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: SizedBox(
                      height: 200,
                      width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: snapshot.data!.carPics[index],
                        ),
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 200.0,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child:
                            CachedNetworkImage(imageUrl: snapshot.data!.logo),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.carModel,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!.establishedYear.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        "\$ ${snapshot.data!.price.toString()}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ExpansionTile(
                      title: const Text(
                        "About Company",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Text(
                            snapshot.data!.description,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        } else {
          return const Scaffold(
            body:  Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
