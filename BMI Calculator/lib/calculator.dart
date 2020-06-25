import 'dart:math';

class Calculator {
  final int height;
  final int weight;
  Calculator({this.height, this.weight});
  double _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResults() {
    if (_bmi >= 25) {
      return 'OverWeight';
    } else if (_bmi >= 18.5) {
      return 'Normal';
    } else {
      return 'UnderWeight';
    }
  }

  String getInterPretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight, Try to get some exercise';
    } else if (_bmi >= 18.5) {
      return 'You have a normal body weight!';
    } else {
      return 'You have a lower body weight, You can eat a bit more!';
    }
  }
}
