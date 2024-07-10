import 'package:flutter/material.dart';
import 'package:proyecto_fisica/components/aceleration_card.dart';
import 'package:proyecto_fisica/components/custom_card.dart';
import 'package:proyecto_fisica/components/custom_chip.dart';
import 'package:proyecto_fisica/components/custom_text.dart';
import 'package:proyecto_fisica/components/identifiers.dart';
import 'package:proyecto_fisica/components/tension_card.dart';
import 'package:proyecto_fisica/components/value_with_indice.dart';
import 'package:proyecto_fisica/components/values_card.dart';
import 'package:proyecto_fisica/components/values_form.dart';
import 'package:proyecto_fisica/graphics/free_body_diagram_painter.dart';
import 'package:proyecto_fisica/graphics/second_diagram_painter.dart';
import 'package:proyecto_fisica/graphics/triangle_painter.dart';
import 'package:proyecto_fisica/logic/constants.dart';
import 'package:proyecto_fisica/logic/newton.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

void main() {
  runApp(const MyApp());
  if (Platform.isWindows) {
    setWindowFullScreen();
  }
}

void setWindowFullScreen() {
  final hwnd = GetForegroundWindow();
  var style = GetWindowLongPtr(hwnd, WINDOW_LONG_PTR_INDEX.GWL_STYLE);
  style &= ~WINDOW_STYLE.WS_OVERLAPPEDWINDOW;
  SetWindowLongPtr(hwnd, WINDOW_LONG_PTR_INDEX.GWL_STYLE, style);

  final monitor =
      MonitorFromWindow(hwnd, MONITOR_FROM_FLAGS.MONITOR_DEFAULTTONEAREST);
  final monitorInfo = calloc<MONITORINFO>()..ref.cbSize = sizeOf<MONITORINFO>();
  GetMonitorInfo(monitor, monitorInfo);

  final rc = monitorInfo.ref.rcMonitor;
  SetWindowPos(
    hwnd,
    NULL,
    rc.left,
    rc.top,
    rc.right - rc.left,
    rc.bottom - rc.top,
    SET_WINDOW_POS_FLAGS.SWP_NOZORDER |
        SET_WINDOW_POS_FLAGS.SWP_NOACTIVATE |
        SET_WINDOW_POS_FLAGS.SWP_FRAMECHANGED,
  );

  calloc.free(monitorInfo);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            primary: Color(0xFFE81E4A),
            onPrimary: Colors.white,
            primaryContainer: Color(0xFFF9C6D1)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Grupo 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double mass1 = 0;
  double mass2 = 0;
  double angle = 30;

  Newton newton = Newton.init();

  void newtonChange(Newton newton) {
    setState(() {
      this.newton = newton;
    });
  }

  void getAngle(double angle) {
    setState(() {
      this.angle = angle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                setState(() {
                  mass1 = 0;
                  mass2 = 0;
                  angle = 30;
                  newton = Newton.init();
                });
              },
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 20.0, bottom: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomChip(
                  label: 'g = ${Constants.GRAVITY} m/s² ',
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(width: 10.0),
                CustomChip(
                  label: 'Uk = ${Constants.UK}',
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                CustomCard(
                    child: ValuesForm(
                  newtonChange: newtonChange,
                  angleChange: getAngle,
                )),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(children: [
                              AcelerationCard(newton: newton),
                              const SizedBox(height: 10.0),
                              TensionCard(newton: newton),
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                ValuesCard(newton: newton)
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCard(
                      child: Column(
                    children: [
                      CustomText(text: "Triangulo de fuerzas", title: true),
                      const SizedBox(height: 40.0),
                      Container(
                          width: 230,
                          height: 200,
                          child: TrianglePainter(
                            angle: angle,
                          )),
                    ],
                  )),
                  const SizedBox(width: 20.0),
                  CustomCard(
                      child: Column(
                    children: [
                      CustomText(text: "Diagrama 1", title: true),
                      const SizedBox(height: 10.0),
                      Container(
                        width: 230,
                        height: 230,
                        child: FreeBodyDiagramPainter(
                          angle: angle,
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(width: 20.0),
                  CustomCard(
                      child: Column(
                    children: [
                      CustomText(text: "Diagrama 2", title: true),
                      const SizedBox(height: 10.0),
                      Container(
                        width: 230,
                        height: 230,
                        child: SecondDiagramPainter(),
                      ),
                    ],
                  )),
                  const SizedBox(width: 20.0),
                  CustomCard(
                      child: Container(
                    width: 230,
                    height: 260,
                    child: const Column(
                      children: [
                        CustomText(text: "Leyendas", title: true),
                        SizedBox(height: 10.0),
                        Identifiers(
                            text: CustomText(text: "Masa 1"),
                            color: Colors.purple),
                        Identifiers(
                            text: CustomText(text: "Masa 2"),
                            color: Colors.orangeAccent),
                        Identifiers(
                            text: CustomText(text: "N"), color: Colors.green),
                        Identifiers(
                            text: ValueWithIndice(value: "W", indice: 2),
                            color: Colors.blueGrey),
                        Identifiers(
                            text: CustomText(text: "T"), color: Colors.pink),
                        Identifiers(
                            text: CustomText(text: "Fk"), color: Colors.lime),
                        Identifiers(
                            text: ValueWithIndice(value: "W", indice: 1),
                            color: Colors.blue),
                      ],
                    ),
                  )),
                ])
          ],
        ),
      ),
    );
  }
}
