import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoefir/online/online.dart';
import 'package:tictactoefir/shared/button.dart';

import '../shared/components/components.dart';
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
  void initState() {
    // TODO: implement initState
    // room.dispose();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    room.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Button3d b1 = Button3d(
      onTap: () {},
      text: const Text(
        'Room Code To Join :',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
    );
    Button3d b2 = Button3d(
      text: const Text(
        'Donne',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        OnlineCubit.get(context).joinRoom(room.text);
      },
    );
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
                leading: MaterialButton(
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // OnlineCubit.get(context).endGameReset();
                    // OnlineCubit.get(context).id = null;
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        b1,
                        const SizedBox(
                          height: 30,
                        ),
                        defaultForm(
                            controller: room,
                            type: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            label: 'Room',
                            prefixIcon: const Icon(Icons.home),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Room Must Be Not Empty";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        b2
                      ],
                    ),
                  )),
            );
          },
        );
      },
    );
  }
}
