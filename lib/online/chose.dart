import 'package:flutter/material.dart';
import 'package:tictactoefir/online/creeRoom.dart';
import 'package:tictactoefir/online/joinRoom.dart';
import 'package:tictactoefir/shared/button.dart';
import 'package:tictactoefir/shared/components/components.dart';

class Choose extends StatelessWidget {
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
    Button3d b1 = Button3d(
      onTap: () {
        navigatAndReturn(context: context, page: const CreeRoom());
      },
      text: const Text(
        'CreeRoom',
        style: TextStyle(fontSize: 50),
      ),
    );
    Button3d b2 = Button3d(
      onTap: () {
        navigatAndReturn(context: context, page: const JoinRoom());
      },
      text: const Text(
        'Join Room',
        style: TextStyle(fontSize: 50),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              b1,
              const SizedBox(
                height: 80,
              ),
              b2
            ]),
      ),
    );
  }
}
