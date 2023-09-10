import 'package:flutter/material.dart';
import 'package:tictactoefir/online/choose.dart';
import 'package:tictactoefir/shared/button.dart';
import 'package:tictactoefir/shared/components/components.dart';
import 'package:tictactoefir/offline/game.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    Button3d b1 = Button3d(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Offline()));
        },
        color1: Colors.yellow[300],
        color2: Colors.yellow,
        color3: Colors.amber,
        text: const Text(
          'Start Game',
          style: TextStyle(fontSize: 50),
        ));
    Button3d b2 = Button3d(
        onTap: () {
          navigatAndReturn(context: context, page: const Choose()
              // Room(),
              );
        },
        text: const Text(
          'Online',
          style: TextStyle(fontSize: 50),
        ));
    Button3d b3 = Button3d(
        onTap: () => null,
        text: const Text(
          'About Us',
          style: TextStyle(fontSize: 50),
        ));
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/tiic.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            b1,
            const SizedBox(
              height: 50,
            ),
            b2,
            const SizedBox(
              height: 50,
            ),
            b3
          ],
        ),
      ),
    );
  }
}
