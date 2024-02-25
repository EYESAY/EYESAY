import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/module/card.dart';
import 'package:frontend/app/module/talkbox.dart';
import 'package:frontend/app/screens/detailsay.dart';
import 'package:frontend/app/screens/signup2.dart';
import 'package:frontend/app/screens/signup4.dart';
import '../module/emojicard.dart';
import '../../storyCardData.dart';

class OftenUseScreen extends StatefulWidget {
  @override
  State createState() => _OftenUseScreenState();
}

class _OftenUseScreenState extends State<OftenUseScreen> {
  final TextEditingController _controller = TextEditingController();
  // 현재 표시할 문자 리스트 관리하는 상태
  late List<List<String>> _currentList;
  List<Widget> talkBoxes = []; // TalkBox 위젯들을 저장할 리스트

  // 초기에 자음 리스트 표시
  @override
  void initState() {
    super.initState();
    _currentList = wordEmojiPairs;
  }

  //tracking on/off
  bool isOn = true;

  void _addTalkBox(String text) {
    setState(() {
      // TalkBox를 리스트에 추가하는 함수
      talkBoxes.add(TalkBox(text: text, isCardTalk: true));
    });
  }

  void _removeTalkBox(int index) {
    setState(() {
      talkBoxes.removeAt(index); // Remove the TalkBox at the given index
    });
  }

  // BaseStructureScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, designSize: Size(1600, 2560));

    // 선택된 문자를 입력 필드에 추가하는 함수
    void _onCardTap(String char) {
      setState(() {
        _controller.text += char; // 텍스트 필드가 비어 있는 경우, 입력된 문자를 직접 추가
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFFE8ECF2),
      body: SingleChildScrollView(
        //스크롤 가능하도록 추가
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // 첫 번째 위젯은 왼쪽 끝, 마지막 위젯은 오른쪽 끝에 배치
                children: [
                  //로고+이름
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo_blue.png',
                        width: 87.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '나비',
                                style: TextStyle(
                                  color: Color(0xFF262626),
                                  fontSize: 40.sp,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: ' 님 ',
                                style: TextStyle(
                                  color: Color(0xFF262626),
                                  fontSize: 40.sp,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  //아이트래킹
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('아이트래킹',
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontSize: 40.sp,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isOn = !isOn;
                          });
                        },
                        child: Container(
                          width: 90.w, // 버튼 전체 너비
                          height: 70.h, // 버튼 전체 높이
                          decoration: BoxDecoration(
                            color: isOn
                                ? Colors.blue
                                : Colors.grey[300], // ON일 때는 파란색, OFF일 때는 회색
                            borderRadius:
                                BorderRadius.circular(35.h), // 버튼의 둥근 모서리 반경
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              AnimatedAlign(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                                alignment: isOn
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 60.w, // 원의 너비
                                  height: 60.h, // 원의 높이
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), //설정
                      Image.asset(
                        'settings.png',
                        width: 150.w,
                        height: 150.h,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h), // 추가된 간격
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 1521.w,
                minHeight: 663.h,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                // TalkBox들을 포함할 Padding 추가
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.7, color: Color(0xFF1E50AC)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children: talkBoxes, // 이 부분에서 talkBoxes 리스트를 UI에 표시합니다.
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8.0, // 버튼 간의 간격s
                children: [
                  GestureDetector(
                    child: Container(
                        width: 493.w,
                        height: 330.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('yes.png',
                                  width: 100.w,
                                  height: 100.h), // 여기에 이미지 경로를 입력하세요.
                              SizedBox(width: 5), // 이미지와 텍스트 사이의 간격을 조정합니다.
                              Text(
                                '네',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 48.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  GestureDetector(
                    child: Container(
                        width: 493.w,
                        height: 330.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('no.png',
                                  width: 100.w,
                                  height: 100.h), // 여기에 이미지 경로를 입력하세요.
                              SizedBox(width: 5), // 이미지와 텍스트 사이의 간격을 조정합니다.
                              Text(
                                '아니요',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 48.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              DetailSayScreen(),
                          transitionsBuilder:
                              (context, animation1, animation2, child) {
                            return child;
                          },
                        ),
                      );
                    },
                    child: Container(
                        width: 493.w,
                        height: 330.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('closely.png',
                                  width: 100.w,
                                  height: 100.h), // 여기에 이미지 경로를 입력하세요.
                              SizedBox(width: 10), // 이미지와 텍스트 사이의 간격을 조정합니다.
                              Text(
                                '자세히\n말하기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 48.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
            //카드 모음
            Container(
                margin: EdgeInsets.all(12),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 1,
                  ),
                  itemCount: _currentList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {
                        _addTalkBox(_currentList[index][0]),
                      },
                      child: EmojiCard(emojiData: _currentList[index]),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}

final List<String> cards = [];

final List<List<String>> wordEmojiPairs = [
  ['안녕하세요', '👋'],
  ['주세요', '🙏'],
  ['좋아요', '👍'],
  ['싫어요', '👎'],
  ['화장실 가고 싶어요', '🚽'],
  ['목이 말라요', '💦'],
  ['같이 가자', '👫'],
  ['전화기', '📞'],
  ['아파요', '😷'],
  ['먹어요', '🍽️'],
  ['그만할래요', '✋'],
  ['배고파요', '🍔'],
  ['재밌어요', '😄']
];


//안녕하세요, 주세요 ,좋아요, 싫어요, 화장실 가고 싶어요, 목이 말라요, 같이 가자, 전화기, 아파요 ,먹어요 ,그만할래요,배고파요,재밌어요