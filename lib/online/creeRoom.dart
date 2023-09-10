import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoefir/online/online.dart';
import 'package:tictactoefir/shared/button.dart';

import 'cubit/online_cubit.dart';
import 'cubit/online_state.dart';

class CreeRoom extends StatefulWidget {
  const CreeRoom({super.key});

  @override
  State<CreeRoom> createState() => _CreeRoomState();
}

class _CreeRoomState extends State<CreeRoom> {
  @override
  void initState() {
    // TODO: implement initState
    OnlineCubit.get(context).getRandom();
    OnlineCubit.get(context).creeRoom();

    super.initState();
  }

  Widget build(BuildContext context) {
    Button3d b1 = Button3d(
      onTap: () {},
      text: const Text(
        'Your Room Id is :',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
    );
    Button3d b2 = Button3d(
      onTap: () {
        // OnlineCubit.get(context).getRandom();
        OnlineCubit.get(context).changeRoomId();
      },
      text: const Text(
        'Change the Number',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
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
                    OnlineCubit.get(context).endGameReset();
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
                      const SizedBox(
                        height: 20,
                      ),
                      b1,
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${OnlineCubit.get(context).id}',
                        style: const TextStyle(
                          fontSize: 30,
                          letterSpacing: 6,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      b2
                    ],
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
