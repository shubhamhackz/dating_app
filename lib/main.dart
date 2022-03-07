import 'package:dating_app/widgets/background_curve_widget.dart';
import 'package:dating_app/widgets/cards_stack_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: const [
            BackgroudCurveWidget(),
            CardsStackWidget(),
          ],
        ),
      ),
    );
  }
}

enum Swipe { left, right, none }
