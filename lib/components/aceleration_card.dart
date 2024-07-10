import 'package:flutter/material.dart';
import 'package:proyecto_fisica/components/custom_card.dart';
import 'package:proyecto_fisica/components/custom_text.dart';
import 'package:proyecto_fisica/components/line_text.dart';
import 'package:proyecto_fisica/components/value_with_indice.dart';
import 'package:proyecto_fisica/logic/newton.dart';

class AcelerationCard extends StatelessWidget {
  final Newton newton;
  const AcelerationCard({Key? key, required this.newton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "Resolución de aceleracion",
          title: true,
        ),

        const SizedBox(height: 20.0),

        ...(newton.acceleration != -1.0
            ? [
                CustomText(text: "Σ Fx = ${newton.totalMass()} * a  "),
                const SizedBox(height: 8.0),
                ...(newton.heavier() == newton.mass1
                    ? [
                        Row(children: [
                          CustomText(
                              text:
                                  "${newton.weight1X} + ${newton.frictionForce} + "),
                          LineText(text: "T", strikeThroughIndex: 0),
                          const CustomText(text: " - "),
                          LineText(text: "T", strikeThroughIndex: 0),
                          CustomText(
                              text:
                                  " - ${newton.weight2} = ${newton.totalMass()} * a")
                        ]),
                        const SizedBox(height: 8.0),
                        CustomText(
                            text:
                                "a = ${newton.weight1X} + ${newton.frictionForce} - ${newton.weight2} / ${newton.totalMass()}"),
                        CustomText(text: "a = ${newton.acceleration}"),
                      ]
                    : [
                        Row(children: [
                          CustomText(
                              text:
                                  "- ${newton.weight1X} - ${newton.frictionForce} + "),
                          LineText(text: "T", strikeThroughIndex: 0),
                          const CustomText(text: " -"),
                          LineText(text: "T", strikeThroughIndex: 0),
                          CustomText(
                              text:
                                  " + ${newton.weight2} = ${newton.totalMass()} * a")
                        ]),
                        const SizedBox(height: 8.0),
                        CustomText(
                            text:
                                "a = - ${newton.weight1X} - ${newton.frictionForce} + ${newton.weight2} / ${newton.totalMass()}"),
                        const SizedBox(height: 8.0),
                        CustomText(text: "a = ${newton.acceleration}"),
                      ]),
              ]
            : [
                const Row(
                  children: [
                    CustomText(text: "Σ Fx = ("),
                    ValueWithIndice(value: "m", indice: 1),
                    CustomText(text: " + "),
                    ValueWithIndice(value: "m", indice: 2),
                    CustomText(text: " ) * a"),
                  ],
                ),

                const SizedBox(height: 8.0),

                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueWithIndice(value: "± Wx", indice: 1),
                    CustomText(text: " ± Fk + T - T ± "),
                    ValueWithIndice(value: "W", indice: 2),
                    CustomText(text: " = ( "),
                    ValueWithIndice(value: "m", indice: 1),
                    CustomText(text: " + "),
                    ValueWithIndice(value: "m", indice: 2),
                    CustomText(text: " ) * a"),
                  ],
                ),

                const SizedBox(height: 8.0),
                //a = -Wx1 - Fk + T - T + W2/(m1+m2)
                const Row(
                  children: [
                    CustomText(text: "a = "),
                    ValueWithIndice(value: "± Wx ", indice: 1),
                    CustomText(text: " ± Fk + T - T ± "),
                    ValueWithIndice(value: "W", indice: 2),
                    CustomText(text: " / ( "),
                    ValueWithIndice(value: "m", indice: 1),
                    CustomText(text: " + "),
                    ValueWithIndice(value: "m", indice: 2),
                    CustomText(text: " )"),
                  ],
                ),

                const SizedBox(height: 8.0),

                const CustomText(text: "a = a"),
              ]),

        const SizedBox(height: 20.0),

        //CustomText(),
      ],
    ));
  }
}
