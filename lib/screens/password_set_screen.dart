import 'package:artinus_mission/components/figure/circle_box.dart';
import 'package:artinus_mission/components/figure/square_box.dart';
import 'package:artinus_mission/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'dart:math';
import '../components/alarm_dialog.dart';
import '../components/custom_keyboard.dart';

class PassWordSetScreen extends StatefulWidget {
  const PassWordSetScreen({super.key});

  @override
  State<PassWordSetScreen> createState() => _PassWordSetScreenState();
}

enum InfoType { info, checkInfo, incorrectInfo }

class _PassWordSetScreenState extends State<PassWordSetScreen> {
  final String infoText = "비밀번호 6자리를 입력해주세요.";
  final String checkInfoText = "비밀번호를 한번 더 입력해주세요.";
  final String incorrectInfoText = "비밀번호가 일치하지 않습니다.";
  final String alarmContentText = "동일한 숫자를 연속해서 3자리 이상 설정할 수 없습니다.";

  InfoType nowState = InfoType.info;

  String setPassword = "";
  String checkPassword = "";
  final List figureData = [
    ["", false],
    ["", false],
    ["", false],
    ["", false],
    ["", false],
    ["", false],
  ];

  List<List<dynamic>> keys = [];
  var topKeys = <String>{};
  final List bottomKeys = [
    ['전체삭제', '', const Icon(Icons.arrow_back, color: Colors.white)]
  ];

  @override
  void initState() {
    _renderKeyBoard();
    super.initState();
  }

  _renderKeyBoard() {
    var rng = Random();

    //랜덤 숫자 생성, topKeys 생성 (9개 키패드)
    while (topKeys.length < 9) {
      topKeys.add(rng.nextInt(10).toString());
    }

    //bottomKeys 생성 (하단 가운데 나머지 1개 키패드)
    List setBottomItem = topKeys.toList();
    setBottomItem.sort();

    for (int i = 0; i < 9; i++) {
      if (i.toString() != setBottomItem[i]) {
        bottomKeys[0][1] = i.toString();
        break;
      }
    }

    //키보드 세팅을 위한 topKeys를 2차원 리스트로 변환
    var topKeys2dList = [];
    List topKeysList = topKeys.toList();

    int itemCount = 3;
    for (int i = 0; i < topKeysList.length; i += itemCount) {
      topKeys2dList.add(topKeysList.sublist(
          i,
          i + itemCount > topKeysList.length
              ? topKeysList.length
              : i + itemCount));
    }

    keys = [...topKeys2dList, ...bottomKeys];
  }

  onKeyTap(val) {
    setState(() {
      switch (nowState) {
        case InfoType.incorrectInfo:
          //비교한 비밀번호가 다를 때
          {
            nowState = InfoType.checkInfo;
            checkPassword = addPassword(checkPassword, val);
            figureDataState(true, checkPassword);
          }
          break;

        case InfoType.info:
          {
            //초기 비밀번호 설정
            if (setPassword.length <= 5) {
              setPassword = addPassword(setPassword, val);
              figureDataState(true, setPassword);
              checkConsecutiveNumber(setPassword, val, context);
            } else {
              nowState = InfoType.checkInfo;
            }
          }
          break;

        case InfoType.checkInfo:
          {
            //비밀번호 확인하기
            if (checkPassword.length <= 5) {
              checkPassword = addPassword(checkPassword, val);
              figureDataState(true, checkPassword);
              if (checkPassword.length == 6) {
                if (setPassword.compareTo(checkPassword) == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ResultScreen(passwordResult: setPassword)));
                } else {
                  nowState = InfoType.incorrectInfo;
                  checkPassword = initialPassword();
                  figureDataClear();
                }
              }
            }
          }
          break;
      }
    });
  }

//연속 3자리 중복 체크
  checkConsecutiveNumber(
    String setPassword,
    String nowValue,
    BuildContext context,
  ) {
    int count = 0;

    for (int i = 0; i < setPassword.length; i++) {
      if (setPassword.isNotEmpty) {
        String prevSetPassword = setPassword[i];

        if (nowValue == prevSetPassword) {
          count++;
        } else {
          count = 0;
        }
      }
    }

    if (count > 2) {
      //dialog
      alarmDialog(
        context,
        alarmContentText,
        () {
          setState(() {
            this.setPassword = initialPassword();
            figureDataClear();
            count = 0;
          });
          Navigator.pop(context);
        },
      );
    } else {
      if (setPassword.length == 6 && checkPassword.isEmpty) {
        nowState = InfoType.checkInfo;
        figureDataClear();
      }
    }
  }

//뒤로가기 버튼
  onBackspacePress() {
    setState(() {
      if (nowState == InfoType.info && setPassword.isNotEmpty) {
        setPassword = setPassword.substring(0, setPassword.length - 1);
        figureDataState(false, setPassword);
      } else if (nowState == InfoType.checkInfo && checkPassword.isNotEmpty) {
        checkPassword = checkPassword.substring(0, checkPassword.length - 1);
        figureDataState(false, checkPassword);
      }
    });
  }

//전체삭제 버튼
  onAllClearPress() {
    setState(() {
      if (nowState == InfoType.info) {
        setPassword = initialPassword();
        figureDataClear();
      } else if (nowState == InfoType.checkInfo) {
        checkPassword = initialPassword();
        figureDataClear();
      }
    });
  }

  String initialPassword() {
    return "";
  }

  String addPassword(String passwordType, String value) => passwordType + value;

  figureDataState(bool state, String passwordType) {
    if (state == false) {
      figureData[passwordType.length][1] = state;
    } else {
      figureData[passwordType.length - 1][1] = state;
    }
  }

  figureDataClear() => figureData
      .asMap()
      .forEach((index, value) => figureData[index][1] = false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _infoText(),
            _passwordFigure(figureData, nowState),
            _customKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget _infoText() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        nowState == InfoType.info
            ? infoText
            : nowState == InfoType.checkInfo
                ? checkInfoText
                : incorrectInfoText,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget _customKeyboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: keys
          .map((x) => Row(
                children: x.map((y) {
                  return Expanded(
                    child: CustomKeyboard(
                      label: y,
                      value: y,
                      onTap: (val) {
                        if (val is Widget) {
                          onBackspacePress();
                        } else if (val == "전체삭제") {
                          onAllClearPress();
                        } else {
                          if (setPassword.length & checkPassword.length <= 6) {
                            onKeyTap(val);
                          }
                        }
                      },
                    ),
                  );
                }).toList(),
              ))
          .toList(),
    );
  }
}

Widget _passwordFigure(List figureData, InfoType nowState) {
  return Expanded(
    child: nowState == InfoType.incorrectInfo
        ? ShakeWidget(
            duration: const Duration(seconds: 5),
            autoPlay: true,
            shakeConstant: ShakeHorizontalConstant1(),
            child: _renderFigure(figureData),
          )
        : _renderFigure(figureData),
  );
}

Widget _renderFigure(List<dynamic> figureData) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            figureData.length, (index) => figureBox(figureData[index][1]))),
  );
}

figureBox(hasData) => Container(
      child: hasData ? squareBox() : circleBox(),
    );
