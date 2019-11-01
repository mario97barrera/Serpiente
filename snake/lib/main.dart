import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'snake.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serpiente',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Viborita(title: 'Juego Snake'),
    );
  }
}

class Viborita extends StatefulWidget {
  Viborita({Key key, this.title}) : super(key: key);

  final String title;

  @override
  JuegoSnake createState() => JuegoSnake();
}

class JuegoSnake extends State<Viborita> {
  static const int serFil = 30;
  static const int serCol = 30;
  static const double serTamCel = 10.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Serpiente tarea'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.black45),
              ),
              child: SizedBox(
                height: serFil * serTamCel,
                width: serCol * serTamCel,
                child: Snake(
                  filas: serFil,
                  columnas: serCol,
                  tamCelda: serTamCel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}