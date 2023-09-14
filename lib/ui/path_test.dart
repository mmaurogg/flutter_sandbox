import 'dart:math';

import 'package:flavoring_flavorizr/data/data.dart';
import 'package:flutter/material.dart';

class PathTest extends StatelessWidget {
  const PathTest({super.key});

  @override
  Widget build(BuildContext context) {
    var data = DataSheet().drinks;

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
                  /* Container(
                height: MediaQuery.of(context).size.height,
                //width: double.infinity,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: (index % 2 == 0)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Container(
                            color: Colors.red,
                            height: 250,
                            width: 130,
                          )
                        ],
                      ),
                    );
                    ;
                  },
                ),
              ), */

                  Padding(
                padding: const EdgeInsets.only(left: 30),
                child: GridView.builder(
                  itemCount: data.length,
                  reverse: false,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    //crossAxisSpacing: 2,
                    //childAspectRatio: 2,
                    mainAxisExtent: 270,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      /* mainAxisAlignment: (index % 2 == 0)
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end, */
                      children: [
                        Container(
                          color: Colors.white,
                          height: double.infinity,
                          width: 145,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(62.5),
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: (index == 0)
                                            ? Colors.green
                                            : Colors.amberAccent,
                                        borderRadius: BorderRadius.circular(55),
                                      ),
                                      child: Center(
                                        child: Text(data[index].title,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                  'adssfsagfafdasfdasffdafdsafadsfdasfdsafdasfdasfdafdafdafdsafdsafdsafdasfdsafdsafdasfdasfdsafdsafdsafdsafdasfdasfdsafdadasadfsdas'),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text('boton')),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
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

    /* //double x = size.width / 2;
    //double y = size.width / 2;
    double x = 50;
    double y = 50;
    double upperLimit = size.width * 0.9;
    double footerLimit = size.width * 0.15;

    bool isReverse = false;

    for (var i = 0; i < 100; i++) {
      paint..color = availableColors[Random().nextInt(availableColors.length)];
      Path newPath = Path();
      newPath..moveTo(x, y);
      //x *= isReverse ? 1.12 : 0.9;
      //y += isReverse ? -10 : 10;
      x += 10;
      y += 10;
      x = isReverse ? -x : x;
      //y = isReverse ? -y : y;

      path.addPath(
          newPath..lineTo(x, y)
          /* ..arcToPoint(Offset(x * 2, y * 2),
                radius: const Radius.circular(50), clockwise: true),
          */
          ,
          //Offset(x - 20, y - 30)
          Offset.zero);

      if (x > upperLimit || x < footerLimit) {
        isReverse = !isReverse;
      }
    }*/

    ///////////////
    ///
    var width = size.width;
    double x = width / 4;
    double y = width / 10;

    var a = width / 7.43;

    for (var i = 0; i < length; i++) {
      path..moveTo(x, y);
      x += width / 4;
      path..lineTo(x, y);
      y += width / 2;
      path..lineTo(x, y);
      x += width / 4;
      path..lineTo(x, y);
      if (i < (length - 1)) {
        y += a;
        path..lineTo(x, y);
        x -= width / 2;
        path..lineTo(x, y);
        y += a;
        path..lineTo(x, y);
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
