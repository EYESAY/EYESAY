import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/module/talkbox.dart';
import 'package:frontend/app/screens/oftenuse.dart';
import '../module/emojicard.dart';
import '../../storyCardData.dart';

class DetailSayScreen extends StatefulWidget {
  @override
  _DetailSayScreenState createState() => _DetailSayScreenState();
}

class _DetailSayScreenState extends State<DetailSayScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // 현재 표시할 문자 리스트 관리하는 상태
  late List<List<String>> _currentList = groupTitleSets;
  List<Widget> talkBoxes = []; // TalkBox 위젯들을 저장할 리스트
  bool isGroupTitleSets = true; // isGroupName 변수 추가
  late String _currentGroupName = '';
  late bool isTextField = false;
  late bool isYesorNo = false;

  // 초기에 자음 리스트 표시
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ScrollController를 위젯이 사라질 때 dispose
    _textEditingController.dispose();
    super.dispose();
  }

  //tracking on/off
  bool isOn = true;

  void _addTalkBox(String text) {
    if (!isGroupTitleSets || isTextField == true || isYesorNo == true) {
      //'직접 입력하기' 버튼을 눌러야만 isTextField가 true다.
      setState(() {
        // TalkBox를 리스트에 추가하는 함수
        if (isTextField == true) {
          talkBoxes.add(TalkBox(text: text, isCardTalk: false));
          _textEditingController.clear(); // TalkBox 추가 후 텍스트 필드를 비웁니다.
        } else {
          //카드거나, 네아니요일 경우
          talkBoxes.add(TalkBox(text: text, isCardTalk: true));
        }
      });
    }
    // 새 요소가 추가되고 나서 스크롤을 맨 아래로 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    isYesorNo = false;
    isTextField = false;
  }

  void _changeGroup(String groupName) {
    setState(() {
      // groupName에 따라 _currentList 변경
      switch (groupName) {
        case 'helloGroup':
          _currentList = helloGroup;
          _currentGroupName = groupTitleSets[0][0];
          break;
        case 'questionAnswerGroup':
          _currentList = questionAnswerGroup;
          _currentGroupName = groupTitleSets[1][0];
          break;
        case 'mealEatGroup':
          _currentList = mealEatGroup;
          _currentGroupName = groupTitleSets[2][0];
          break;
        case 'restroomGroup':
          _currentList = restroomGroup;
          _currentGroupName = groupTitleSets[3][0];
          break;
        case 'friendsConversationGroup':
          _currentList = friendsConversationGroup;
          _currentGroupName = groupTitleSets[4][0];
          break;
        case 'hospitalSymptomsGroup':
          _currentList = hospitalSymptomsGroup;
          _currentGroupName = groupTitleSets[5][0];
          break;
        case 'familyPeopleGroup':
          _currentList = familyPeopleGroup;
          _currentGroupName = groupTitleSets[6][0];
          break;
        case 'emergencyGroup':
          _currentList = emergencyGroup;
          _currentGroupName = groupTitleSets[7][0];
          break;
        default:
          _currentList = [];
      }
      isGroupTitleSets = false; // 그룹 이름 클릭 후 isGroupTitleSets true로 설정
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
            Container(
              width: 1521.w,
              height: 804.h, // Container의 높이 고정
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.7, color: Color(0xFF1E50AC)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, //자식들을 상하로 분산 배치
                children: [
                  Expanded(
                    child: Container(
                      height: 616.h,
                      width: 1473.w,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: talkBoxes.map((talkBox) {
                                return GestureDetector(
                                  onTap: () => setState(() {
                                    talkBoxes.remove(talkBox);
                                  }),
                                  child: talkBox,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                          width: 1473.w,
                          child: Divider(
                            height: 40.h,
                            thickness: 0.7,
                            color: Color(0xFF1E50AC),
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 1000.w,
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.h),
                              child: Container(
                                width: 1050.w,
                                height: 150.h,
                                child: TextField(
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.all(8.0), // 텍스트 필드 내부의 패딩 설정
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      // 텍스트 필드의 테두리 설정
                                      borderSide: BorderSide.none, // 테두리 제거
                                      borderRadius: BorderRadius.circular(
                                          10), // 모서리 둥글게 설정
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // '직접 입력하기' 버튼 클릭 시 작동할 로직
                              if (_textEditingController.text.isNotEmpty) {
                                isTextField = true;
                                _addTalkBox(_textEditingController.text);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(30.w, 0, 0, 20.h),
                              child: Container(
                                width: 468.w,
                                height: 150.h,
                                alignment: Alignment.center,
                                child: Text(
                                  '직접 입력하기',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFFBFCFD),
                                    fontSize: 40.sp,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w800,
                                    height: 0,
                                  ),
                                ),
                                decoration: ShapeDecoration(
                                  color: Color(0xFF1E50AC),
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
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8.0, // 버튼 간의 간격s
                children: !isGroupTitleSets
                    ? [
                        Container(
                          width: 1520.w,
                          height: 330.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _currentList = groupTitleSets;
                                          isGroupTitleSets = true;
                                        });
                                      },
                                      child: Image.asset('backIcon.png',
                                          width: 43.w)),
                                ),
                                Expanded(
                                  child: Text(
                                    _currentGroupName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 48.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]
                    : [
                        GestureDetector(
                          onTap: () {
                            isYesorNo = true;
                            _addTalkBox('네');
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
                                    Image.asset('yes.png',
                                        width: 100.w,
                                        height: 100.h), // 여기에 이미지 경로를 입력하세요.
                                    SizedBox(
                                        width: 5), // 이미지와 텍스트 사이의 간격을 조정합니다.
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
                          onTap: () {
                            isYesorNo = true;
                            _addTalkBox('아니요');
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
                                    Image.asset('no.png',
                                        width: 100.w,
                                        height: 100.h), // 여기에 이미지 경로를 입력하세요.
                                    SizedBox(
                                        width: 5), // 이미지와 텍스트 사이의 간격을 조정합니다.
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
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        OftenUseScreen(),
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
                                    SizedBox(
                                        width: 10), // 이미지와 텍스트 사이의 간격을 조정합니다.
                                    Text(
                                      '간단히\n말하기',
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
                      onTap: () {
                        if (_currentList[index].length > 2 &&
                            isGroupTitleSets) {
                          _changeGroup(_currentList[index][2]);
                        } else {
                          isTextField = false;
                          _addTalkBox(_currentList[index][0]);
                        }
                      },
                      child: EmojiCard(
                          emojiData: _currentList[index],
                          isGroupCard: isGroupTitleSets),
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
