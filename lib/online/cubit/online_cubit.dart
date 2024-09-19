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

  Future<void> changeRoomId() async {
    await FirebaseFirestore.instance
        .collection('Room')
        .doc(id.toString())
        .delete()
        .then((value) async {
      getRandom();
      await creeRoom();
      emit(ChangeRoomIdGoodState());
    }).catchError((e) {
      emit(ChangeRoomIdBadState());
    });
  }

  Map<String, dynamic>? allcase = {};
  bool isStart = false;
  // var a;
  Future<void> lisnerStartGame(String idRoom) async {
    FirebaseFirestore.instance
        .collection('Room')
        .doc(idRoom)
        .snapshots()
        .listen((event) {
      allcase = event.data() ?? {};

      // Update local game state
      for (var i = 0; i < listButton.length; i++) {
        listButton[i].str = allcase!['$i'];
        listButton[i].enabled = (allcase!['$i'] == '');
        listButton[i].clr = (allcase!['$i'] == 'X'
            ? Colors.red
            : allcase!['$i'] == 'O'
                ? Colors.blue
                : Colors.grey[300]);
      }

      isStart = !allcase!['wating'];

      // Check for game end conditions
      if (allcase!['win'] != '') {
        handleGameEnd(allcase!['win']);
      }

      // Emit state change
      emit(GetMessageDataStateGood());
    });
  }

  void handleGameEnd(String result) {
    switch (result) {
      case 'P1':
        emit(P1WinState());
        break;
      case 'P2':
        emit(P2WinState());
        break;
      case 'tied':
        emit(TiedState());
        break;
    }
  }

  bool iswinner = false;
  bool isnull = false;
  // bool twopl = true;

  // Color xomessage = Colors.red;
  // double l = 0, r = 0, t = 0, b = 0;

  Random random = Random();
  bool xTurn = true;
  int zher = 0;

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
      // l = 0;
      // r = 0;
      // t = 0;
      // b = 0;
    }
    iswinner = false;
    isnull = false;
    xTurn = true;
    // xomessage = Colors.red;
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
    // int? idend = id;
    // id = ;

    for (int i = 0; i < 9; i++) {
      listButton[i].str = '';
      listButton[i].enabled = true;
      listButton[i].clr = Colors.grey[300];
      // l = 0;
      // r = 0;
      // t = 0;
      // b = 0;
    }
    iswinner = false;
    isnull = false;
    xTurn = true;
    isStart = false;
    // a.cancel();
    // isStart = false;
    // int? idTemp=id;

    await FirebaseFirestore.instance
        .collection('Room')
        .doc(id.toString())
        .update({'wating': true});
    await FirebaseFirestore.instance
        .collection('Room')
        .doc(id.toString())
        .delete();
    emit(EndGameResetValueState());
  }

  Future<void> checkWinner(String player) async {
    if (allcase!['0'] == player &&
        allcase!['1'] == player &&
        allcase!['2'] == player) {
      // l = 0.1;
      // r = 0.9;
      // t = 0.15;
      // b = 0.15;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['3'] == player &&
        allcase!['4'] == player &&
        allcase!['5'] == player) {
      // l = 0.1;
      // r = 0.9;
      // t = 0.44;
      // b = 0.44;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['6'] == player &&
        allcase!['7'] == player &&
        allcase!['8'] == player) {
      // l = 0.1;
      // r = 0.9;
      // t = 0.72;
      // b = 0.72;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['0'] == player &&
        allcase!['3'] == player &&
        allcase!['6'] == player) {
      // l = 0.174;
      // r = 0.174;
      // t = 0.089;
      // b = 0.79;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['1'] == player &&
        allcase!['4'] == player &&
        allcase!['7'] == player) {
      // l = 1 / 2;
      // r = 1 / 2;
      // t = 0.089;
      // b = 0.79;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['2'] == player &&
        allcase!['5'] == player &&
        allcase!['8'] == player) {
      // l = 0.83;
      // r = 0.83;
      // t = 0.089;
      // b = 0.79;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['0'] == player &&
        allcase!['4'] == player &&
        allcase!['8'] == player) {
      // l = 0.9;
      // r = 0.1;
      // t = 0.08;
      // b = 0.8;
      iswinner = true;
      // emit(IsWinnerState());
      // return;
    }
    if (allcase!['2'] == player &&
        allcase!['4'] == player &&
        allcase!['6'] == player) {
      // l = 0.9;
      // r = 0.1;
      // t = 0.8;
      // b = 0.08;
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
        listButton[i].clr = Colors.blue;
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
    // emit(IsWinnerState());
    print('IsWinnerState()');
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
    if (turnLogic == allcase!['turn']) {
      Map<String, dynamic> updates = {};

      // Update the game board
      String playerSymbol = allcase!['turn'] ? 'X' : 'O';
      updates['$index'] = playerSymbol;

      // Update the turn
      updates['turn'] = !allcase!['turn'];

      // Update the local state
      listButton[index].str = playerSymbol;
      listButton[index].enabled = false;
      listButton[index].clr = allcase!['turn'] ? Colors.red : Colors.blue;

      // Check for winner or tie
      bool isWinner = checkWinnerLocally(playerSymbol);
      bool isTie = checkTieLocally();

      if (isWinner) {
        updates['win'] = allcase!['turn'] ? 'P1' : 'P2';
        updates[allcase!['turn'] ? 'scorP1' : 'scorP2'] =
            FieldValue.increment(1);
      } else if (isTie) {
        updates['win'] = 'tied';
      }

      // Apply all updates to Firestore in a single operation
      await FirebaseFirestore.instance
          .collection('Room')
          .doc(id.toString())
          .update(updates);
    }
  }

  bool checkWinnerLocally(String player) {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (listButton[pattern[0]].str == player &&
          listButton[pattern[1]].str == player &&
          listButton[pattern[2]].str == player) {
        return true;
      }
    }
    return false;
  }

  bool checkTieLocally() {
    return listButton.every((button) => button.str != '');
  }
}
