import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/screens/focus.dart';

class Intro1Screen extends StatefulWidget {
  @override
  _Intro1ScreenState createState() => _Intro1ScreenState();
}

class _Intro1ScreenState extends State<Intro1Screen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  num textPageNum = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    final Animation<double> curve = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );

    _animation = Tween<double>(begin: 0, end: 20).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  TextSpan boldText(String text) =>
      TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.bold));

  TextSpan normalText(String text) => TextSpan(text: text);

  List<TextSpan> getText() {
    if (textPageNum == 3) {
      return [
        boldText('EYESAY'),
        normalText('는 '),
        boldText('시선'),
        normalText('과 '),
        boldText('깜빡임'),
        normalText('으로\n'),
        boldText('말'),
        normalText('을 할 수 있도록 도와주는 서비스에요!'),
      ];
    } else if (textPageNum == 4) {
      return [
        normalText('이제부터 '),
        boldText('아이트래킹 설정'),
        normalText('을 시작할 거에요!\n'),
        boldText('준비 되셨다면 눈을 두 번 깜빡여 주세요!'),
      ];
    } else {
      return []; // 기본값 또는 오류 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8ECF2),
      body: GestureDetector(
        onTap: () {
          setState(() {
            textPageNum += 1;
          });

          if (textPageNum == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FocusScreen()),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (textPageNum == 1)
                Container(
                    width: 493.w,
                    height: 474.h,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFBFCFD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '안녕하세요',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontSize: 48.sp,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w800,
                            height: 0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Text(
                            '👋',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF262626),
                              fontSize: 100.sp,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w800,
                              height: 0,
                            ),
                          ),
                        )
                      ],
                    ))
              else if (textPageNum == 2)
                Container(
                    width: 493.w,
                    height: 474.h,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFBFCFD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "저는 '루키'에요!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontSize: 48.sp,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w800,
                            height: 0,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Image.asset('cursor.png', width: 128.w))
                      ],
                    ))
              else if (textPageNum == 3 || textPageNum == 4)
                Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 40.sp),
                    children: getText(), // 조건에 따라 다른 텍스트를 반환
                  ),
                  textAlign: TextAlign.center,
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 100.h, 0, 0),
                child: Transform.translate(
                  offset: Offset(0, _animation!.value),
                  child: Image.asset('assets/logo_blue_big.png', width: 350.w),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
