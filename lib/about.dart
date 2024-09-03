import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tictactoefir/online/choose.dart';
import 'package:tictactoefir/shared/components/components.dart';
import 'package:tictactoefir/offline/game.dart';
import 'package:url_launcher/url_launcher.dart';

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
                onPressed: () async {
                  Uri url = Uri.parse('https://houssameddine.netlify.app/');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                color: Colors.teal[900]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
