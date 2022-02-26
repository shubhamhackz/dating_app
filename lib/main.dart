import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 350,
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(64),
                      bottomRight: Radius.circular(64),
                    ),
                  ),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFFFD0E42),
                      Color(0xFFC30F31),
                    ],
                  )),
              child: const Padding(
                padding: EdgeInsets.only(top: 46.0, left: 20.0),
                child: Text(
                  'Discover',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              ),
            ),
            const MyStatefulWidget(),
          ],
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Widget> dragabbleItems = [
    const DragWidget(asset: 'assets/images/avatar_1.png', index: 0),
    const DragWidget(asset: 'assets/images/avatar_2.png', index: 1),
    const DragWidget(asset: 'assets/images/avatar_3.png', index: 2),
    const DragWidget(asset: 'assets/images/avatar_4.png', index: 3),
    const DragWidget(asset: 'assets/images/avatar_5.png', index: 4),
  ];
  // int acceptedData = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 0,
          child: DragTarget<int>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 700.0,
                width: 50.0,
                color: Colors.transparent,
              );
            },
            onAccept: (int index) {
              // setState(() {
              //   acceptedData += data;
              // });
              setState(() {
                dragabbleItems.removeAt(index);
              });
            },
          ),
        ),
        Positioned(
          right: 0,
          child: DragTarget<int>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 700.0,
                width: 50.0,
                color: Colors.transparent,
              );
            },
            onAccept: (int index) {
              // setState(() {
              //   acceptedData += data;
              // });
              setState(() {
                dragabbleItems.removeAt(index);
              });
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(dragabbleItems.length, (index) {
                if (index == 0) {
                  return dragabbleItems[index];
                } else {
                  return Positioned(
                    bottom: index * 12.0,
                    child: dragabbleItems[index],
                  );
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class DragWidget extends StatefulWidget {
  const DragWidget({Key? key, required this.asset, required this.index})
      : super(key: key);
  final String asset;
  final int index;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  double angle = 12;

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      // Data is the value this Draggable stores.
      data: widget.index,
      // feedback: Transform.rotate(
      //   angle: math.pi / 9,
      //   child: SwipeCard(color: widget.color),
      // ),
      feedback: RotatedCard(asset: widget.asset),

      childWhenDragging: Container(
        color: Colors.transparent,
      ),

      child: SwipeCard(asset: widget.asset),
    );
  }
}

class SwipeCard extends StatelessWidget {
  const SwipeCard({Key? key, required this.asset}) : super(key: key);
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      width: 340,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                asset,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 80,
              width: 340,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rohini',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      fontSize: 21,
                    ),
                  ),
                  Row(
                    children: const [
                      Text(
                        '10 miles away',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RotatedCard extends StatefulWidget {
  const RotatedCard({Key? key, required this.asset}) : super(key: key);
  final String asset;

  @override
  _RotatedCardState createState() => _RotatedCardState();
}

class _RotatedCardState extends State<RotatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 0.1 * 0.3).animate(_controller),
      child: SwipeCard(asset: widget.asset),
    );
  }
}
