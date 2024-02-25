import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TalkBox extends StatelessWidget {
  final String text;
  final bool isCardTalk; // Add this line

  const TalkBox({
    Key? key,
    required this.text,
    this.isCardTalk = false,
  }) : super(key: key); // Change here

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: 150.h,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: isCardTalk ? Color(0xFF1E50AC) : Colors.white, // Change here
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: isCardTalk
                  ? BorderSide(
                      width: 0, color: Color.fromARGB(255, 255, 255, 255))
                  : BorderSide(width: 5.w, color: Color(0xFF1E50AC))),
          shadows: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 8,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isCardTalk
                    ? Color(0xFFF4F4F4)
                    : Colors.black, // Change here
                fontSize: 48.sp,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
