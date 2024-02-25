import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/screens/signup2.dart';
import '../module/card.dart';

class Signup1Screen extends StatefulWidget {
  @override
  _Signup1ScreenState createState() => _Signup1ScreenState();
}

class _Signup1ScreenState extends State<Signup1Screen> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  // 현재 표시할 문자 리스트 관리하는 상태
  late List<String> _currentList;
  bool _showKeyboard = false;

  // 초기에 자음 리스트 표시
  @override
  void initState() {
    super.initState();
    _currentList = characters;
  }

  // 선택된 문자를 입력 필드에 추가하는 함수
  void _onCardTap(String char) {
    setState(() {
      final int choIndex = choSung.indexOf(char);
      final int jungIndex = jungSung.indexOf(char);
      final int jongIndex = jongSung.indexOf(char);

      // 입력된 문자가 초성, 중성, 종성 중 어디에 해당하는지 판단
      if (_controller.text.isNotEmpty) {
        // 마지막 문자를 기준으로 초성, 중성, 종성 분리
        int lastChar = _controller.text.codeUnitAt(_controller.text.length - 1);
        if (lastChar >= 0xAC00 && lastChar <= 0xD7A3) {
          int lastCho = (lastChar - 0xAC00) ~/ (21 * 28);
          int lastJung = ((lastChar - 0xAC00) % (21 * 28)) ~/ 28;
          int lastJong = (lastChar - 0xAC00) % 28;

          if (jungIndex != -1 && lastJong == 0) {
            // 중성이 입력되었고, 종성이 없는 경우
            // 현재 문자에 중성을 추가하여 새 문자 생성
            int newChar = 0xAC00 + (lastCho * 21 + jungIndex) * 28;
            _controller.text =
                _controller.text.substring(0, _controller.text.length - 1) +
                    String.fromCharCode(newChar);
          } else if (jongIndex != -1 &&
              (lastJong == 0 || jongSung.contains(char))) {
            // 종성이 입력되었거나 기존에 종성이 있는 경우
            if (lastJong == 0) {
              // 기존 문자에 종성이 없는 경우
              int newChar = lastChar + jongIndex;
              _controller.text =
                  _controller.text.substring(0, _controller.text.length - 1) +
                      String.fromCharCode(newChar);
            } else if (jongSung.contains(char)) {
              // 종성이 이미 있고, 추가 종성 입력
              // 복잡한 종성 로직 처리 (예: 'ㄱ'+'ㅅ' = 'ㄳ')
              // 이 부분은 추가적인 종성 조합 로직을 필요로 합니다. 여기서는 단순화를 위해 생략합니다.
            }
          } else {
            _controller.text += char; // 그 외의 경우, 문자를 직접 추가
          }
        } else {
          _controller.text += char; // 한글 범위 밖의 문자인 경우 직접 추가
        }
      } else {
        _controller.text += char; // 텍스트 필드가 비어 있는 경우, 입력된 문자를 직접 추가
      }
    });
  }

  void _toggleList(bool isConsonant) {
    setState(() {
      _currentList = isConsonant ? characters : vowels;
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
                              child: Text('이름을 입력해주세요!',
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
                                              Signup2Screen()), // Signup2Screen으로 이동
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
            Wrap(
              direction: Axis.horizontal,
              spacing: 8.0, // 버튼 간의 간격
              children: [
                GestureDetector(
                  onTap: () => _toggleList(true),
                  child: Container(
                      width: 493.w,
                      height: 300.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'ㄱ,ㄴ,ㄷ,...\n자음',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () => _toggleList(false),
                  child: Container(
                    width: 493.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('ㅏ,ㅑ,ㅓ...\n모음',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 48.sp, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showKeyboard = !_showKeyboard; // 키보드 상태를 토글합니다.
                      if (_showKeyboard) {
                        FocusScope.of(context)
                            .requestFocus(_focusNode); // 키보드를 보여줍니다.
                      } else {
                        _focusNode.unfocus(); // 키보드를 숨깁니다.
                      }
                    });
                  },
                  child: Container(
                    width: 493.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        _showKeyboard ? '키보드 숨기기' : '기존 키보드 쓰기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

final List<String> characters = [
  'ㄱ',
  'ㄲ',
  'ㄴ',
  'ㄷ',
  'ㄸ',
  'ㄹ',
  'ㅁ',
  'ㅂ',
  'ㅃ',
  'ㅅ',
  'ㅆ',
  'ㅇ',
  'ㅈ',
  'ㅉ',
  'ㅊ',
  'ㅋ',
  'ㅌ',
  'ㅍ',
  'ㅎ'
];
final List<String> vowels = [
  'ㅏ',
  'ㅑ',
  'ㅓ',
  'ㅕ',
  'ㅗ',
  'ㅛ',
  'ㅜ',
  'ㅠ',
  'ㅡ',
  'ㅣ',
  'ㅐ',
  'ㅒ',
  'ㅔ',
  'ㅖ',
  'ㅘ',
  'ㅙ',
  'ㅚ',
  'ㅝ',
  'ㅞ',
  'ㅟ',
  'ㅢ',
];

// 초성 리스트
final List<String> choSung = [
  'ㄱ',
  'ㄲ',
  'ㄴ',
  'ㄷ',
  'ㄸ',
  'ㄹ',
  'ㅁ',
  'ㅂ',
  'ㅃ',
  'ㅅ',
  'ㅆ',
  'ㅇ',
  'ㅈ',
  'ㅉ',
  'ㅊ',
  'ㅋ',
  'ㅌ',
  'ㅍ',
  'ㅎ'
];

// 중성 리스트
final List<String> jungSung = [
  'ㅏ',
  'ㅐ',
  'ㅑ',
  'ㅒ',
  'ㅓ',
  'ㅔ',
  'ㅕ',
  'ㅖ',
  'ㅗ',
  'ㅘ',
  'ㅙ',
  'ㅚ',
  'ㅛ',
  'ㅜ',
  'ㅝ',
  'ㅞ',
  'ㅟ',
  'ㅠ',
  'ㅡ',
  'ㅢ',
  'ㅣ'
];

// 종성 리스트 (종성이 없는 경우 포함)
final List<String> jongSung = [
  '',
  'ㄱ',
  'ㄲ',
  'ㄳ',
  'ㄴ',
  'ㄵ',
  'ㄶ',
  'ㄷ',
  'ㄹ',
  'ㄺ',
  'ㄻ',
  'ㄼ',
  'ㄽ',
  'ㄾ',
  'ㄿ',
  'ㅀ',
  'ㅁ',
  'ㅂ',
  'ㅄ',
  'ㅅ',
  'ㅆ',
  'ㅇ',
  'ㅈ',
  'ㅊ',
  'ㅋ',
  'ㅌ',
  'ㅍ',
  'ㅎ'
];
