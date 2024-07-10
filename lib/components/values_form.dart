import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_fisica/components/custom_input.dart';
import 'package:proyecto_fisica/logic/newton.dart';

class ValuesForm extends StatefulWidget {
  final Function newtonChange;
  final Function angleChange;

  const ValuesForm(
      {super.key, required this.newtonChange, required this.angleChange});

  @override
  _ValuesFormState createState() => _ValuesFormState();
}

class _ValuesFormState extends State<ValuesForm> {
  final TextEditingController controllerMasa1 = TextEditingController();
  final TextEditingController controllerMasa2 = TextEditingController();
  final TextEditingController controllerAngulo = TextEditingController();

  get newtonChange => widget.newtonChange;
  get angleChange => widget.angleChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Ingreso de datos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          CustomInput(
            label: 'Masa 1',
            suffix: 'kg',
            controller: controllerMasa1,
          ),
          const SizedBox(height: 20.0),
          CustomInput(
            label: 'Masa 2',
            suffix: 'kg',
            controller: controllerMasa2,
          ),
          const SizedBox(height: 20.0),
          CustomInput(
            label: "Angulo",
            suffix: ' °',
            controller: controllerAngulo,
            inputFormatter: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^(?:[1-9]|[1-8][0-9])$')),
            ],
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 3,
              shadowColor: Colors.black,
            ),
            onPressed: () {
              if (controllerMasa1.text.isEmpty ||
                  controllerMasa2.text.isEmpty ||
                  controllerAngulo.text.isEmpty) {
                newtonChange(Newton.init());

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, ingrese todos los datos'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                newtonChange(Newton(
                  mass1: double.parse(controllerMasa1.text),
                  mass2: double.parse(controllerMasa2.text),
                  angle: double.parse(controllerAngulo.text),
                ));

                angleChange(double.parse(controllerAngulo.text));
              }
            },
            child: Container(
                width: 200,
                alignment: Alignment.center,
                child: const Text('Calcular')),
          ),
        ],
      ),
    );
  }
}
