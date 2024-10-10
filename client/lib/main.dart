import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/logic/bloc/auth_bloc/auth_bloc.dart';
import 'package:client/logic/bloc/stand_bloc/stand_bloc.dart';
import 'package:client/logic/bloc/parent_bloc/parent_bloc.dart';
import 'package:client/logic/bloc/token_bloc/token_bloc.dart';
import 'package:client/logic/bloc/tombola_bloc/tombola_bloc.dart';

import './data/repositories/auth_repository.dart';
import './data/repositories/stand_repository.dart';
import './data/repositories/parent_repository.dart';
import './data/repositories/token_repository.dart';
import './data/repositories/tombola_repository.dart';

// Auth Pages
import './presentation/views/auth/register_page.dart';
import './presentation/views/auth/login_page.dart';
import './presentation/views/auth/users_page.dart';

// Stand Pages
import './presentation/views/stands/stand_form.dart';
import './presentation/views/stands/stand_page.dart';

// Parent & Children Pages
import './presentation/views/pages/children_page.dart';
import './presentation/views/pages/parent_page.dart';

// Token Pages
import './presentation/views/token/buy_tokens_page.dart';
import './presentation/views/token/distribute_tokens_page.dart';

// Tombola Pages
import './presentation/views/tombola/draw_tombola_page.dart';
import './presentation/views/tombola/enter_tombola_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initializing repositories
    final AuthRepository authRepository = AuthRepository();
    final StandRepository standRepository = StandRepository();
    final ParentRepository parentRepository = ParentRepository();
    final TokenRepository tokenRepository = TokenRepository();
    final TombolaRepository tombolaRepository = TombolaRepository();

    return MultiBlocProvider(
      providers: [
        // Auth Bloc
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        // Stand Bloc
        BlocProvider<StandBloc>(
          create: (context) => StandBloc(standRepository: standRepository),
        ),
        // Parent Bloc
        BlocProvider<ParentBloc>(
          create: (context) => ParentBloc(parentRepository: parentRepository),
        ),
        // Token Bloc
        BlocProvider<TokenBloc>(
          create: (context) => TokenBloc(tokenRepository: tokenRepository),
        ),
        // Tombola Bloc
        BlocProvider<TombolaBloc>(
          create: (context) => TombolaBloc(tombolaRepository: tombolaRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Fair Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/parent') {
            final parentId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) {
                return ParentPage(parentId: parentId);
              },
            );
          }
          return null; // Handle other routes if necessary
        },
        routes: {
          '/': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/users': (context) => UserPage(),
          '/stands': (context) => StandPage(),
          '/add-stand': (context) => StandFormPage(),
          '/children': (context) => ChildrenPage(),
          '/buy-tokens': (context) => BuyTokensPage(),
          '/distribute-tokens': (context) => DistributeTokensPage(),
          '/enter-tombola': (context) => EnterTombolaPage(),
          '/draw-tombola': (context) => DrawTombolaPage(),
        },
      ),
    );
  }
}
