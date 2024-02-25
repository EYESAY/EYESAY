import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/screens/signup3.dart';
import '../module/card.dart';

class Signup2Screen extends StatefulWidget {
  @override
  _Signup2ScreenState createState() => _Signup2ScreenState();
}

class _Signup2ScreenState extends State<Signup2Screen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  // 현재 표시할 문자 리스트 관리하는 상태
  late List<String> _currentList;
  bool _showKeyboard = false;

  // 초기에 자음 리스트 표시
  @override
  void initState() {
    super.initState();
    _currentList = numbers;
  }

  // 선택된 문자를 입력 필드에 추가하는 함수
  void _onCardTap(String char) {
    setState(() {
      _controller.text += char; // 텍스트 필드가 비어 있는 경우, 입력된 문자를 직접 추가
    });
  }

  void _toggleKeyboard() {
    setState(() {
      _showKeyboard = !_showKeyboard;
      if (_showKeyboard) {
        FocusScope.of(context).requestFocus(_focusNode);
      } else {
        _focusNode.unfocus();
      }
    });
  }

  // BaseStructureScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(1600, 2560));

    return Scaffold(
      backgroundColor: Color(0xFFE8ECF2),
      body: SingleChildScrollView(
        //스크롤 가능하도록 추가
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Flexible(
                      child: GestureDetector(
                        onTap: () {
                          //이미지 탭할 시 뒤로 가기
                          Navigator.pop(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/logo_blue.png',
                              width: 87.w,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 25, 0, 13),
                              child: Text('나이를 입력해주세요!',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF262626),
                                    fontSize: 48.sp,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w800,
                                    height: 0,
                                  )),
                            ),
                            TextField(
                              controller: _controller,
                              focusNode: _focusNode,
                              readOnly: _showKeyboard
                                  ? false
                                  : true, // 키보드 상태에 따라 readOnly를 변경합니다.
                              enableInteractiveSelection: _showKeyboard
                                  ? true
                                  : false, // 키보드 상태에 따라 enableInteractiveSelection을 변경합니다.
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: '이곳에 입력해주세요',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xFF1F50AC)), // 테두리 색상을 #1F50AC로 변경
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xFF1F50AC)), // 포커스 받았을 때의 테두리 색상을 #1F50AC로 변경
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 380.h, horizontal: 95.h),
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 2),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                    child: Flexible(
                        child: Column(
                          children: [
                            Container(
                              child: Center(
                                child: Text('아이트래킹\n재설정하기',
                                    style: TextStyle(
                                      fontSize: 48.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    textAlign: TextAlign.center),
                              ),
                              width: 493.w,
                              height: 300.h,
                              margin: EdgeInsets.all(10.w),
                              padding: EdgeInsets.all(10.w),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                            ),
                            // '다음으로' 컨테이너를 GestureDetector로 감싸서 onTap 메서드를 구현
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 9, 0, 9),
                              child: GestureDetector(
                                  onTap: () {
                                    // Navigator를 사용하여 Signup2Screen 페이지로 이동
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Signup3Screen()), // Signup2Screen으로 이동
                                    );
                                  },
                                  child: Container(
                                    width: 493.w,
                                    height: 430.h,
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            100.w), // 텍스트와 아이콘 사이 간격 조정을 위한 패딩
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFF1F50AC),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center, // 중앙 정렬
                                      children: <Widget>[
                                        Text(
                                          '다음으로',
                                          style: TextStyle(
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                            width: 24.w), // 텍스트와 아이콘 사이의 간격
                                        Image.asset(
                                          'arrow.png', // 이미지 파일 경로
                                          width: 80.w, // 이미지 크기 조절
                                          color: Colors.white, // 이미지 색상
                                        ),
                                      ],
                                    ),
                                  )),
                            ),

                            GestureDetector(
                              onTap: () {
                                if (_controller.text.length > 0) {
                                  _controller.text = _controller.text.substring(
                                      0, _controller.text.length - 1);
                                }
                              },
                              child: Container(
                                child: Text('지우기',
                                    style: TextStyle(
                                        fontSize: 48.sp,
                                        fontWeight: FontWeight.w800,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1)),
                                    textAlign: TextAlign.center),
                                width: 493.w,
                                height: 350.h,
                                margin: EdgeInsets.all(10.w),
                                padding: EdgeInsets.all(10.w),
                                alignment: Alignment.center,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF90919F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                              ),
                            ),
                          ],
                        ),
                        flex: 1),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h), // 추가된 간격

            Container(
              margin: EdgeInsets.all(12),
              child: GridView.builder(
                shrinkWrap: true, // GridView가 Column 내부에서 사용될 때 필요
                physics: NeverScrollableScrollPhysics(), // GridView 내부 스크롤 비활성화
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 1,
                ),
                itemCount: _currentList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onCardTap(_currentList[index]),
                    child: CustomCard(character: _currentList[index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

final List<String> numbers = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0',
];
