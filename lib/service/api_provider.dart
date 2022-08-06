import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:http/http.dart';
import 'package:lesson_task/models/car_model.dart';

class ApiProvider {
  static Future<List<CarModel>> getAllCars() async {
    try {
      Response response = await https
          .get(Uri.parse('https://easyenglishuzb.free.mockoapp.net/companies'));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        List<CarModel> gotCars = ((jsonDecode(response.body))['data'] as List?)
                ?.map((e) => CarModel.fromJson(e))
                .toList() ??
            [];
        return gotCars;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<CarModel> getCarModelById({required int companyId}) async {
    try {
      Response response = await https.get(Uri.parse(
          "https://easyenglishuzb.free.mockoapp.net/companies/$companyId"));
      CarModel carModel = CarModel.fromJson(jsonDecode(response.body));
      
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return carModel;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
