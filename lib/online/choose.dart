import 'package:flutter/material.dart';
import 'package:tictactoefir/online/creeRoom.dart';
import 'package:tictactoefir/online/joinRoom.dart';
import 'package:tictactoefir/shared/components/components.dart';

class Choose extends StatelessWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Game Mode',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal[400],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose Game Mode',
              style: TextStyle(
                fontSize: 36,
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
            SizedBox(height: size.height * 0.03),
            Button3D(
              text: 'Create Room',
              onPressed: () {
                navigatAndReturn(context: context, page: const CreeRoom());
              },
              color: Colors.teal[400]!,
            ),
            const SizedBox(height: 40),
            Button3D(
              text: 'Join Room',
              onPressed: () {
                navigatAndReturn(context: context, page: const JoinRoom());
              },
              color: Colors.teal[700]!,
            ),
          ],
        ),
      ),
    );
  }
}
