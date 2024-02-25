import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/screens/Intro1.dart';
import 'package:frontend/app/screens/oftenuse.dart';

class Signup4Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8ECF2), // 배경색 설정
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OftenUseScreen()),
          );
        },
        child: Center(
          // Center 위젯을 사용하여 모든 요소를 화면 중앙으로 배치
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 세로축 가운데 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 가로축 가운데 정렬
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 40.sp), // 전체 기본 글씨 크기 설정
                  children: <TextSpan>[
                    TextSpan(
                        text: '모든 절차가 끝',
                        style:
                            TextStyle(fontWeight: FontWeight.bold)), // Bold체 적용
                    TextSpan(text: '났어요!\n앞으로는 '),
                    TextSpan(
                        text: 'EYESAY',
                        style:
                            TextStyle(fontWeight: FontWeight.bold)), // Bold체 적용
                    TextSpan(text: '와 함께, '),
                    TextSpan(
                        text: 'I SAY',
                        style:
                            TextStyle(fontWeight: FontWeight.bold)), // Bold체 적용
                  ],
                ),
                textAlign: TextAlign.center, // 텍스트 가운데 정렬
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 100.h, 0, 0),
                child: Image.asset('logo_blue_big.png', width: 350.w),
              ), // 이미지 추가
            ],
          ),
        ),
      ),
    );
  }
}
