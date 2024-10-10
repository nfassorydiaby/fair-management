import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/token_bloc/token_bloc.dart';
import 'package:client/logic/bloc/token_bloc/token_event.dart';
import 'package:client/logic/bloc/token_bloc/token_state.dart';

class DistributeTokensPage extends StatelessWidget {
  final TextEditingController parentIdController = TextEditingController();
  final TextEditingController childIdController = TextEditingController();
  final TextEditingController tokenCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Distribute Tokens')),
      body: BlocListener<TokenBloc, TokenState>(
        listener: (context, state) {
          if (state is TokensDistributed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.result)));
          } else if (state is TokenError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(controller: parentIdController, decoration: InputDecoration(labelText: 'Parent ID')),
              TextField(controller: childIdController, decoration: InputDecoration(labelText: 'Child ID')),
              TextField(controller: tokenCountController, decoration: InputDecoration(labelText: 'Token Count')),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TokenBloc>(context).add(DistributeTokensEvent(
                    parentId: int.parse(parentIdController.text),
                    childId: int.parse(childIdController.text),
                    tokenCount: int.parse(tokenCountController.text),
                  ));
                },
                child: Text('Distribute Tokens'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
