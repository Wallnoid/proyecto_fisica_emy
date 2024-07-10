import 'dart:math';

import 'package:proyecto_fisica/logic/constants.dart';
import 'package:proyecto_fisica/utils/maths.dart';

class Newton {
  double tension = 0;
  double acceleration = 0;
  double mass1 = 0;
  double mass2 = 0;
  double angle = 0;
  double frictionForce = 0;
  double normal = 0;
  double weight1 = 0;
  double weight1X = 0;
  double weight2 = 0;

  Newton({required this.mass1, required this.mass2, required this.angle}) {
    angleToRadians();
    calculateWeight1();
    calculateWeight1X();
    calculateWeight2();
    calculateNormal();
    calculateFrictionForce();
    calculateAcceleration();
    calculateTension();
  }

  Newton.init() {
    weight1X = -1;
    weight1 = -1;
    weight2 = -1;
    normal = -1;
    frictionForce = -1;
    tension = -1;
    acceleration = -1;
    mass1 = -1;
    mass2 = -1;
    angle = -1;
  }

  double angleToRadians() {
    return twoDecimalPlaces(angle * (pi / 180));
  }

  void calculateNormal() {
    normal = twoDecimalPlaces(weight1 * cos(angleToRadians()));
  }

  void calculateTension() {
    tension = twoDecimalPlaces(mass2 * acceleration + weight2);
  }

  void calculateAcceleration() {
    if (heavier() == mass1) {
      acceleration =
          twoDecimalPlaces((frictionForce - weight2 + weight1X) / totalMass());
    } else {
      acceleration =
          twoDecimalPlaces((-frictionForce + weight2 - weight1X) / totalMass());
    }
  }

  void calculateWeight1X() {
    weight1X =
        twoDecimalPlaces(mass1 * Constants.GRAVITY * sin(angleToRadians()));
  }

  void calculateWeight1() {
    weight1 = twoDecimalPlaces(mass1 * Constants.GRAVITY);
  }

  void calculateWeight2() {
    weight2 = twoDecimalPlaces(mass2 * Constants.GRAVITY);
  }

  double totalMass() {
    return twoDecimalPlaces(mass1 + mass2);
  }

  double heavier() {
    return mass1 > mass2 ? mass1 : mass2;
  }

  void calculateFrictionForce() {
    frictionForce = twoDecimalPlaces(Constants.UK * normal);
  }
}
