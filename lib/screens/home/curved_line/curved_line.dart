import 'package:flutter/material.dart';


class CurvedLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint() 
..color = const Color(0xFF4298B5)
..style = PaintingStyle.stroke
..strokeWidth = 5.0
..strokeCap  = StrokeCap.round
..strokeJoin = StrokeJoin.bevel
    ;

    final path = Path();
    // x1, y1 : start points
    // x2, y2 : final points
    const x1 = 0.0;
    final x2 = size.width * 0.5 ;
    final x3 = size.width ;
    
    final y1 = size.height * 0.596;
    final y2 = size.height * 0.7;
    final y3 = size.height * 0.8;
    //! future me
    // for the curves 
    // check this medium article
    // b stand for black hole 
    // hope i understand what does it mean b here 
    
    // https://ashnizaster.medium.com/make-your-own-custom-shapes-and-designs-using-custompaint-in-c8f97577f5e4
   // uncomment draw circles to see x1b and y1b
    // canvas.drawCircle(  Offset(x1b, y1b), 5, paint);
    final y1b = size.height * 0.45;
    final x1b = size.width / 4;
    final y2b = size.height * 0.9;
    final x2b = size.width * 0.75;

   path.moveTo(x1, y1);
   path.quadraticBezierTo(x1b, y1b, x2, y2 );
  //  path.moveTo(x2, y2);

   path.quadraticBezierTo(x2b, y2b, x3, y3 );


   canvas.drawPath(path, paint);
  
    
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}