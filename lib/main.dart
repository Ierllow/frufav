import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/bloc/snack_bar_bloc.dart';
import 'package:frufav/screen/fruits_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'frufav',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          BlocProvider<SnackBarBloc>(
            create: (context) => SnackBarBloc(),
          ),
          BlocListener<SnackBarBloc, SnackBarState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) =>
                ScaffoldMessenger.of(context).showSnackBar(state.snackBar!),
          )
        ],
        child: const FruitsListScreen(),
      ),
    );
  }
}
