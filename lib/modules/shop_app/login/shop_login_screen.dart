import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/shop_layout.dart';
import 'package:untitled1/modules/shop_app/login/cubit/cubit.dart';
import 'package:untitled1/modules/shop_app/login/cubit/states.dart';
import 'package:untitled1/modules/shop_app/register/shop_register_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              print('sssssaaaayyyyeeeeeeddddd');
              print('status = ${state.loginModel.status}');
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token=state.loginModel.data!.token;
                navigateAndFinish(
                    context,
                    ShopLayout(),
                  );
              });
            } else {
              print(state.loginModel.message);
              print('hhhhhhhaaaaammmmoooodddddddaaaaa');
              print('status = ${state.loginModel.status}');
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
            ;
          }
          ;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defualtFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          lable: 'Email Address',
                          prefix: Icons.email_outlined,
                          textValidate: 'please enter your email address',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defualtFormField(
                          controller: passwordController,
                          type: TextInputType.emailAddress,
                          lable: 'Password',
                          prefix: Icons.lock_outlined,
                          sufix: ShopLoginCubit.get(context).sufix,
                          ispassword: ShopLoginCubit.get(context).ispassword,
                          sufixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          textValidate: 'password is too short',
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).uesrLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defualtButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).uesrLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                              ;
                            },
                            text: 'login',
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defualtTextButton(
                              function: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
