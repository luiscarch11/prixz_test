import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prixz_test/shared/domain/extensions/datetime_extension.dart';
import 'package:prixz_test/user/application/user/user_registration_cubit.dart';
import 'package:prixz_test/user/domain/gender.dart';

import '../../shared/presentation/color_constants.dart';

class ViewUserPage extends StatelessWidget {
  const ViewUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().user!;
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ColorConstants.primaryColor,
            ),
            width: double.infinity,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'View user data',
                      style: TextStyle(
                        color: ColorConstants.whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListTile(
            title: const Text('Name'),
            subtitle: Text(
              user.name.getOrCrash(),
            ),
          ),
          ListTile(
            title: const Text('Surname'),
            subtitle: Text(
              user.surname.getOrCrash(),
            ),
          ),
          ListTile(
            title: const Text('Email'),
            subtitle: Text(
              user.email.getOrCrash(),
            ),
          ),
          ListTile(
            title: const Text('Phone number'),
            subtitle: Text(
              user.phoneNumber.getOrCrash(),
            ),
          ),
          ListTile(
            title: const Text('Gender'),
            subtitle: Text(
              user.gender.getString,
            ),
          ),
          ListTile(
            title: const Text('Birth date'),
            subtitle: Text(
              user.birthDay.dateAndAgeString,
            ),
          ),
        ],
      ),
    );
  }
}
