import 'package:artinus_mission/components/figure/circle_box.dart';
import 'package:artinus_mission/components/figure/square_box.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../components/custom_keyboard.dart';

class PassWordSetScreen extends StatefulWidget {
  const PassWordSetScreen({super.key});

  @override
  State<PassWordSetScreen> createState() => _PassWordSetScreenState();
}

enum InfoType { infoText, checkInfoText, incorrectInfoText }

class _PassWordSetScreenState extends State<PassWordSetScreen> {
  final String infoText = "비밀번호 6자리를 입력해주세요.";
  final String checkInfoText = "비밀번호를 한번 더 입력해주세요.";
  final String incorrectInfoText = "비밀번호가 일치하지 않습니다.";
  InfoType nowState = InfoType.infoText;
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

  List keys = [];
  var topKeys = <String>{};
  final List bottomKeys = [
    '전체삭제',
    '0',
    const Icon(Icons.arrow_back, color: Colors.white)
  ];

  @override
  void initState() {
    var rng = Random();
    topKeys = <String>{};
    while (topKeys.length < 9) {
      topKeys.add(rng.nextInt(10).toString());
    }
    final reasonsList = topKeys.toList();
    reasonsList.sort();
    for (int i = 0; i < 9; i++) {
      if (i.toString() != reasonsList[i]) {
        bottomKeys[1] = i.toString();
        break;
      }
    }
    keys = [...topKeys, ...bottomKeys];

    nowState = InfoType.infoText;
    setPassword = "";

    super.initState();
  }

  onKeyTap(val) {
    setState(() {
      if (nowState == InfoType.infoText) {
        if (setPassword.length <= 5) {
          setPassword = setPassword + val;
          figureData[setPassword.length - 1][1] = true;
          if (setPassword.length == 6) {
            nowState = InfoType.checkInfoText;
          }
        } else {
          nowState = InfoType.checkInfoText;
        }
      } else if (nowState == InfoType.checkInfoText) {
        if (checkPassword.length <= 5) {
          checkPassword = checkPassword + val;
          if (setPassword.compareTo(checkPassword) == 0) {
            //결과화면으로 이동
          } else {
            nowState == InfoType.incorrectInfoText;
          }
        }
      }

      print(setPassword);
      print(checkPassword);
      print(nowState);
    });
  }

  onBackspacePress() {
    setState(() {
      if (nowState == InfoType.infoText && setPassword.isNotEmpty) {
        setPassword = setPassword.substring(0, setPassword.length - 1);
      } else if (nowState == InfoType.checkInfoText &&
          checkPassword.isNotEmpty) {
        checkPassword = checkPassword.substring(0, checkPassword.length - 1);
      }
    });
  }

  onAllClearPress() {
    setState(() {
      if (nowState == InfoType.infoText) {
        setPassword = "";
        figureData
            .asMap()
            .forEach((index, value) => figureData[index][1] = false);
      } else if (nowState == InfoType.checkInfoText) {
        checkPassword = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _infoText(),
            _passwordFigure(figureData),
            _customKeyboard(),
          ],
        ),
      )),
    );
  }

  Widget _customKeyboard() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 4.5),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 2,
        children: keys
            .map((e) => Row(
                  children: [
                    Expanded(
                        child: CustomKeyboard(
                      label: e,
                      value: e,
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
                    )),
                  ],
                ))
            .toList(),
      ),
    ));
  }

  Widget _infoText() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        nowState == InfoType.infoText
            ? infoText
            : nowState == InfoType.checkInfoText
                ? checkInfoText
                : incorrectInfoText,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

Widget _passwordFigure(List figureData) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              figureData.length, (index) => figureBox(figureData[index][1]))),
    ),
  );
}

figureBox(hasData) {
  return Container(
    child: hasData ? circleBox() : squareBox(),
  );
}
