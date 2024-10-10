import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/parent_bloc/parent_bloc.dart';
import 'package:client/logic/bloc/parent_bloc/parent_event.dart';
import 'package:client/logic/bloc/parent_bloc/parent_state.dart';

class ParentPage extends StatelessWidget {
  final int parentId;

  ParentPage({required this.parentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parent Details')),
      body: BlocProvider(
        create: (context) => ParentBloc(parentRepository: context.read())..add(FetchChildren(parentId: parentId)),
        child: BlocBuilder<ParentBloc, ParentState>(
          builder: (context, state) {
            if (state is ParentLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ParentLoaded) {
              return ListView.builder(
                itemCount: state.parent.children.length,
                itemBuilder: (context, index) {
                  final child = state.parent.children[index];
                  return ListTile(
                    title: Text(child.name),
                    subtitle: Text('Tokens: ${child.tokens}'),
                  );
                },
              );
            } else if (state is ParentError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
