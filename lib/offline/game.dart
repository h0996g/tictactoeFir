import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoefir/shared/button.dart';

import 'cubit/logic_cubit.dart';
import 'cubit/logic_state.dart';

class Offline extends StatelessWidget {
  Offline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LogicCubit, LogicState>(
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
                              value: LogicCubit.get(context).twopl,
                              onChanged: (b) {
                                LogicCubit.get(context).switchMultiPlayer(b!);

                                LogicCubit.get(context).reset();
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
                                color1: LogicCubit.get(context)
                                    .listButton[index]
                                    .clr,
                                text: Text(
                                  LogicCubit.get(context).listButton[index].str,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 90.0),
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  if (LogicCubit.get(context)
                                      .listButton[index]
                                      .enabled) {
                                    LogicCubit.get(context).playGame(index);
                                  }

                                  if (LogicCubit.get(context).p1win ||
                                      LogicCubit.get(context).p2win ||
                                      LogicCubit.get(context).tied) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                              LogicCubit.get(context).p1win
                                                  ? 'Player one won'
                                                  : LogicCubit.get(context)
                                                          .p2win
                                                      ? 'player two won'
                                                      : LogicCubit.get(context)
                                                              .tied
                                                          ? 'DRAW'
                                                          : '',
                                              style: TextStyle(
                                                  color: LogicCubit.get(context)
                                                              .p2win &&
                                                          !LogicCubit.get(
                                                                  context)
                                                              .twopl
                                                      ? Colors.blue
                                                      : LogicCubit.get(context)
                                                              .tied
                                                          ? Colors.brown
                                                          : LogicCubit.get(
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
                                                  LogicCubit.get(context)
                                                          .xcountsave =
                                                      LogicCubit.get(context)
                                                          .xcount;
                                                  LogicCubit.get(context)
                                                          .ocountsave =
                                                      LogicCubit.get(context)
                                                          .ocount;
                                                  LogicCubit.get(context)
                                                      .reset();
                                                  LogicCubit.get(context)
                                                          .xcount =
                                                      LogicCubit.get(context)
                                                          .xcountsave;
                                                  LogicCubit.get(context)
                                                          .ocount =
                                                      LogicCubit.get(context)
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
                              LogicCubit.get(context).l,
                              LogicCubit.get(context).r,
                              LogicCubit.get(context).t,
                              LogicCubit.get(context).b),
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
                                    LogicCubit.get(context).turn ? 'X ' : 'O',
                                    style: TextStyle(
                                        color:
                                            LogicCubit.get(context).xomessage,
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
                                'Player One ${LogicCubit.get(context).xcount} -',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' ${LogicCubit.get(context).ocount} Player Two',
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
                              LogicCubit.get(context).xcountsave =
                                  LogicCubit.get(context).xcount;
                              LogicCubit.get(context).ocountsave =
                                  LogicCubit.get(context).ocount;
                              LogicCubit.get(context).reset();
                              LogicCubit.get(context).xcount =
                                  LogicCubit.get(context).xcountsave;
                              LogicCubit.get(context).ocount =
                                  LogicCubit.get(context).ocountsave;
                            }),
                        Button3d(
                          text: const Text(
                            "End Game",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            LogicCubit.get(context).reset();
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
