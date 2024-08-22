import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoefir/online/online.dart';
import 'package:tictactoefir/shared/components/components.dart';
import 'cubit/online_cubit.dart';
import 'cubit/online_state.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  TextEditingController room = TextEditingController();

  @override
  void dispose() {
    room.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnlineCubit, OnlineState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (BuildContext context) {
            return Online();
          },
          condition: OnlineCubit.get(context).isStart == true,
          fallback: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Join Room',
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
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0F2027),
                      Color(0xFF203A43),
                      Color(0xFF2C5364)
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Enter Room Code',
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
                          const SizedBox(height: 40),
                          defaultForm(
                            controller: room,
                            type: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            label: 'Room Code',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon:
                                const Icon(Icons.vpn_key, color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Room Code must not be empty";
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Button3D(
                            text: 'Join Room',
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              OnlineCubit.get(context).joinRoom(room.text);
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
          },
        );
      },
    );
  }
}
