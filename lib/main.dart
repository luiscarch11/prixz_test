import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prixz_test/book/presentation/book_search_page.dart';
import 'package:prixz_test/user/application/user/user_registration_cubit.dart';

import 'initial_bindings.dart';
import 'user/domain/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await InitialBindings.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(getIt<UserRepository>())..requestedUser(),
      child: const MaterialApp(
        title: 'Material App',
        home: BookSearchPage(),
      ),
    );
  }
}
