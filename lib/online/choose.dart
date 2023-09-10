import 'package:flutter/material.dart';
import 'package:tictactoefir/online/creeRoom.dart';
import 'package:tictactoefir/online/joinRoom.dart';
import 'package:tictactoefir/shared/button.dart';
import 'package:tictactoefir/shared/components/components.dart';

class Choose extends StatelessWidget {
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      // appBar: AppBar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/tiic.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(

              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 3,
                ),
                b1,
                const SizedBox(
                  height: 80,
                ),
                b2
              ]),
        ),
      ),
    );
  }
}
