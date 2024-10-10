import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/token_bloc/token_bloc.dart';
import 'package:client/logic/bloc/token_bloc/token_event.dart';
import 'package:client/logic/bloc/token_bloc/token_state.dart';

class BuyTokensPage extends StatelessWidget {
  final TextEditingController parentIdController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buy Tokens')),
      body: BlocListener<TokenBloc, TokenState>(
        listener: (context, state) {
          if (state is TokensBought) {
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
              TextField(controller: amountController, decoration: InputDecoration(labelText: 'Amount')),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TokenBloc>(context).add(BuyTokensEvent(
                    parentId: int.parse(parentIdController.text),
                    amount: int.parse(amountController.text),
                  ));
                },
                child: Text('Buy Tokens'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
