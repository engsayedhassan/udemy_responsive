import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/shop_layout.dart';
import 'package:untitled1/modules/shop_app/register/cubit/cubit.dart';
import 'package:untitled1/modules/shop_app/register/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopRegisterSuccessState) {
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
                          'REgister',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defualtFormField(
                          controller: nameController,
                          type: TextInputType.emailAddress,
                          lable: 'User Name',
                          prefix: Icons.person,
                          textValidate: 'please enter your user name',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defualtFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          lable: 'Email Address',
                          prefix: Icons.email_outlined,
                          textValidate: 'please enter your user email address',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defualtFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          lable: 'Password',
                          prefix: Icons.lock_outlined,
                          sufix: ShopRegisterCubit.get(context).sufix,
                          ispassword: ShopRegisterCubit.get(context).ispassword,
                          sufixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          textValidate: 'password is too short',
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).uesrRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                        defualtFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          lable: 'Phone Number',
                          prefix: Icons.phone,
                          textValidate: 'please enter your user phone number',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defualtButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).uesrRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                              ;
                            },
                            text: 'Register',
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
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
