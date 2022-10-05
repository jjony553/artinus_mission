import 'package:artinus_mission/screens/password_set_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
          child: ElevatedButton(
              child: const Text("비밀번호 설정하기"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PassWordSetScreen(),
                  ),
                );
              })),
    );

    // Column(
    //   children: <Widget>[
    //     ElevatedButton(
    //       child: Text('Alert Dialog test'),
    //       onPressed: () {
    //         alarmDialog(
    //           context,
    //           '동일한 숫자를 연속해서 3자리 이상 설정할 수 없습니다.',
    //           () {
    //             Navigator.of(context, rootNavigator: true).pop();
    //           },
    //         );
    //       },
    //     )
    //   ],
    // ));
  }
}
