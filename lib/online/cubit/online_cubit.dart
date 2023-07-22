import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/gamebutton.dart';
import 'online_state.dart';

class OnlineCubit extends Cubit<OnlineState> {
  OnlineCubit() : super(OnlineInitial());
  static OnlineCubit get(context) => BlocProvider.of(context);
  var rng = Random();
  int? id;

  void getRandom() {
    id = rng.nextInt(10000);

    emit(GetRandomNumberState());
  }

  Future<void> creeRoom() async {
    await FirebaseFirestore.instance.collection('Room').doc(id.toString()).set({
      'wating': true,
      '0': '',
      '1': '',
      '2': '',
      '3': '',
      '4': '',
      '5': '',
      '6': '',
      '7': '',
      '8': '',
      'scorP1': 0,
      'scorP2': 0,
      'turn': true,
      'win': ''
    });
    turnLogic = true;
    lisnerStartGame(id.toString());
  }

  joinRoom(String idRoom) async {
    await FirebaseFirestore.instance
        .collection('Room')
        .doc(idRoom)
        .update({'wating': false}).then((value) {
      turnLogic = false;
      id = int.parse(idRoom);
      emit(IswaitinFalseGoodState());
      lisnerStartGame(idRoom);
    }).catchError((e) {
      emit(IswaitinFalseBadState());
      print(e.toString());
    });
  }

  Map<String, dynamic>? allcase = {};
  bool test = false;
  var a;
  Future<void> lisnerStartGame(String idRoom) async {
    a = FirebaseFirestore.instance
        .collection('Room')
        .doc(idRoom)
        .snapshots()
        .listen((event) {
      // allcase = {};
      allcase = event.data() ?? {};
      // checkWinner('O');
      // checkNull();
      // listButton.forEach((element) { });
      print(allcase);
      for (var i = 0; i < listButton.length; i++) {
        // print(allcase!['$i']);
        listButton[i].str = allcase!['$i'];
        listButton[i].enabled = (allcase!['$i'] == '' ? true : false);
      }

      // print(allcase!['wating']);
      if (allcase!['wating'] == false) {
        // print('hhhhhhhh');
        test = true;
        // emit(GetMessageDataStateGood());
      }
      // print('Listen stream');
      // print(allcase!['wating']);
      emit(GetMessageDataStateGood());
    });
  }

  bool iswinner = false;
  bool isnull = false;
  bool twopl = true;

  Color xomessage = Colors.red;
  double l = 0, r = 0, t = 0, b = 0;

  //pop//
  //test//
  // bool p1win = false;
  // bool p2win = false;
  // bool tied = false;

  //pop//
  Random random = Random();
  bool turn = true;
  int zher = 0;

  // List<int> machineindex = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  // var player1 = [];
  // var player2 = [];
  List listButton = <GameButton>[
    GameButton(1),
    GameButton(2),
    GameButton(3),
    GameButton(4),
    GameButton(5),
    GameButton(6),
    GameButton(7),
    GameButton(8),
    GameButton(9)
  ];
  Future<void> playAgainReset() async {
    for (int i = 0; i < 9; i++) {
      listButton[i].str = '';
      listButton[i].enabled = true;
      listButton[i].clr = Colors.grey[300];
      l = 0;
      r = 0;
      t = 0;
      b = 0;
    }
    iswinner = false;
    isnull = false;
    turn = true;
    xomessage = Colors.red;
    await FirebaseFirestore.instance
        .collection('Room')
        .doc(id.toString())
        .update({
      '0': '',
      '1': '',
      '2': '',
      '3': '',
      '4': '',
      '5': '',
      '6': '',
      '7': '',
      '8': '',
      // 'scorP1': 0,
      // 'scorP2': 0,
      'turn': true,
      'win': ''
    });
    emit(PlayAgainResetValueState());
  }

  Future<void> endGameReset() async {
    for (int i = 0; i < 9; i++) {
      listButton[i].str = '';
      listButton[i].enabled = true;
      listButton[i].clr = Colors.grey[300];
      l = 0;
      r = 0;
      t = 0;
      b = 0;
    }
    iswinner = false;
    isnull = false;
    turn = true;
    xomessage = Colors.red;
    test = false;
    a.cancel();
    id = null;
    emit(EndGameResetValueState());
  }

  Future<void> checkWinner(String player) async {
    if (allcase!['0'] == player &&
        allcase!['1'] == player &&
        allcase!['2'] == player) {
      l = 0.1;
      r = 0.9;
      t = 0.15;
      b = 0.15;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['3'] == player &&
        allcase!['4'] == player &&
        allcase!['5'] == player) {
      l = 0.1;
      r = 0.9;
      t = 0.44;
      b = 0.44;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['6'] == player &&
        allcase!['7'] == player &&
        allcase!['8'] == player) {
      l = 0.1;
      r = 0.9;
      t = 0.72;
      b = 0.72;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['0'] == player &&
        allcase!['3'] == player &&
        allcase!['6'] == player) {
      l = 0.174;
      r = 0.174;
      t = 0.089;
      b = 0.79;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['1'] == player &&
        allcase!['4'] == player &&
        allcase!['7'] == player) {
      l = 1 / 2;
      r = 1 / 2;
      t = 0.089;
      b = 0.79;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['2'] == player &&
        allcase!['5'] == player &&
        allcase!['8'] == player) {
      l = 0.83;
      r = 0.83;
      t = 0.089;
      b = 0.79;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['0'] == player &&
        allcase!['4'] == player &&
        allcase!['8'] == player) {
      l = 0.9;
      r = 0.1;
      t = 0.08;
      b = 0.8;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['2'] == player &&
        allcase!['4'] == player &&
        allcase!['6'] == player) {
      l = 0.9;
      r = 0.1;
      t = 0.8;
      b = 0.08;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    // twopl ? turn = false : turn = true;
    if (iswinner && player == 'X') {
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.red;
      }
      //kima yrb7 p1 yb9a mktob dalet x
      // !
      // turn = true;
      // twopl ? turn = false : turn = true;

      // p1win = true;
      await FirebaseFirestore.instance
          .collection('Room')
          .doc(id.toString())
          .update({'win': 'P1', 'scorP1': allcase!['scorP1'] + 1});
      print('P1 Rba7');

      emit(P1WinState());
      return;
    } else if (iswinner && player == 'O') {
      print('kfh Dkhol');
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.green;
      }
      //kima yrb7 p1 yb9a mktob dalet x
      // !
      // turn = true;
      // twopl ? turn = false : turn = true;

      // p2win = true;
      await FirebaseFirestore.instance
          .collection('Room')
          .doc(id.toString())
          .update({'win': 'P2', 'scorP2': allcase!['scorP2'] + 1});
      // ocount++;
      emit(P2WinState());
      return;
    }
    emit(IsWinnerState());
    return;
  }

  void checkNull() {
    for (int i = 0; i < 9; i++) {
      if (listButton[i].enabled) return;
    }
    isnull = true;
    emit(IsNullState());
  }

  bool? turnLogic;

  Future<void> playGame(int index) async {
    // player 1
    if (turnLogic == allcase!['turn']) {
      allcase!['turn']
          ? listButton[index].str = 'X'
          : listButton[index].str = 'O';

      await FirebaseFirestore.instance
          .collection('Room')
          .doc(id.toString())
          .update({'$index': allcase!['turn'] ? 'X' : 'O'});
      listButton[index].enabled = false;

      listButton[index].clr = allcase!['turn'] ? Colors.red : Colors.green;
      // player1.add(index);
      // machineindex.remove(index);

      await FirebaseFirestore.instance
          .collection('Room')
          .doc(id.toString())
          .update({'turn': !allcase!['turn']});

      emit(P1PlayState());
    }
    await checkWinner('X');
    if (!iswinner) {
      await checkWinner('O');
    }

    checkNull();
    if (!iswinner && isnull) {
      await FirebaseFirestore.instance
          .collection('Room')
          .doc(id.toString())
          .update({'win': 'tied'});
      // tied = true;
      emit(TiedState());
      return;
    }

    if (twopl) {
      if (xomessage == Colors.red) {
        xomessage = Colors.blue;
      } else {
        xomessage = Colors.red;
      }
      emit(ColorSwitchState());
    }
  }
}
