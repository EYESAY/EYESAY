import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String character;

  const CustomCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      width: 485.w,
      height: 470.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        // `Center` 위젯을 사용하여 텍스트를 중앙에 위치시킵니다.
        child: Text(
          character,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF262626),
            fontSize: 128.sp, // 수정된 부분: `fontSize`를 ScreenUtil을 사용하여 조정
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
