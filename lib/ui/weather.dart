

class Weather {
Weather({
  required this.condition,
  required this.description,
  required this.icon,
  required this.temperature
});
  final String description;
  final String icon;
  final double temperature;
  final String condition;

  Weather.fromJson(Map<String, dynamic> json)
  :condition = json['weather'][0]['main'] as String,
  icon = json['weather'][0]['icon'] as String,
  description= json['weather'][0]['description'] as String,
  temperature= json['main']['temp'] as double;
}