// import 'package:flutter/material.dart';
// import 'package:world_cup/utility/size_config.dart';

// class ArcPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawCircle(
//       Offset(getPercentScreenWidth(50), getPercentScreenHeight(50)),
//       getPercentScreenWidth(35),
//       circlePaint,
//     );
//     canvas.drawArc(Rect.fromCenter(center: center, width: width, height: height), startAngle, sweepAngle, useCenter, paint)
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }

//   Paint get circlePaint {
//     return Paint()
//       ..color = Colors.red
//       ..strokeWidth = 3;
//   }

//   Paint get archPaint{
//     return Paint()..color= Colors.green;
//   }
// }
