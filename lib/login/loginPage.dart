import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../homePage.dart';
import 'login_validator.dart';

class LoginPage extends ConsumerWidget {
  final loadingStateProvider =
      StateProvider<LoginState>((ref) => LoginState.logininit);

  loginValidator validator = loginValidator();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var value = ref.watch(loadingStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('riverpod'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: username,
              decoration: const InputDecoration(
                hintText: 'Username',
                labelText: '',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: password,
              decoration: const InputDecoration(
                hintText: 'Password',
                labelText: '',
              ),
            ),
          ),
          value == LoginState.loading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    ref.read(loadingStateProvider.notifier).state =
                        LoginState.loading;
                    Future.delayed(Duration(seconds: 2), () async {
                      ref.read(loadingStateProvider.notifier).state =
                          await validator.validate(
                              username.text, password.text, context);
                      print(ref.watch(loadingStateProvider));
                      ref.watch(loadingStateProvider) ==
                              LoginState.loginsuccessful
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ))
                          : null;
                    });
                  },
                  child: Text("Login")),
        ],
      )),
    );
  }
}
