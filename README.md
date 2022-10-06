# artinus_mission

## Used
- 개발 환경
```
Flutter 3.3.2
Dart 2.18.1
```
- package
```
flutter_shake_animated: ^0.0.5
```
## 스크린샷

### Password Set

#### 동일한 숫자 3번 입력 시, 팝업 알림
![동일 숫자 3번](https://user-images.githubusercontent.com/55618626/194410570-e31443f2-ca9b-4053-b714-ff1e74ef85ec.gif)

#### 6 자리 입력 및 전체삭제, 하나 삭제 기능
![전체삭제](https://user-images.githubusercontent.com/55618626/194410592-2e5f0aa8-d06c-4fc5-a1ec-de13824ada30.gif)

#### 비밀번호 한번 더 입력 화면, 일치하지 않는 화면, 결과 화면
![ezgif com-gif-maker](https://user-images.githubusercontent.com/55618626/194410607-83010669-fccb-404a-985f-dbbb5d7e1154.gif)



## 로직 플로우차트
![화면 캡처 2022-10-06 044613](https://user-images.githubusercontent.com/55618626/194411197-bc880f02-8c98-4d52-acbb-20a6e9194e0f.png)

## 파일구조 
```
├─ main.dart
│
├─components
│  │  alarm_dialog.dart
│  │  custom_keyboard.dart
│  │
│  └─figure
│          circle_box.dart
│          square_box.dart
│
└─screens
        home_screen.dart
        password_set_screen.dart
        result_screen.dart
```


