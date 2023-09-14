import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconBotton extends StatelessWidget {
  final String label;
  final String color;
  final Function filter;
  final bool isSelected;
  final GestureTapCallback? onTap;
  final String? iconPath;

  CustomIconBotton({
    required this.label,
    required this.color,
    required this.filter,
    this.isSelected = false,
    this.onTap,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.black,
      child: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Card(
                elevation: 10,
                shape: const CircleBorder(),
                color: isSelected ? Colors.green : Colors.transparent,
                child: CustomPaint(
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
                            child: iconPath == null
                                ? SizedBox()
                                : SvgPicture.network(
                                    iconPath!,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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

class _MyPainter extends CustomPainter {
  _MyPainter();

  @override
  //circulos blancos en el carrusel
  void paint(Canvas canvas, Size size) {
    //var color = Colors.white10;

    //var paint = Paint()..color = color;

    //canvas.drawCircle(Offset(20, 20), 30, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
