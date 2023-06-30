import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../gamebutton.dart';
import 'online_state.dart';

class OnlineCubit extends Cubit<OnlineState> {
  OnlineCubit() : super(OnlineInitial());
  static OnlineCubit get(context) => BlocProvider.of(context);
  var rng = Random();
  int? id;
  void startGame() {
    id = 12345;
    // rng.nextInt(1000);
    FirebaseFirestore.instance.collection('user').doc(id.toString()).set(
        // random as Map<String, dynamic>,
        {
          '1': false,
          '2': false,
          '3': false,
          '4': false,
          '5': false,
          '6': false,
          '7': false,
          '8': false,
        });
  }

  bool iswinner = false;
  bool isnull = false;
  bool twopl = false;
  int xcount = 0;
  int ocount = 0;
  late int xcountsave;
  late int ocountsave;
  Color xomessage = Colors.red;
  double l = 0, r = 0, t = 0, b = 0;

  //pop//
  //test//
  bool p1win = false;
  bool p2win = false;
  bool tied = false;

  //pop//
  Random random = Random();
  bool turn = true;
  int zher = 0;

  List<int> machineindex = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var player1 = [];
  var player2 = [];
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
  void reset() {
    for (int i = 0; i < 9; i++) {
      listButton[i].str = '';
      listButton[i].enabled = true;
      listButton[i].clr = Colors.grey[300];
      l = 0;
      r = 0;
      t = 0;
      b = 0;

      // listButton[a].clr2 = Colors.transparent;
    }
    iswinner = false;
    isnull = false;
    xcount = 0;
    ocount = 0;
    turn = true;
    p2win = false;
    p1win = false;
    tied = false;
    machineindex = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    player1 = [];
    player2 = [];
    xomessage = Colors.red;
    emit(ResetValueState());
  }

  switchMultiPlayer(bool value) {
    twopl = value;
    emit(TwoPlayerSwitchState());
  }

  void player22(int a) {
    listButton[a].str = 'O';
    FirebaseFirestore.instance
        .collection('user')
        .doc(id.toString())
        .update({a.toString(): true});
    listButton[a].enabled = false;
    listButton[a].clr = Colors.blue;
    // listButton[a].clr2 = Colors.blue;
    player2.add(a);
    machineindex.remove(a);
    emit(P2PlayState());
  }

  void checkWinner(var player) {
    if (player.contains(0) && player.contains(1) && player.contains(2)) {
      l = 0.1;
      r = 0.9;
      t = 0.15;
      b = 0.15;
      iswinner = true;
      emit(IsWinnerState());
    }
    if (player.contains(3) && player.contains(4) && player.contains(5)) {
      l = 0.1;
      r = 0.9;
      t = 0.44;
      b = 0.44;
      iswinner = true;
      emit(IsWinnerState());
    }
    if (player.contains(6) && player.contains(7) && player.contains(8)) {
      l = 0.1;
      r = 0.9;
      t = 0.72;
      b = 0.72;
      iswinner = true;
      emit(IsWinnerState());
    }
    if (player.contains(0) && player.contains(3) && player.contains(6)) {
      l = 0.174;
      r = 0.174;
      t = 0.089;
      b = 0.79;
      iswinner = true;
      emit(IsWinnerState());
    }
    if (player.contains(1) && player.contains(4) && player.contains(7)) {
      l = 1 / 2;
      r = 1 / 2;
      t = 0.089;
      b = 0.79;
      iswinner = true;
      emit(IsWinnerState());
    }
    if (player.contains(2) && player.contains(5) && player.contains(8)) {
      l = 0.83;
      r = 0.83;
      t = 0.089;
      b = 0.79;
      iswinner = true;
      emit(IsWinnerState());
    }
    if (player.contains(0) && player.contains(4) && player.contains(8)) {
      l = 0.9;
      r = 0.1;
      t = 0.08;
      b = 0.8;
      iswinner = true;
      emit(IsWinnerState());
    }
    if (player.contains(2) && player.contains(4) && player.contains(6)) {
      l = 0.9;
      r = 0.1;
      t = 0.8;
      b = 0.08;
      iswinner = true;
      emit(IsWinnerState());
    }
    // twopl ? turn = false : turn = true;

    return;
  }

  void checkNull() {
    for (int i = 0; i < 9; i++) {
      if (listButton[i].enabled) return;
    }
    isnull = true;
    emit(IsNullState());
  }

  void playGame(int index) {
    // player 1
    if (turn) {
      listButton[index].str = 'X';
      FirebaseFirestore.instance
          .collection('user')
          .doc(id.toString())
          .update({index.toString(): true});
      listButton[index].enabled = false;

      listButton[index].clr = Colors.red;
      player1.add(index);
      machineindex.remove(index);
      if (twopl) {
        turn = false;
      }
      emit(P1PlayState());
    }
    checkWinner(player1);
    if (iswinner) {
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.red;
      }
      //kima yrb7 p1 yb9a mktob dalet x
      // !
      // turn = true;
      twopl ? turn = false : turn = true;

      p1win = true;
      xcount++;
      emit(P1WinState());
      return;
    }
    // check Null
    checkWinner(player2);
    checkWinner(player1);
    checkNull();
    if (!iswinner && isnull) {
      tied = true;
      emit(TiedState());
      return;
    }
    // player 2
    // var allPlayedButtons = new List.from(player1)..addAll(player2);
    if (machineindex.isNotEmpty && !twopl) {
      //win
      //line 1
      if (player2.contains(0) && player2.contains(1) && !player1.contains(2)) {
        player22(2);
      } else if (player2.contains(0) &&
          player2.contains(2) &&
          !player1.contains(1)) {
        player22(1);
      } else if (player2.contains(1) &&
          player2.contains(2) &&
          !player1.contains(0)) {
        player22(0);
      }
      //line 2
      else if (player2.contains(3) &&
          player2.contains(4) &&
          !player1.contains(5)) {
        player22(5);
      } else if (player2.contains(3) &&
          player2.contains(5) &&
          !player1.contains(4)) {
        player22(4);
      } else if (player2.contains(4) &&
          player2.contains(5) &&
          !player1.contains(3)) {
        player22(3);
      }
      //line 3
      else if (player2.contains(6) &&
          player2.contains(7) &&
          !player1.contains(8)) {
        player22(8);
      } else if (player2.contains(7) &&
          player2.contains(8) &&
          !player1.contains(6)) {
        player22(6);
      } else if (player2.contains(6) &&
          player2.contains(8) &&
          !player1.contains(7)) {
        player22(7);
      }
      //column 1
      else if (player2.contains(0) &&
          player2.contains(3) &&
          !player1.contains(6)) {
        player22(6);
      } else if (player2.contains(3) &&
          player2.contains(6) &&
          !player1.contains(0)) {
        player22(0);
      } else if (player2.contains(0) &&
          player2.contains(6) &&
          !player1.contains(3)) {
        player22(3);
      }
      //column 2
      else if (player2.contains(1) &&
          player2.contains(4) &&
          !player1.contains(7)) {
        player22(7);
      } else if (player2.contains(4) &&
          player2.contains(7) &&
          !player1.contains(1)) {
        player22(1);
      } else if (player2.contains(1) &&
          player2.contains(7) &&
          !player1.contains(4)) {
        player22(4);
      }
      //column 3
      else if (player2.contains(2) &&
          player2.contains(5) &&
          !player1.contains(8)) {
        player22(8);
      } else if (player2.contains(5) &&
          player2.contains(8) &&
          !player1.contains(2)) {
        player22(2);
      } else if (player2.contains(2) &&
          player2.contains(8) &&
          !player1.contains(5)) {
        player22(5);
      }
      //nos1
      else if (player2.contains(0) &&
          player2.contains(4) &&
          !player1.contains(8)) {
        player22(8);
      } else if (player2.contains(4) &&
          player2.contains(8) &&
          !player1.contains(0)) {
        player22(0);
      } else if (player2.contains(0) &&
          player2.contains(8) &&
          !player1.contains(4)) {
        player22(4);
      }
      //nos 2
      else if (player2.contains(2) &&
          player2.contains(4) &&
          !player1.contains(6)) {
        player22(6);
      } else if (player2.contains(2) &&
          player2.contains(6) &&
          !player1.contains(4)) {
        player22(4);
      } else if (player2.contains(4) &&
          player2.contains(6) &&
          !player1.contains(2)) {
        player22(2);
      }
      //nul
      //line 1
      else if (player1.contains(0) &&
          player1.contains(1) &&
          !player2.contains(2)) {
        player22(2);
      } else if (player1.contains(0) &&
          player1.contains(2) &&
          !player2.contains(1)) {
        player22(1);
      } else if (player1.contains(1) &&
          player1.contains(2) &&
          !player2.contains(0)) {
        player22(0);
      }
      //line 2
      else if (player1.contains(3) &&
          player1.contains(4) &&
          !player2.contains(5)) {
        player22(5);
      } else if (player1.contains(3) &&
          player1.contains(5) &&
          !player2.contains(4)) {
        player22(4);
      } else if (player1.contains(4) &&
          player1.contains(5) &&
          !player2.contains(3)) {
        player22(3);
      }
      //line 3
      else if (player1.contains(6) &&
          player1.contains(7) &&
          !player2.contains(8)) {
        player22(8);
      } else if (player1.contains(7) &&
          player1.contains(8) &&
          !player2.contains(6)) {
        player22(6);
      } else if (player1.contains(6) &&
          player1.contains(8) &&
          !player2.contains(7)) {
        player22(7);
      }
      //column 1
      else if (player1.contains(0) &&
          player1.contains(3) &&
          !player2.contains(6)) {
        player22(6);
      } else if (player1.contains(3) &&
          player1.contains(6) &&
          !player2.contains(0)) {
        player22(0);
      } else if (player1.contains(0) &&
          player1.contains(6) &&
          !player2.contains(3)) {
        player22(3);
      }
      //column 2
      else if (player1.contains(1) &&
          player1.contains(4) &&
          !player2.contains(7)) {
        player22(7);
      } else if (player1.contains(4) &&
          player1.contains(7) &&
          !player2.contains(1)) {
        player22(1);
      } else if (player1.contains(1) &&
          player1.contains(7) &&
          !player2.contains(4)) {
        player22(4);
      }
      //column 3
      else if (player1.contains(2) &&
          player1.contains(5) &&
          !player2.contains(8)) {
        player22(8);
      } else if (player1.contains(5) &&
          player1.contains(8) &&
          !player2.contains(2)) {
        player22(2);
      } else if (player1.contains(2) &&
          player1.contains(8) &&
          !player2.contains(5)) {
        player22(5);
      }
      //nos1
      else if (player1.contains(0) &&
          player1.contains(4) &&
          !player2.contains(8)) {
        player22(8);
      } else if (player1.contains(4) &&
          player1.contains(8) &&
          !player2.contains(0)) {
        player22(0);
      } else if (player1.contains(0) &&
          player1.contains(8) &&
          !player2.contains(4)) {
        player22(4);
      }
      //nos 2
      else if (player1.contains(2) &&
          player1.contains(4) &&
          !player2.contains(6)) {
        player22(6);
      } else if (player1.contains(2) &&
          player1.contains(6) &&
          !player2.contains(4)) {
        player22(4);
      } else if (player1.contains(4) &&
          player1.contains(6) &&
          !player2.contains(2)) {
        player22(2);
      } else {
        zher = machineindex[random.nextInt(machineindex.length)];
        player22(zher);
      }
    }
    //hadi kima y3odo two player
    if (listButton[index].enabled && !turn) {
      listButton[index].str = 'O';
      FirebaseFirestore.instance
          .collection('user')
          .doc(id.toString())
          .update({index.toString(): true});
      listButton[index].enabled = false;
      listButton[index].clr = Colors.blue;
      player2.add(index);
      turn = true;
      emit(SwitchTurnState());
    }
    checkWinner(player2);
    if (iswinner) {
      for (int i = 0; i < 9; i++) {
        listButton[i].enabled = false;
        listButton[i].clr = Colors.blue;
      }
      //3la jal kima y3od contre machif wtrb7 matetbedelch  flakher wtwali o turn
      twopl ? turn = false : turn = true;
      p2win = true;
      ocount++;
      emit(P2WinState());
      return;
    }
    // bh nb9a nbdl color t3 x w o f kol parti
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
