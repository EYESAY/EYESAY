import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/screens/Intro2.dart';

class FocusScreen extends StatefulWidget {
  @override
  _FocusScreenState createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Timer? _timer;
  Random _random = Random();
  double _top = 0;
  double _left = 0;
  final int _imageSize = 50; // 이미지 크기

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Intro2Screen()),
      );
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        double maxWidth = MediaQuery.of(context).size.width - _imageSize;
        double maxHeight = MediaQuery.of(context).size.height - _imageSize;

        switch (_random.nextInt(4)) {
          case 0: // 상
            _top = 0;
            _left = _random.nextDouble() * maxWidth;
            break;
          case 1: // 하
            _top = maxHeight;
            _left = _random.nextDouble() * maxWidth;
            break;
          case 2: // 좌
            _left = 0;
            _top = _random.nextDouble() * maxHeight;
            break;
          case 3: // 우
            _left = maxWidth;
            _top = _random.nextDouble() * maxHeight;
            break;
        }
      });
      _animationController!
          .forward()
          .then((value) => _animationController!.reverse());
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8ECF2),
      body: GestureDetector(
        onTap: () {
          _startAnimation();
        },
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 100.h, 0, 0),
                child: Center(
                  child: Container(
                    width: 493.w,
                    height: 474.h,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFBFCFD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      '화면에 나타나는\n루키를 봐주세요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF262626),
                        fontSize: 35.sp,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: _top,
              left: _left,
              child: AnimatedBuilder(
                animation: _animationController!,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animationController!.value,
                    child: Image.asset('assets/logo_blue_big.png',
                        width: _imageSize.toDouble(),
                        height: _imageSize.toDouble()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
