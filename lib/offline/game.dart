import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoefir/offline/cubit/logic_cubit.dart';
import 'package:tictactoefir/offline/cubit/logic_state.dart';

class Offline extends StatelessWidget {
  const Offline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF004D40), Color(0xFF00796B)],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<LogicCubit, LogicState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMultiplayerToggle(context),
                  _buildGameBoard(context),
                  _buildTurnIndicator(context),
                  _buildScoreBoard(context),
                  _buildActionButtons(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMultiplayerToggle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Multiplayer',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Switch(
            value: LogicCubit.get(context).twopl,
            onChanged: (value) {
              LogicCubit.get(context).switchMultiPlayer(value);
              LogicCubit.get(context).reset();
            },
            activeColor: Colors.teal[400],
          ),
        ],
      ),
    );
  }

  Widget _buildGameBoard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return _buildGameTile(context, index);
        },
      ),
    );
  }

  Widget _buildGameTile(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (LogicCubit.get(context).listButton[index].enabled) {
          LogicCubit.get(context).playGame(index);
        }
        _checkGameResult(context);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: LogicCubit.get(context).listButton[index].clr.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            LogicCubit.get(context).listButton[index].str,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTurnIndicator(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LogicCubit.get(context).turn ? 'X' : 'O',
            style: GoogleFonts.poppins(
              color: LogicCubit.get(context).xomessage,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'TURN',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBoard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPlayerScore('Player One', LogicCubit.get(context).xcount),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '-',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildPlayerScore('Player Two', LogicCubit.get(context).ocount),
        ],
      ),
    );
  }

  Widget _buildPlayerScore(String player, int score) {
    return Column(
      children: [
        Text(
          player,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          score.toString(),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          'New Game',
          Icons.refresh,
          () {
            LogicCubit.get(context).xcountsave = LogicCubit.get(context).xcount;
            LogicCubit.get(context).ocountsave = LogicCubit.get(context).ocount;
            LogicCubit.get(context).reset();
            LogicCubit.get(context).xcount = LogicCubit.get(context).xcountsave;
            LogicCubit.get(context).ocount = LogicCubit.get(context).ocountsave;
          },
        ),
        _buildActionButton(
          'End Game',
          Icons.stop,
          () {
            LogicCubit.get(context).reset();
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal[600],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void _checkGameResult(BuildContext context) {
    if (LogicCubit.get(context).p1win ||
        LogicCubit.get(context).p2win ||
        LogicCubit.get(context).tied) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Game Over',
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            content: Text(
              LogicCubit.get(context).p1win
                  ? 'Player One Won!'
                  : LogicCubit.get(context).p2win
                      ? 'Player Two Won!'
                      : 'It\'s a Draw!',
              style: GoogleFonts.poppins(
                color: LogicCubit.get(context).p2win &&
                        !LogicCubit.get(context).twopl
                    ? Colors.blue
                    : LogicCubit.get(context).tied
                        ? Colors.brown
                        : LogicCubit.get(context).xomessage,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                child: Text(
                  'Play Again',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  LogicCubit.get(context).xcountsave =
                      LogicCubit.get(context).xcount;
                  LogicCubit.get(context).ocountsave =
                      LogicCubit.get(context).ocount;
                  LogicCubit.get(context).reset();
                  LogicCubit.get(context).xcount =
                      LogicCubit.get(context).xcountsave;
                  LogicCubit.get(context).ocount =
                      LogicCubit.get(context).ocountsave;
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
