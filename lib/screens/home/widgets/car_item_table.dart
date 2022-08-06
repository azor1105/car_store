import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lesson_task/models/car_model.dart';

class CarItemTable extends StatelessWidget {
  const CarItemTable({
    required this.onTap,
    Key? key,
    required this.carModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 5,
              blurRadius: 5,
              color: Colors.grey.shade300,
              offset: const Offset(1, 3),
            )
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CachedNetworkImage(imageUrl: carModel.logo),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carModel.carModel,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  carModel.establishedYear.toString(),
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
              "\$ ${carModel.price.toString()}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final VoidCallback onTap;
  final CarModel carModel;
}
