import 'dart:ffi';

class DrinkData {
  final String title;
  final int requiredPoints;
  final String iconImage;
  final double earnedPoints;

  DrinkData(this.title, this.requiredPoints, this.iconImage, this.earnedPoints);
}
