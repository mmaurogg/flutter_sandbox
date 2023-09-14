import 'package:flavoring_flavorizr/data/data.dart';
import 'package:flavoring_flavorizr/ui/widgets/liquit_circle.dart';
import 'package:flavoring_flavorizr/ui/widgets/utilities/dash_line_painter.dart';
import 'package:flutter/material.dart';

class CustomPath extends StatelessWidget {
  const CustomPath({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomPaint(
        painter: DashLinePainter(),
        child: GridView.builder(
          itemCount: 6,
          reverse: true,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: 2),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: (index % 2 == 0)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                LiquitCircle(
                  isOpen: true,
                  drinkData: DataSheet().drinks[index],
                  onTap: (_) {},
                )
                /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
                          color:
                              (index == 0) ? Colors.green : Colors.amberAccent,
                          borderRadius: BorderRadius.circular(55),
                        ),
                        child: Center(
                          child: Text(DataSheet().levels[index],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ),
                ), */
              ],
            );
          },
        ),
      ),
    );
  }
}
