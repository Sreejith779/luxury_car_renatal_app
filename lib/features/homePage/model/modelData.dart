class CarModel{
  final int id;
  final String name;
  final double rating;
  final double pricePerHour;
  final double pricePerDay;
  final String description;
  final String engine;
  final double wheelbase;
  final String model;
  final String reviews;
  final String image;
  final String image1;
  final String image2;

  CarModel({required this.id,
    required this.reviews,
    required this.pricePerDay,
    required this.name, required this.rating,
    required this.pricePerHour, required this.description,
    required this.engine, required this.wheelbase,
    required this.model, required this.image,
    required this.image1, required this.image2});

}