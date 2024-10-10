import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/stand_bloc/stand_bloc.dart';
import 'package:client/logic/bloc/stand_bloc/stand_event.dart';
import 'package:client/logic/bloc/stand_bloc/stand_state.dart';

class StandFormPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final int? standId;

  StandFormPage({this.standId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(standId == null ? 'Add Stand' : 'Update Stand'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Stand Name'),
            ),
            TextField(
              controller: stockController,
              decoration: InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text;
                final int stock = int.tryParse(stockController.text) ?? 0;

                if (standId == null) {
                  BlocProvider.of<StandBloc>(context)
                      .add(AddStandEvent(name: name, stock: stock));
                } else {
                  BlocProvider.of<StandBloc>(context).add(UpdateStandEvent(
                    standId: standId!,
                    name: name,
                    stock: stock,
                  ));
                }
              },
              child: Text(standId == null ? 'Add Stand' : 'Update Stand'),
            ),
            BlocBuilder<StandBloc, StandState>(
              builder: (context, state) {
                if (state is StandLoading) {
                  return CircularProgressIndicator();
                } else if (state is StandAdded) {
                  return Text('Stand added successfully!');
                } else if (state is StandUpdated) {
                  return Text('Stand updated successfully!');
                } else if (state is StandError) {
                  return Text(state.message, style: TextStyle(color: Colors.red));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
