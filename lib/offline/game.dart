import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoefir/offline/cubit/logic_cubit.dart';
import 'package:tictactoefir/offline/cubit/logic_state.dart';
import 'package:tictactoefir/shared/components/winner_line.dart';

class Offline extends StatelessWidget {
  const Offline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364)
                ],
              ),
            ),
            child: SafeArea(
              child: BlocConsumer<LogicCubit, LogicState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight -
                            MediaQuery.of(context).padding.top,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: height * 0.02),
                            _buildMultiplayerToggle(context, width, height),
                            SizedBox(height: height * 0.02),
                            _buildGameBoard(context, width),
                            SizedBox(height: height * 0.02),
                            _buildTurnIndicator(context, width),
                            SizedBox(height: height * 0.02),
                            _buildScoreBoard(context, width),
                            SizedBox(height: height * 0.02),
                            _buildActionButtons(context, width),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMultiplayerToggle(
      BuildContext context, double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.01),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(width * 0.08),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Multiplayer',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: width * 0.045,
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

  Widget _buildGameBoard(BuildContext context, double width) {
    return Container(
      padding: EdgeInsets.all(width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(width * 0.05),
      ),
      child: SizedBox(
        width: width * 0.8,
        height: width * 0.8,
        child: Stack(
          children: [
            GridView.builder(
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
                return _buildGameTile(context, index, width);
              },
            ),
            if (LogicCubit.get(context).iswinner)
              _buildWinningLine(context, width),
          ],
        ),
      ),
    );
  }

  Widget _buildWinningLine(BuildContext context, double width) {
    String? winningLine = LogicCubit.get(context).winningLine;
    if (winningLine == null) return SizedBox.shrink();

    return CustomPaint(
      size: Size(width * 0.8, width * 0.8),
      painter: WinningLinePainter(winningLine),
    );
  }

  Widget _buildGameTile(BuildContext context, int index, double width) {
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
          borderRadius: BorderRadius.circular(width * 0.03),
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
              fontSize: width * 0.15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTurnIndicator(BuildContext context, double width) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(width * 0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LogicCubit.get(context).turn ? 'X' : 'O',
            style: GoogleFonts.poppins(
              color: LogicCubit.get(context).xomessage,
              fontSize: width * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: width * 0.02),
          Text(
            'TURN',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: width * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBoard(BuildContext context, double width) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(width * 0.04),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPlayerScore(
              'Player One', LogicCubit.get(context).xcount, width),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Text(
              '-',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildPlayerScore(
              'Player Two', LogicCubit.get(context).ocount, width),
        ],
      ),
    );
  }

  Widget _buildPlayerScore(String player, int score, double width) {
    return Column(
      children: [
        Text(
          player,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          score.toString(),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton('New Game', Icons.refresh, () {
          LogicCubit.get(context).xcountsave = LogicCubit.get(context).xcount;
          LogicCubit.get(context).ocountsave = LogicCubit.get(context).ocount;
          LogicCubit.get(context).reset();
          LogicCubit.get(context).xcount = LogicCubit.get(context).xcountsave;
          LogicCubit.get(context).ocount = LogicCubit.get(context).ocountsave;
        }, width),
        _buildActionButton('End Game', Icons.stop, () {
          LogicCubit.get(context).reset();
        }, width),
      ],
    );
  }

  Widget _buildActionButton(
      String text, IconData icon, VoidCallback onTap, double width) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: width * 0.04,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2C5364),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: width * 0.03),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.08),
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
          final double dialogWidth = MediaQuery.of(context).size.width;
          return Dialog(
            backgroundColor:
                Colors.transparent, // Make the background transparent
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.0), // Rounded corners
              ),
              padding: EdgeInsets.all(20.0), // Padding inside the dialog
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Game Over',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: dialogWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    LogicCubit.get(context).p1win
                        ? 'Player One Won!'
                        : LogicCubit.get(context).p2win
                            ? 'Player Two Won!'
                            : 'It\'s a Draw!',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: dialogWidth * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    child: Text(
                      'Play Again',
                      style: GoogleFonts.poppins(
                        fontSize: dialogWidth * 0.045,
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
              ),
            ),
          );
        },
      );
    }
  }
}
