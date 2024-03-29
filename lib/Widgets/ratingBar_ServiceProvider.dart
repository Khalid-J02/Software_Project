import 'package:flutter/material.dart';

class RatingBarSB extends StatelessWidget {
  final double rating ;
  final double size ;

  RatingBarSB(
      {
        super.key,
        required this.rating,
        required this.size,
      }
      );

  @override
  Widget build(BuildContext context) {

    List<Widget> _starList = [] ;

    int realNumber = rating.floor() ;
    int partNumber = ((rating - realNumber) * 10).ceil() ;
    
    for(int i = 0 ; i < 5 ; i++){
      if(i < realNumber) {
        _starList.add(Icon(Icons.star, color: Color(0xFFF3D69B), size: size,)) ;
      }else if (i == realNumber){
        _starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            // fit: StackFit.expand,
            children: [
              Icon(Icons.star , color: Color(0xFFF3D69B), size: size,),
              ClipRect(
                clipper: _Clipper(part: partNumber),
                child: Icon(Icons.star, color: Colors.grey, size: size,),
              )
            ],
          ),
        ));
      }else{
        _starList.add(Icon(Icons.star, color: Colors.grey,size: size,)) ;
      }
    }
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect>{
  final int part ;
  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
        (size.width / 10) * part,
        0.0,
        size.width,
        size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true ;
  
}
