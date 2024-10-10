import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/tombola_bloc/tombola_bloc.dart';
import 'package:client/logic/bloc/tombola_bloc/tombola_event.dart';
import 'package:client/logic/bloc/tombola_bloc/tombola_state.dart';

class DrawTombolaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Draw Tombola')),
      body: BlocListener<TombolaBloc, TombolaState>(
        listener: (context, state) {
          if (state is TombolaError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is TombolaWinner) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.result)));
          }
        },
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<TombolaBloc>(context).add(DrawTombolaEvent());
            },
            child: Text('Draw Winner'),
          ),
        ),
      ),
    );
  }
}
