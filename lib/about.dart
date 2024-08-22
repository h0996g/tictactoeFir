import 'package:flutter/material.dart';
import 'package:tictactoefir/online/choose.dart';
import 'package:tictactoefir/shared/components/components.dart';
import 'package:tictactoefir/offline/game.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tic Tac Toe',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Button3D(
                text: 'Start Game',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Offline()),
                ),
                color: Colors.teal[400]!,
              ),
              const SizedBox(height: 20),
              Button3D(
                text: 'Online',
                onPressed: () =>
                    navigatAndReturn(context: context, page: const Choose()),
                color: Colors.teal[700]!,
              ),
              const SizedBox(height: 20),
              Button3D(
                text: 'About Us',
                onPressed: () {},
                color: Colors.teal[900]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
