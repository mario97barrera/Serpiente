import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

main()=>runApp(Snake());

class Snake extends StatefulWidget {
  Snake({this.filas = 20, this.columnas = 20, this.tamCelda = 10.0}) {

  }

  final int filas;
  final int columnas;
  final double tamCelda;

  @override
  State<StatefulWidget> createState() => SerpEstado(filas, columnas, tamCelda);
}

class SnakeP extends CustomPainter {
  SnakeP(this.state, this.celTam);

  GameState state;
  double celTam;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint blackLine = Paint()..color = Colors.black45;
    final Paint blackFilled = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromPoints(Offset.zero, size.bottomLeft(Offset.zero)),
      blackLine,
    );
    for (math.Point<int> p in state.body) {
      final Offset a = Offset(celTam * p.x, celTam * p.y);
      final Offset b = Offset(celTam * (p.x + 1), celTam * (p.y + 1));

      canvas.drawRect(Rect.fromPoints(a, b), blackFilled);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SerpEstado extends State<Snake> {
  SerpEstado(int fila, int colum, this.tamCel) {
    state = GameState(fila, colum);
  }

  double tamCel;
  GameState state;
  AccelerometerEvent accelera;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: SnakeP(state, tamCel));
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelera = event;
      });
    });

    Timer.periodic(const Duration(milliseconds: 200), (_) {
      setState(() {
        _step();
      });
    });
  }

  void _step() {
    final math.Point<int> newDirection = accelera == null
        ? null
        : accelera.x.abs() < 1.0 && accelera.y.abs() < 1.0
            ? null
            : (accelera.x.abs() < accelera.y.abs())
                ? math.Point<int>(0, accelera.y.sign.toInt())
                : math.Point<int>(-accelera.x.sign.toInt(), 0);
    state.step(newDirection);
  }
}

class GameState {
  GameState(this.rows, this.columns) {
    snakeLength = math.min(rows, columns) - 5;
  }

  int rows;
  int columns;
  int snakeLength;

  List<math.Point<int>> body = <math.Point<int>>[const math.Point<int>(0, 0)];
  math.Point<int> direccion = const math.Point<int>(1, 0);

  void step(math.Point<int> newDirection) {
    math.Point<int> next = body.last + direccion;
    next = math.Point<int>(next.x % columns, next.y % rows);

    body.add(next);
    if (body.length > snakeLength) body.removeAt(0);
    direccion = newDirection ?? direccion;
  }
}