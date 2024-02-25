import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/screens/signup1.dart';

class Intro2Screen extends StatefulWidget {
  @override
  _Intro2ScreenState createState() => _Intro2ScreenState();
}

class _Intro2ScreenState extends State<Intro2Screen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  num textPageNum = 1;

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
    if (textPageNum == 1) {
      return [
        boldText('아이트래킹 설정'),
        normalText('이 완료되었어요!'),
      ];
    } else if (textPageNum == 2) {
      return [
        normalText('이제부터는 '),
        boldText('누르고 싶은 버튼에 시선'),
        normalText('을 두고,\n'),
        boldText('눈을 두 번 깜빡'),
        normalText('이면'),
        boldText('터치'),
        normalText('가 돼요!'),
      ];
    } else if (textPageNum == 3) {
      return [
        normalText('걱정 마세요, '),
        boldText('시선을 따라 루키가 따라오니까요!'),
      ];
    } else if (textPageNum == 4) {
      return [
        normalText('우리 한 번,\n'),
        boldText('같이 연습'),
        normalText('해볼까요?'),
      ];
    } else {
      return [];
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
              MaterialPageRoute(builder: (context) => Signup1Screen()),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                  child: Image.asset('logo_blue_big.png', width: 350.w),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
