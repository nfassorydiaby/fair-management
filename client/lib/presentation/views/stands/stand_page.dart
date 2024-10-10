import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/stand_bloc/stand_bloc.dart';
import 'package:client/logic/bloc/stand_bloc/stand_event.dart';
import 'package:client/logic/bloc/stand_bloc/stand_state.dart';
import 'stand_form.dart';

class StandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stands'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StandFormPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<StandBloc, StandState>(
        builder: (context, state) {
          if (state is StandLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is StandLoaded) {
            return ListView.builder(
              itemCount: state.stands.length,
              itemBuilder: (context, index) {
                final stand = state.stands[index];
                return ListTile(
                  title: Text(stand.name),
                  subtitle: Text('Stock: ${stand.stock}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StandFormPage(standId: stand.id),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is StandError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
