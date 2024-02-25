import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmojiCard extends StatelessWidget {
  final List<String> emojiData; // 이중리스트 대신 List<String>을 사용하여 각 이모지와 텍스트를 받습니다.
  final bool isGroupCard;

  const EmojiCard({Key? key, required this.emojiData, this.isGroupCard = false})
      : super(key: key); // 두 개의 데이터를 가지고 있는지 확인합니다.

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
      child: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 내용을 수직으로 중앙 정렬합니다.
            children: [
              Text(
                emojiData[0], // 첫 번째 데이터를 첫 번째 텍스트에 표시합니다.
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF262626),
                  fontSize: 48.sp, // 수정: 이모지와 텍스트의 크기를 조절할 수 있습니다.
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                emojiData[1], // 두 번째 데이터를 두 번째 텍스트에 표시합니다.
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF262626),
                  fontSize: 128.sp, // 수정: 이모지와 텍스트의 크기를 조절할 수 있습니다.
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        if (isGroupCard)
          Positioned(
              right: 45.w,
              top: 45.h,
              child: Image.asset(
                'groupMarkImg.png',
                width: 57.3.w,
              ))
      ]),
    );
  }
}
