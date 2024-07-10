import 'package:flutter/material.dart';
import 'package:proyecto_fisica/components/custom_card.dart';
import 'package:proyecto_fisica/components/custom_text.dart';
import 'package:proyecto_fisica/components/value_with_indice.dart';
import 'package:proyecto_fisica/logic/constants.dart';
import 'package:proyecto_fisica/logic/newton.dart';

class TensionCard extends StatelessWidget {
  final Newton newton;
  const TensionCard({Key? key, required this.newton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "Resolución de tension: Diagrama 2",
          title: true,
        ),

        const SizedBox(height: 15.0),

        ...(newton.tension != -1.0
            ? [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [],
                    ),
                    CustomText(
                        text:
                            "Σ Fx = ${newton.mass2} * ${newton.acceleration}"),
                    const SizedBox(height: 8.0),
                    CustomText(
                        text:
                            "T - ${newton.weight2} = ${newton.mass2} * ${newton.acceleration}"),
                    const SizedBox(height: 8.0),
                    CustomText(
                        text:
                            "T = ( ${newton.mass2} * ${Constants.GRAVITY} ) + ( ${newton.mass2} * ${newton.acceleration} )"),
                    const SizedBox(height: 8.0),
                    CustomText(text: "T = ${newton.tension}"),
                  ],
                )
              ]
            : [
                const Row(
                  children: [
                    CustomText(text: "Σ Fx = "),
                    ValueWithIndice(value: "m", indice: 2),
                    CustomText(text: " * a"),
                  ],
                ),
                const SizedBox(height: 8.0),

                const Row(
                  children: [
                    CustomText(text: "T - "),
                    ValueWithIndice(value: "W", indice: 2),
                    CustomText(text: " = "),
                    ValueWithIndice(value: "m", indice: 2),
                    CustomText(text: " * a"),
                  ],
                ),

                const SizedBox(height: 8.0),
                //a = -Wx1 - Fk + T - T + W2/(m1+m2)
                const Row(
                  children: [
                    CustomText(text: "T = ( "),
                    ValueWithIndice(value: "m", indice: 2),
                    CustomText(text: " * g ) + ( "),
                    ValueWithIndice(value: "m", indice: 2),
                    CustomText(text: " * a )"),
                  ],
                ),

                const SizedBox(height: 8.0),

                const CustomText(text: "T = T"),
              ]),

        const SizedBox(height: 10.0),

        //CustomText(),
      ],
    ));
  }
}
