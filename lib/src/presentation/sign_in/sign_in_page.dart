import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/core/state.dart';
import '../../logic/user/user_provider.dart';
import '../../logic/user/user_state.dart';
import '../core/utils/snackbar.dart';
import '../core/utils/validator.dart';
import '../core/widgets/coda_logo.dart';
import 'widgets/password_text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: userControllerProvider,
      onChange: _onUserStateChange,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CodaLogo(),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (value) => Validator.validateEmail(value),
                      ),
                      const SizedBox(height: 16),
                      PasswordTextFormField(controller: _passwordController),
                      const SizedBox(height: 32),
                      Consumer(
                        builder: (context, watch, _) {
                          final userState = watch(userControllerProvider);
                          final isLoading = userState is Loading;

                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _signIn,
                              child: isLoading
                                  ? const CircularProgressIndicator.adaptive()
                                  : const Text('Sign in'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onUserStateChange(BuildContext context, UserState userState) {
    if (userState is Error) {
      showErrorSnackBar(context, 'Password is incorrect.');
    }
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      final userController = context.read(userControllerProvider.notifier);
      userController.signIn(_emailController.text, _passwordController.text);
    }
  }
}
