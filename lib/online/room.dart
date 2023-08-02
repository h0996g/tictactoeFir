import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoefir/online/online.dart';
import 'package:tictactoefir/shared/button.dart';

import '../shared/components/components.dart';
import 'cubit/online_cubit.dart';
import 'cubit/online_state.dart';

class Room extends StatelessWidget {
  Room({super.key});
  final room = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // OnlineCubit.get(context)
    //     .lisnerStartGame(OnlineCubit.get(context).id.toString());
    return BlocConsumer<OnlineCubit, OnlineState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
          child: ConditionalBuilder(
            builder: (BuildContext context) {
              return Online();
            },
            condition:
                //  false,
                OnlineCubit.get(context).isStart == true,
            //  false,
            // OnlineCubit.get(context).allcase!['wating'] != null,
            //     OnlineCubit.get(context).allcase!['wating'] == true,
            fallback: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  leading: MaterialButton(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      OnlineCubit.get(context).id = null;
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                  onPressed: () {
                                    if (OnlineCubit.get(context).id != null) {
                                      return;
                                    }
                                    OnlineCubit.get(context).getRandom();
                                    OnlineCubit.get(context).creeRoom();
                                  },
                                  child: const Text("Cree Room")),
                              Button3d(
                                  text: Text(
                                      '${OnlineCubit.get(context).id ?? ""}'))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("OR"),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Room Code To Join"),
                          const SizedBox(
                            height: 10,
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
                            height: 10,
                          ),
                          Button3d(
                            text: const Text('Donne'),
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              OnlineCubit.get(context).joinRoom(room.text);
                              // if (OnlineCubit.get(context).allcase!['wating']) {
                              //   navigatAndFinish(context: context, page: Online());
                              // } else {
                              //   null;
                              // }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // MaterialButton(
                          //   onPressed: () {
                          //     OnlineCubit.get(context).testUpdat();
                          //   },
                          //   child: const Text("test"),
                          // )
                        ],
                      ),
                    )),
              );
            },
          ),
        );
      },
    );
  }
}
