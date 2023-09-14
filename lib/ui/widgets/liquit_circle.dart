import 'dart:math';

import 'package:flavoring_flavorizr/models/drink_data.dart';
import 'package:flavoring_flavorizr/ui/widgets/liquid_painter.dart';
import 'package:flavoring_flavorizr/ui/widgets/rounded_shadow.dart';
import 'package:flutter/material.dart';

class LiquitCircle extends StatefulWidget {
  final Function(DrinkData)? onTap;

  final bool isOpen;
  final DrinkData? drinkData;

  const LiquitCircle({
    Key? key,
    this.onTap,
    required this.isOpen,
    this.drinkData,
  }) : super(key: key);

  @override
  _LiquitCircleState createState() => _LiquitCircleState();
}

class _LiquitCircleState extends State<LiquitCircle>
    with SingleTickerProviderStateMixin {
  bool? _wasOpen;
  late Animation<double> _fillTween;
  late Animation<double> _pointsTween;

  late AnimationController _liquidSimController;

  final LiquidSimulation _liquidSim1 = LiquidSimulation();
  final LiquidSimulation _liquidSim2 = LiquidSimulation();

  @override
  void initState() {
    super.initState();
    _liquidSimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _liquidSimController!.addListener(_rebuildIfOpen);

    // Raises the fill level of the card
    _fillTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _liquidSimController!,
        curve: const Interval(.12, .45, curve: Curves.easeOut),
      ),
    );

    // Tween to animate the 'points remaining' text
    _pointsTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _liquidSimController!,
        curve: const Interval(.1, .5, curve: Curves.easeOutQuart),
      ),
    );
  }

  @override
  void dispose() {
    _liquidSimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the points required text value, using the _pointsTween
    // THIS DECREASES THE POINTS...
    final pointsRequired = widget.drinkData!.requiredPoints;
    final pointsValue = pointsRequired -
        _pointsTween.value *
            min(widget.drinkData!.earnedPoints, pointsRequired);

    // print('>>> $pointsValue');

    // print('IS OPEN >>>> ${widget.isOpen}');
    if (widget.isOpen != _wasOpen) {
      // SHOW ANIMS ONLY IF CARD IS OPEN..
      if (widget.isOpen) {
        _liquidSim1.start(_liquidSimController, true);
        _liquidSim2.start(_liquidSimController, false);

        _liquidSimController!.forward(from: 0);

        // print('INSIDE INNNER IF');
      }
      // print('OUTSIDE IF');

      _wasOpen = widget.isOpen; // EITHER FALSE OR TRUE....
    }

    // print('WAS OPEN >>>> $_wasOpen');

    /// widget.earnedPoints -> always same 150.0
    /// Value is taken min. b/w 1 and the division...(as animation max value is 1.0)
    final double _maxFillLevel = min(
      1,
      widget.drinkData!.earnedPoints / widget.drinkData!.requiredPoints,
    );

    final double fillLevel = _maxFillLevel;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(62.5),
        ),
        curve: !_wasOpen! ? const ElasticOutCurve(.9) : Curves.elasticOut,
        duration: Duration(milliseconds: !_wasOpen! ? 1200 : 1500),
        height: 125,
        child:
            /* Container(
          child: Stack(children: [
            AnimatedOpacity(
              opacity: widget.isOpen ? 1 : 0,
              //0,
              duration: const Duration(milliseconds: 500),
              child: _buildLiquidBackground(_maxFillLevel, fillLevel),
            ),
            Container(
              height: 125,
              width: 125,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(62.5),
              ),
              child: Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(62.5),
                ),
                child: Center(
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(55),
                    ),
                    child: Center(
                      child: Text(widget.drinkData!.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ), */

            /* Container(
          height: 125,
          width: 125,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(62.5),
          ),
          child: Container(
            height: 125,
            width: 125,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(62.5),
            ),
            child: Center(
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(55),
                ),
                child: Stack(children: [
                  // RESPONSIBLE FOR OPACITY FOR THE WAVES..
                  AnimatedOpacity(
                    opacity: widget.isOpen ? 1 : 0,
                    //0,
                    duration: const Duration(milliseconds: 500),
                    child: _buildLiquidBackground(_maxFillLevel, fillLevel),
                  ),
                  Center(
                    child: Text(widget.drinkData!.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    ); */

            Container(
          height: 125,
          width: 125,
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(62.5),
          ),
          child: Center(
            child: CustomPaint(
              painter: _MyPainter(),
              child: Stack(
                children: [
                  // RESPONSIBLE FOR OPACITY FOR THE WAVES..
                  AnimatedOpacity(
                    opacity: widget.isOpen ? 1 : 0,
                    //0,
                    duration: const Duration(milliseconds: 500),
                    child: _buildLiquidBackground(_maxFillLevel, fillLevel),
                  ),
                  Center(
                    child: Text(widget.drinkData!.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            /* Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(55),
              ),
              child: Stack(fit: StackFit.expand, children: [
                Center(
                  child: Text(widget.drinkData!.title,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                AnimatedOpacity(
                  opacity: widget.isOpen ? 1 : 0,
                  //0,
                  duration: const Duration(milliseconds: 500),
                  child: _buildLiquidBackground(_maxFillLevel, fillLevel),
                ),
              ]),
            ),*/
          ),
        ),
      ),
    );
  }

  _buildLiquidBackground(double _maxFillLevel, double fillLevel) {
    // RESPONSIBLE FOR MAKING THE WAVE FROM BOTTOM TO UP...
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform.translate(
          offset: Offset(
            0,
            //esta es la operacion de la ola
            125 * 1.2 - (125 * _fillTween.value * _maxFillLevel * 1.2),
          ),
          child: CustomPaint(
            painter: LiquidPainter(
              fillLevel,
              _liquidSim1,
              _liquidSim2,
              waveHeight: 100,
            ),
          ),
        ),
      ],
    );
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap!(widget.drinkData!);
    }
  }

  void _rebuildIfOpen() {
    if (widget.isOpen) {
      setState(() {});
    }
  }
}

class _MyPainter extends CustomPainter {
  final String? statusBonus;
  final bool? isExpired;

  _MyPainter({this.statusBonus, this.isExpired});

  @override
  void paint(Canvas canvas, Size size) {
    var color = Colors.white10;

    var paint = Paint()..color = color;

    //canvas.drawCircle(Offset(size.width * 0.90, size.height * 0.5), 69, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _FilterOption extends StatelessWidget {
  final String label;
  final String color;
  final Function filter;
  final bool isSelected;
  final GestureTapCallback? onTap;
  final bool isFilterSelected;
  final String? iconPath;

  _FilterOption({
    required this.label,
    required this.color,
    required this.filter,
    this.isSelected = true,
    this.onTap,
    this.isFilterSelected = false,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Card(
                    elevation: 0.0,
                    shape: const CircleBorder(),
                    color: Colors.red,
                    child:
                        //probar en liquit cicle
                        CustomPaint(
                      painter: _MyPainter(),
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 1.5,
                              left: 0.7,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                  width: 45.0,
                                  height: 45.0,
                                  child: Container(
                                    color: Colors.blue,
                                    height: 100,
                                    width: 100,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                isFilterSelected
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.015,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black45,
                            ),
                          ),
                          child: Icon(
                            Icons.close,
                            size: MediaQuery.of(context).size.height * 0.013,
                            color: Colors.black45,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                    fontSize:
                        MediaQuery.of(context).size.width > 300 ? 12.0 : 8.0,
                  ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
