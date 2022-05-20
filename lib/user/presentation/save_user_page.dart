import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prixz_test/shared/domain/extensions/datetime_extension.dart';
import 'package:prixz_test/shared/presentation/color_constants.dart';
import 'package:prixz_test/shared/presentation/rounded_button.dart';
import 'package:prixz_test/shared/presentation/text_field_widget.dart';
import 'package:prixz_test/user/application/user/user_registration_cubit.dart';
import 'package:prixz_test/user/presentation/view_user_page.dart';

import '../domain/gender.dart';

class SaveUserPage extends StatelessWidget {
  const SaveUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserCubit, UserState>(
        listenWhen: (previous, current) => previous.userOrFailure != current.userOrFailure,
        listener: (context, state) {
          state.userOrFailure.maybeWhen(
            orElse: () {},
            isFailure: (f) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  f.map(
                    unknownError: (_) => 'Unknown error',
                  ),
                ),
              ),
            ),
            isSuccess: (_) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const ViewUserPage(),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Save User',
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
            BlocBuilder<UserCubit, UserState>(
              buildWhen: (previous, current) =>
                  (previous.shouldValidate != current.shouldValidate) || (previous.name != current.name),
              builder: (context, state) {
                return _FieldWidget(
                  hintText: 'Your full name',
                  onChanged: context.read<UserCubit>().changedNameValue,
                  shouldValidate: state.shouldValidate,
                  validationResult: state.name.validationResult,
                );
              },
            ),
            const SizedBox(height: 8),
            BlocBuilder<UserCubit, UserState>(
              buildWhen: (previous, current) =>
                  (previous.shouldValidate != current.shouldValidate) || (previous.surname != current.surname),
              builder: (context, state) {
                return _FieldWidget(
                  hintText: 'Your full surname',
                  onChanged: context.read<UserCubit>().changedSurnameValue,
                  shouldValidate: state.shouldValidate,
                  validationResult: state.surname.validationResult,
                );
              },
            ),
            const SizedBox(height: 8),
            BlocBuilder<UserCubit, UserState>(
              buildWhen: (previous, current) =>
                  (previous.shouldValidate != current.shouldValidate) || (previous.phoneNumber != current.phoneNumber),
              builder: (context, state) {
                return _FieldWidget(
                  hintText: 'Your phone number',
                  onChanged: context.read<UserCubit>().changedPhoneNumber,
                  shouldValidate: state.shouldValidate,
                  validationResult: state.phoneNumber.validationResult,
                );
              },
            ),
            const SizedBox(height: 8),
            BlocBuilder<UserCubit, UserState>(
              buildWhen: (previous, current) =>
                  (previous.shouldValidate != current.shouldValidate) || (previous.email != current.email),
              builder: (context, state) {
                return _FieldWidget(
                  hintText: 'Your email',
                  onChanged: context.read<UserCubit>().changedEmail,
                  shouldValidate: state.shouldValidate,
                  validationResult: state.email.validationResult,
                );
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<UserCubit, UserState>(
                buildWhen: (previous, current) =>
                    (previous.shouldValidate != current.shouldValidate) || (previous.birthDay != current.birthDay),
                builder: (context, state) {
                  return Row(
                    children: [
                      Text(
                        state.birthDay.dateAndAgeString,
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: state.birthDay,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            context.read<UserCubit>().changedBirthDay(date);
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Gender',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<UserCubit, UserState>(
                buildWhen: (previous, current) => (previous.gender != current.gender),
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text('Male'),
                          Radio<Gender>(
                            fillColor: MaterialStateProperty.all<Color>(ColorConstants.textColor),
                            value: Gender.male,
                            groupValue: state.gender,
                            onChanged: (value) => value == null ? null : context.read<UserCubit>().changedGender(value),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Female'),
                          Radio<Gender>(
                            fillColor: MaterialStateProperty.all<Color>(ColorConstants.textColor),
                            value: Gender.female,
                            groupValue: state.gender,
                            onChanged: (value) => value == null ? null : context.read<UserCubit>().changedGender(value),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Other'),
                          Radio<Gender>(
                            fillColor: MaterialStateProperty.all<Color>(ColorConstants.textColor),
                            value: Gender.other,
                            groupValue: state.gender,
                            onChanged: (value) => value == null ? null : context.read<UserCubit>().changedGender(value),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Center(
              child: BlocBuilder<UserCubit, UserState>(
                buildWhen: (previous, current) =>
                    (previous.saveUserFailureOrSuccess != current.saveUserFailureOrSuccess),
                builder: (context, state) {
                  return RoundedButton(
                    isLoading: state.saveUserFailureOrSuccess.isLoading,
                    onPressed: context.read<UserCubit>().submittedButton,
                    text: 'Save',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldWidget extends StatelessWidget {
  const _FieldWidget({
    Key? key,
    required this.hintText,
    required this.shouldValidate,
    required this.onChanged,
    this.validationResult,
  }) : super(key: key);
  final String hintText;
  final bool shouldValidate;
  final ValueChanged<String> onChanged;
  final String? validationResult;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFieldWidget(
        hintText: hintText,
        onChanged: onChanged,
        shouldValidate: shouldValidate,
        validator: (_) => validationResult,
      ),
    );
  }
}
