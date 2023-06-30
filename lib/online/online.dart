import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoefir/shared/button.dart';
import 'package:tictactoefir/online/cubit/online_cubit.dart';
import 'package:tictactoefir/online/cubit/online_state.dart';

class Online extends StatelessWidget {
  // final int random;
  Online({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OnlineCubit, OnlineState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xff246ee9)),
                        child: Center(
                          child: CheckboxListTile(
                              secondary: const Icon(
                                Icons.group,
                                size: 50,
                              ),
                              title: const Text(
                                'Multiplayer :',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              value: OnlineCubit.get(context).twopl,
                              onChanged: (b) {
                                OnlineCubit.get(context).switchMultiPlayer(b!);

                                OnlineCubit.get(context).reset();
                              }),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        NotificationListener<OverscrollIndicatorNotification>(
                          onNotification: (overScroll) {
                            overScroll.disallowGlow();
                            return true;
                          },
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.0,
                                    crossAxisSpacing: 12.0,
                                    mainAxisSpacing: 12.0),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Button3d(
                                color1: OnlineCubit.get(context)
                                    .listButton[index]
                                    .clr,
                                text: Text(
                                  OnlineCubit.get(context)
                                      .listButton[index]
                                      .str,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 90.0),
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  if (OnlineCubit.get(context)
                                      .listButton[index]
                                      .enabled) {
                                    OnlineCubit.get(context).playGame(index);
                                  }

                                  if (OnlineCubit.get(context).p1win ||
                                      OnlineCubit.get(context).p2win ||
                                      OnlineCubit.get(context).tied) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                              OnlineCubit.get(context).p1win
                                                  ? 'Player one won'
                                                  : OnlineCubit.get(context)
                                                          .p2win
                                                      ? 'player two won'
                                                      : OnlineCubit.get(context)
                                                              .tied
                                                          ? 'DRAW'
                                                          : '',
                                              style: TextStyle(
                                                  color: OnlineCubit.get(
                                                                  context)
                                                              .p2win &&
                                                          !OnlineCubit.get(
                                                                  context)
                                                              .twopl
                                                      ? Colors.blue
                                                      : OnlineCubit.get(context)
                                                              .tied
                                                          ? Colors.brown
                                                          : OnlineCubit.get(
                                                                  context)
                                                              .xomessage,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text(
                                                  'Play Again!',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.teal,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  OnlineCubit.get(context)
                                                          .xcountsave =
                                                      OnlineCubit.get(context)
                                                          .xcount;
                                                  OnlineCubit.get(context)
                                                          .ocountsave =
                                                      OnlineCubit.get(context)
                                                          .ocount;
                                                  OnlineCubit.get(context)
                                                      .reset();
                                                  OnlineCubit.get(context)
                                                          .xcount =
                                                      OnlineCubit.get(context)
                                                          .xcountsave;
                                                  OnlineCubit.get(context)
                                                          .ocount =
                                                      OnlineCubit.get(context)
                                                          .ocountsave;
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        CustomPaint(
                          foregroundPainter: LinePainter(
                              OnlineCubit.get(context).l,
                              OnlineCubit.get(context).r,
                              OnlineCubit.get(context).t,
                              OnlineCubit.get(context).b),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Button3d(
                          // margin: const EdgeInsets.symmetric(horizontal: 80),
                          text: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 40,
                                  child: Text(
                                    OnlineCubit.get(context).turn ? 'X ' : 'O',
                                    style: TextStyle(
                                        color:
                                            OnlineCubit.get(context).xomessage,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const Text('TURN',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                'Player One ${OnlineCubit.get(context).xcount} -',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' ${OnlineCubit.get(context).ocount} Player Two',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button3d(
                            text: const Text(
                              'New Game',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              //bah yb9a score..
                              OnlineCubit.get(context).xcountsave =
                                  OnlineCubit.get(context).xcount;
                              OnlineCubit.get(context).ocountsave =
                                  OnlineCubit.get(context).ocount;
                              OnlineCubit.get(context).reset();
                              OnlineCubit.get(context).xcount =
                                  OnlineCubit.get(context).xcountsave;
                              OnlineCubit.get(context).ocount =
                                  OnlineCubit.get(context).ocountsave;
                            }),
                        Button3d(
                          text: const Text(
                            "End Game",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            OnlineCubit.get(context).reset();
                          },
                        ),
                      ],
                    ),
                  ),
                ]);
          },
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  late double l;
  late double r;
  late double b;
  late double t;
  LinePainter(this.l, this.r, this.b, this.t);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
    canvas.drawLine(
      Offset(size.width * l, size.height * t),
      Offset(size.width * r, size.height * b),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
