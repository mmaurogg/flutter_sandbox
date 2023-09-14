import 'dart:math';

import 'package:flavoring_flavorizr/data/data.dart';
import 'package:flutter/material.dart';

class PathHorizontal extends StatelessWidget {
  const PathHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    var data = DataSheet().drinks;
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: 200,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: CustomPaint(
                painter: _PathPainter(length: DataSheet().drinks.length / 2),
                child:
                    //
                    Stack(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: !(index % 2 == 0)
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                left: 10,
                                right: 10,
                              ),
                              child: SizedBox(
                                height: 160,
                                width: size.width * .94,
                                child: _cardInfo(
                                  isReverse: (index % 2 == 0),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}

class _cardInfo extends StatelessWidget {
  bool isReverse;

  _cardInfo({
    super.key,
    required this.isReverse,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isReverse)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text("TITLE"),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(55),
                    ),
                  ),
                  Text("0%"),
                ],
              ),
            ),
          ),

        //Info body
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DataSheet().textLarge,
                      style: TextStyle(fontSize: 11),
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('Conoce más'))
                  ],
                ),
              ),
            )),
        if (!(isReverse))
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("TITLE"),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(55),
                    ),
                  ),
                  Text("0%"),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _PathPainter extends CustomPainter {
  double length;
  _PathPainter({required this.length});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = availableColors[0
          //Random().nextInt(availableColors.length)
          ]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Path path = Path();

    ///////////////
    var width = size.width;
    var height = size.height;
    double x = 80;
    double y = 100;

    var a = width / 7.43;

    for (var i = 0; i < length; i++) {
      path..moveTo(x, y);
      if (length < 2) {
        y += 100;
        path..lineTo(x, y);
        x += 240;
        path..lineTo(x, y);
        y += 100;
        path..lineTo(x, y);
      }

      if (length % 2 == 0) {
        y += 100;
        path..lineTo(x, y);
        x += 240;
        path..lineTo(x, y);
        y += 100;
        path..lineTo(x, y);
        if (i < length - 1) {
          y += 100;
          path..lineTo(x, y);
          x -= 240;
          path..lineTo(x, y);
          y += 100;
          path..lineTo(x, y);
        }
      } else {
        if (i < length - 1) {
          y += 100;
          path..lineTo(x, y);
          x += 240;
          path..lineTo(x, y);
          y += 200;
          path..lineTo(x, y);
          x -= 240;
          path..lineTo(x, y);
          y += 100;
          path..lineTo(x, y);
        }
      }
    }

    ///
    //path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

List<Color> get availableColors => <Color>[
      Colors.purple,
      Colors.yellow,
      Colors.blue,
      Colors.orange,
      Colors.pink,
      Colors.red,
    ];
