import 'package:flutter/material.dart';
import 'package:proyecto_fisica/components/custom_card.dart';
import 'package:proyecto_fisica/components/custom_text.dart';
import 'package:proyecto_fisica/components/value_with_indice.dart';
import 'package:proyecto_fisica/logic/constants.dart';
import 'package:proyecto_fisica/logic/newton.dart';

class ValuesCard extends StatelessWidget {
  final Newton newton;
  const ValuesCard({Key? key, required this.newton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "Peso 1 en x",
            title: true,
          ),
          ...(newton.weight1X != -1.0
              ? [
                  Row(
                    children: [
                      CustomText(
                          text:
                              "W = Sen(${newton.angle}) * ${newton.mass1} * ${Constants.GRAVITY} "),
                    ],
                  ),
                  CustomText(text: "W = ${newton.weight1X}")
                ]
              : [
                  const Row(
                    children: [
                      CustomText(text: "W = Sen(β) * "),
                      ValueWithIndice(value: "m", indice: 1),
                      CustomText(text: " * g"),
                    ],
                  ),
                  const CustomText(text: "W = W"),
                ]),
          const SizedBox(height: 5.0),
          const CustomText(text: "Peso 1", title: true),
          ...(newton.weight1 != -1.0
              ? [
                  CustomText(
                      text:
                          "W = Cos(${newton.angle}) ${newton.mass1} * ${Constants.GRAVITY}"),
                  CustomText(text: "W = ${newton.weight1}")
                ]
              : [
                  const Row(
                    children: [
                      CustomText(text: "W = "),
                      ValueWithIndice(value: "m", indice: 1),
                      CustomText(text: " * g"),
                    ],
                  ),
                  const CustomText(text: "W = W"),
                ]),
          const CustomText(text: "Peso 2", title: true),
          ...(newton.weight2 != -1.0
              ? [
                  CustomText(
                      text: "W = ${newton.mass2} * ${Constants.GRAVITY} "),
                  CustomText(text: "W = ${newton.weight2}")
                ]
              : [
                  const Row(
                    children: [
                      CustomText(text: "W = "),
                      ValueWithIndice(value: "m", indice: 2),
                      CustomText(text: " * g"),
                    ],
                  ),
                  const CustomText(text: "W = W"),
                ]),
          const SizedBox(height: 5.0),
          const CustomText(
            text: "Normal",
            title: true,
          ),
          ...(newton.normal != -1.0
              ? [
                  CustomText(
                      text: "N = ${newton.weight1X} * Cos(${newton.angle}) "),
                  CustomText(text: "N = ${newton.normal}"),
                ]
              : [
                  const Row(
                    children: [
                      CustomText(text: "N = "),
                      ValueWithIndice(value: "W", indice: 1),
                      CustomText(text: " * Cos(β)"),
                    ],
                  ),
                  const CustomText(text: "N = N"),
                ]),
          const SizedBox(height: 5.0),
          const CustomText(
            text: "Fuerza de fricción",
            title: true,
          ),
          ...(newton.frictionForce != -1.0
              ? [
                  CustomText(text: "Fk = ${Constants.UK} * ${newton.normal} "),
                  CustomText(text: "Fk = ${newton.frictionForce}"),
                ]
              : [
                  const CustomText(text: "Fk = Uk * N "),
                  const CustomText(text: "Fk = Fk"),
                ]),
          const SizedBox(height: 14.0),
        ],
      ),
    ));
  }
}
