import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoefir/online/cubit/online_cubit.dart';
import 'package:tictactoefir/online/cubit/online_state.dart';
import 'package:tictactoefir/shared/components/winner_line.dart';

class Online extends StatefulWidget {
  const Online({super.key});

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  late OnlineCubit _onlineCubit;
  @override
  void initState() {
    super.initState();
    _onlineCubit = OnlineCubit.get(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _onlineCubit.endGameReset();
    super.dispose();
  }

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
              child: BlocConsumer<OnlineCubit, OnlineState>(
                listener: (context, state) {
                  if (state is GetMessageDataStateGood) {
                    _checkGameResult(context);
                  }
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
                            _buildRoomInfo(context, width, height),
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

  Widget _buildRoomInfo(BuildContext context, double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.01),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(width * 0.08),
      ),
      child: Text(
        'Room: ${OnlineCubit.get(context).id}',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: width * 0.06,
          fontWeight: FontWeight.w600,
        ),
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
            _buildWinningLine(context, width),
          ],
        ),
      ),
    );
  }

  Widget _buildWinningLine(BuildContext context, double width) {
    String? winningLine = OnlineCubit.get(context).allcase!['winningLine'];
    if (winningLine == null) return const SizedBox.shrink();

    return CustomPaint(
      size: Size(width * 0.8, width * 0.8),
      painter: WinningLinePainter(winningLine),
    );
  }

  Widget _buildGameTile(BuildContext context, int index, double width) {
    return GestureDetector(
      onTap: () {
        if (OnlineCubit.get(context).listButton[index].enabled &&
            OnlineCubit.get(context).turnLogic ==
                OnlineCubit.get(context).allcase!['turn']) {
          OnlineCubit.get(context).playGame(index);
        }
      },
      child: Container(
        // duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color:
              OnlineCubit.get(context).listButton[index].clr.withOpacity(0.7),
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
            OnlineCubit.get(context).listButton[index].str,
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
            OnlineCubit.get(context).allcase!['turn'] ? 'X' : 'O',
            style: GoogleFonts.poppins(
              color: OnlineCubit.get(context).allcase!['turn']
                  ? Colors.red
                  : Colors.blue,
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
              'Player One', OnlineCubit.get(context).allcase!['scorP1'], width),
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
              'Player Two', OnlineCubit.get(context).allcase!['scorP2'], width),
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
        _buildActionButton(
          'End Game',
          Icons.stop,
          () {
            OnlineCubit.get(context).endGameReset();
          },
          width,
        ),
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
    final String? winner = OnlineCubit.get(context).allcase!['win'];
    if (winner == 'P1' || winner == 'P2' || winner == 'tied') {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final double dialogWidth = MediaQuery.of(context).size.width;
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
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
                padding:
                    const EdgeInsets.all(20.0), // Padding inside the dialog
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
                      winner == 'P1'
                          ? 'Player One Won!'
                          : winner == 'P2'
                              ? 'Player Two Won!'
                              : 'It\'s a Draw!',
                      style: GoogleFonts.poppins(
                        color: winner == 'P2'
                            ? Colors.blue
                            : winner == 'tied'
                                ? Colors.brown
                                : Colors.red,
                        fontSize: dialogWidth * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
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
                        OnlineCubit.get(context).playAgainReset();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
