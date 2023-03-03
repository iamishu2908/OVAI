import 'package:hive/hive.dart';

 part 'calories_data.g.dart';

@HiveType(typeId: 0)
class CalorieData{
  @HiveField(0)
  final String day;
  @HiveField(1)
  final double value;


  CalorieData({required this.day, required this.value});

}