import 'package:proyecto_fisica/logic/newton.dart';

void main() {
  Newton newton = Newton(mass1: 0.155, mass2: 0.075, angle: 20);

  print(newton.normal);

  print(newton.weight1X);

  print(newton.weight2);

  print(newton.frictionForce);

  print(newton.acceleration);

  print(newton.tension);

  print(newton.totalMass());

  print(newton.heavier());

  print(newton.angle);

  print(newton.angleToRadians());
}
