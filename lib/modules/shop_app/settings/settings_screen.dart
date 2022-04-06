import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/cubit.dart';
import 'package:untitled1/layout/shop_app/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/components/constants.dart';

class SettingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  defualtFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    textValidate: 'name must not be empty',
                    lable: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 20),
                  defualtFormField(
                    controller: emailController,
                    type: TextInputType.name,
                    textValidate: 'email must not be empty',
                    lable: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(height: 20),
                  defualtFormField(
                    controller: phoneController,
                    type: TextInputType.name,
                    textValidate: 'phone must not be empty',
                    lable: 'Phone',
                    prefix: Icons.phone,
                  ),
                  SizedBox(height: 20),
                  defualtButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).UpdateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                      ;
                    },
                    text: 'Update',
                  ),
                  SizedBox(height: 20),
                  defualtButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'LogOut'),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
