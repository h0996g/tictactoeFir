import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoefir/online/online.dart';
import 'package:tictactoefir/online/cubit/online_cubit.dart';
import 'package:tictactoefir/online/cubit/online_state.dart';
import 'package:tictactoefir/shared/components/components.dart';

class CreeRoom extends StatefulWidget {
  const CreeRoom({Key? key}) : super(key: key);

  @override
  State<CreeRoom> createState() => _CreeRoomState();
}

class _CreeRoomState extends State<CreeRoom> {
  @override
  void initState() {
    OnlineCubit.get(context).getRandom();
    OnlineCubit.get(context).creeRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnlineCubit, OnlineState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (BuildContext context) => const Online(),
          condition: OnlineCubit.get(context).isStart == true,
          fallback: (BuildContext context) => _buildWaitingRoom(context),
        );
      },
    );
  }

  Widget _buildWaitingRoom(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        await FirebaseFirestore.instance
            .collection('Room')
            .doc(OnlineCubit.get(context).id.toString())
            .delete()
            .catchError((e) {
          print(e.toString());
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Game Room',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.teal[400],
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              OnlineCubit.get(context).endGameReset();
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTicTacToeGrid(),
                  const SizedBox(height: 40),
                  const Text(
                    'Your Room ID is:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildRoomIdDisplay(context),
                  const SizedBox(height: 40),
                  Button3D(
                    text: 'Change Room ID',
                    onPressed: () {
                      OnlineCubit.get(context).changeRoomId();
                    },
                    color: Colors.teal[600]!,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicTacToeGrid() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Center(
              child: Text(
                index % 2 == 0 ? 'X' : 'O',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoomIdDisplay(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        '${OnlineCubit.get(context).id}',
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          letterSpacing: 6,
          color: Colors.white,
        ),
      ),
    );
  }
}
