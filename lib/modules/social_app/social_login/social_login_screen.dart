import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/social_app/social_register/social_register_screen.dart';
import 'package:untitled1/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          };
        },
        builder: (context,state){
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
                          'Login now to communicate with friends',
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
                          sufix: SocialLoginCubit.get(context).sufix,
                          ispassword: SocialLoginCubit.get(context).ispassword,
                          sufixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          textValidate: 'password is too short',
                         /* onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).uesrLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },*/
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defualtButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).uesrLogin(
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
                                navigateTo(context, SocialRegisterScreen());
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
