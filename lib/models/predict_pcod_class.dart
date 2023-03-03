import 'package:hive_flutter/hive_flutter.dart';
part 'predict_pcod_class.g.dart';
@HiveType(typeId: 1)
class ClassPredictPcod extends HiveObject {
  @HiveField(0)
  bool fast_food;
  @HiveField(1)
  bool pregnant;
  @HiveField(2)
  bool weight_gain;
  @HiveField(3)
  bool hair_growth;
  @HiveField(4)
  bool hair_fall;
  @HiveField(5)
  bool pimples;
  @HiveField(6)
  bool exercise;
  @HiveField(7)
  bool darkening_skin;
  @HiveField(8)
  bool predict_PCOD;
  @HiveField(9)
  int pulse;
  @HiveField(10)
  int respiration;
  @HiveField(11)
  int cycle_length;
  @HiveField(12)
  int marriage;
  @HiveField(13)
  int hipsize;
  @HiveField(14)
  int waistsize;
  @HiveField(15)
  int cycleRI;
  @HiveField(16)
  int abortion;
  @HiveField(17)
  DateTime? date;
  @HiveField(18)
  double bmi;
  ClassPredictPcod(
      this.fast_food,
      this.pregnant,
      this.weight_gain,
      this.hair_growth,
      this.hair_fall,
      this.pimples,
      this.exercise,
      this.darkening_skin,
      this.pulse,
      this.respiration,
      this.cycle_length,
      this.marriage,
      this.hipsize,
      this.waistsize,
      this.cycleRI,
      this.abortion,
      this.predict_PCOD,
      this.date,
      this.bmi);
}
