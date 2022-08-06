class CarModel {
  int? databaseId;
  String carModel;
  int price;
  String logo;
  int establishedYear;
  int companyId;
  String description;
  List<String> carPics;

  CarModel({
    this.databaseId,
    required this.carPics,
    required this.description,
    required this.carModel,
    required this.price,
    required this.logo,
    required this.establishedYear,
    required this.companyId,
  });

  static CarModel fromJson(Map<String, Object?> json) {
    return CarModel(
      databaseId: json['id'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      carPics: (json['car_pics'] as List?)?.map((e) => e as String? ?? '').toList() ?? [],
      carModel: json['car_model'] as String? ?? '',
      price: json['average_price'] as int? ?? 0,
      logo: json['logo'] as String? ?? '',
      establishedYear: json['established_year'] as int? ?? 0,
      companyId: json['id'] as int? ?? 0,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": companyId,
      "car_model": carModel,
      "average_price": price,
      "logo": logo,
      "established_year": establishedYear
    };
  }
}
