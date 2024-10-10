import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/auth_bloc/auth_bloc.dart';
import 'package:client/logic/bloc/auth_bloc/auth_event.dart';
import 'package:client/logic/bloc/auth_bloc/auth_state.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  trailing: Text(user['role']),
                );
              },
            );
          } else if (state is AuthFailure) {
            return Center(child: Text('Failed to load users: ${state.message}'));
          }

          return Center(child: Text('No users found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(FetchUsersEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
