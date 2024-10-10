import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/tombola_bloc/tombola_bloc.dart';
import 'package:client/logic/bloc/tombola_bloc/tombola_event.dart';
import 'package:client/logic/bloc/tombola_bloc/tombola_state.dart';

class EnterTombolaPage extends StatelessWidget {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController ticketsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Tombola')),
      body: BlocListener<TombolaBloc, TombolaState>(
        listener: (context, state) {
          if (state is TombolaError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is TombolaEntered) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.result)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: studentIdController,
                decoration: InputDecoration(labelText: 'Student ID'),
              ),
              TextField(
                controller: ticketsController,
                decoration: InputDecoration(labelText: 'Number of Tickets'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TombolaBloc>(context).add(
                    EnterTombolaEvent(
                      studentId: int.parse(studentIdController.text),
                      tickets: int.parse(ticketsController.text),
                    ),
                  );
                },
                child: Text('Enter Tombola'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
