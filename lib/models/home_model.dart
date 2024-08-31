class HomeModel {
  // int id;
  int userId;
  int id;
  int title;
  double temp;
  int timezone;
  String name;
  String weather;
  int pressure;
  int humidity;
  var feels_like;
  HomeModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.temp,
    required this.timezone,
    required this.name,
    required this.weather,
    required this.pressure,
    required this.humidity,
    required this.feels_like,
  });
}