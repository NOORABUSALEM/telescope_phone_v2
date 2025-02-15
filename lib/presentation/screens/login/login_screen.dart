import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/styles/color_constants.dart';
import '../../../data/cubits/login_cubit/login_cubit.dart';
import '../../../data/cubits/login_cubit/login_state.dart';
import '../../components/customTextField.dart';
import '../../components/primary_button.dart';
import '../../routers/app_routes.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/Asset11.png',
                width: 300,
              ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                  text:  TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Tele',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold ,color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? AppColors.darkTextColor
                            : AppColors.lightTextColor,)),
                    const TextSpan(
                        text: 'Scope',
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.sideMenuIconsColor))
                  ])),
              const SizedBox(height: 16),
              CustomTextField(label: 'email', controller: emailController),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'password',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) async {
                  if (state is LoginSuccess) {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                    print('Login Success: ${state.user.name}');
                  } else if (state is LoginFailure) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const CircularProgressIndicator();
                  }
                  return PrimaryButton(
                    label: "login",
                    onPressed: () {
                      context.read<LoginCubit>().login(
                            emailController.text,
                            passwordController.text,
                          );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
