import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import 'app_shell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotPasswordEmailController = TextEditingController();

  bool isObsecured = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (!mounted) return;

      if (data.event == AuthChangeEvent.signedIn) {
        final authUser = data.session?.user;

        if (authUser != null) {
          final user = AuthService.instance.userFromAuthUser(authUser);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => AppShell(user: user),
            ),
          );
        }
      } else if (data.event == AuthChangeEvent.signedOut) {
        setState(() => isLoading = false);
      }
    });
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : null,
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      final user = await AuthService.instance.signInWithEmail(
        email: identifierController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AppShell(user: user)),
      );
    } on AuthException catch (e) {
      _showMessage(e.message, isError: true);
    } catch (_) {
      _showMessage('Something went wrong. Please try again.', isError: true);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

 Future<void> _showForgotPasswordDialog() async {
  forgotPasswordEmailController.clear();

  // Create a local form key specifically for this dialog
  final dialogFormKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Reset password'),
      content: Form(
        key: dialogFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Fix 2: Changed from TextField to TextFormField to support validation
            TextFormField(
              controller: forgotPasswordEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email address',
                hintText: 'you@example.com',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            if (!dialogFormKey.currentState!.validate()) return;

            final email = forgotPasswordEmailController.text.trim();

            try {
              // Trigger the password reset OTP email
              await AuthService.instance.resetPassword(email);

              if (!dialogContext.mounted) return;
              Navigator.pop(dialogContext); // Close the dialog cleanly

              if (!mounted) return;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyOtpPage(email: email),
                ),
              );
              
            } on AuthException catch (e) {
              if (!dialogContext.mounted) return;
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                SnackBar(
                  content: Text(e.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text('Send email'),
        ),
      ],
    ),
  );
}


  Future<void> _handleGoogleSignIn() async {
    setState(() => isLoading = true);

    try {
      await AuthService.instance.signInWithGoogle();
    } on AuthException catch (e) {
      _showMessage(e.message, isError: true);

      if (mounted) {
        setState(() => isLoading = false);
      }
    } catch (e) {
      _showMessage(
        'Google sign-in failed: $e',
        isError: true,
      );

      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    identifierController.dispose();
    passwordController.dispose();
    forgotPasswordEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,             
                  MaterialPageRoute(builder: (_) => AppShell(),
                  ),),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const SizedBox(height: 4),
            // Logo
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: red,
                    child: Icon(
                      Icons.monitor_heart_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'RapidPulse MY',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Welcome back text
            const Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Log in to track live crowding & delays on your commute.',
              style: TextStyle(color: Color(0xFF8993A2), fontSize: 12),
            ),

            const SizedBox(height: 17),

            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email field
                  TextFormField(
                    controller: identifierController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.mail_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email/Username is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 11),

                  // Password field
                  TextFormField(
                    controller: passwordController,
                    obscureText: isObsecured,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => isObsecured = !isObsecured),
                        icon: Icon(
                          isObsecured
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Forgot password button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _showForgotPasswordDialog,
                      style: TextButton.styleFrom(
                        foregroundColor: red,
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Forgot Password?'),
                    ),
                  ),

                  // Log in button
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: red,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () {
                            _handleLogin();
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Log In'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),

            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'or continue with',
                    style: TextStyle(fontSize: 10, color: Color(0xFF9DA5B1)),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 10),

            // Continue with Google button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(42),
                side: const BorderSide(color: Color(0xFFE9EAED)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              onPressed: _handleGoogleSignIn,
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
              label: const Text(
                'Continue with Google',
                style: TextStyle(
                  color: navy,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 12, color: Color(0xFF8993A2)),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: red,
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    ),
  );
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Regular expression pattern for strict email format validation
  final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  bool isObsecured = true;
  bool isLoading = false;

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : null,
      ),
    );
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final result = await AuthService.instance.signUp(
        username: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
      );

      if (!mounted) return;

      if (result.emailConfirmationRequired) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Account created! Check your email to confirm before logging in.'),
                backgroundColor: Colors.green.shade700
              ),
           );    
        Navigator.pop(context);
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AppShell(user: result.user)),
      );
    } on AuthException catch (e) {
      _showMessage(e.message, isError: true);
    } catch (_) {
      _showMessage('Something went wrong. Please try again.', isError: true);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (Navigator.canPop(context))
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Create account',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Join RapidPulse MY to commute smarter, every day.',
              style: TextStyle(color: Color(0xFF8993A2), fontSize: 12),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                //Login Form
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter username',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 11),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.mail_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!_emailRegExp.hasMatch(value.trim())) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 11),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone, 
                        decoration: InputDecoration(
                          prefixText: '+60 ',
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone_android_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          final phoneRegex = RegExp(r'^\d{9,10}$');
                          if (!phoneRegex.hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 11),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isObsecured,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => isObsecured = !isObsecured),
                            icon: Icon(
                              isObsecured
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10),

                      // Confirm password field
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: isObsecured,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => isObsecured = !isObsecured),
                            icon: Icon(
                              isObsecured
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm password is required';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10),

                      // Terms and conditions
                      FormField<bool>(
                        initialValue: false,
                        validator: (value) {
                          if (value != true) {
                            return 'You must accept the terms to proceed.';
                          }
                          return null;
                        },
                        builder: (state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'I agree to the Terms and Conditions',
                                ),
                                value: state.value ?? false,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (value) {
                                  state.didChange(value);
                                },
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    state.errorText!,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 16),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: red,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: isLoading ? null : () {
                          _handleSignUp();
                        },
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Create Account'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //SignUp Page Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 10, color: Color(0xFF8993A2)),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: red,
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Log In'),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    ),
  );
}

class   VerifyOtpPage extends StatefulWidget {
  final String email;
  
  const VerifyOtpPage({super.key, required this.email});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool isObsecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Center(
        child: 
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Enter the OTP sent to ${widget.email}'),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'OTP',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the OTP';
                      }
                      if (value.length != 6) {
                        return 'OTP must be 6 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: isObsecured,
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                      onPressed: () =>
                        setState(() => isObsecured = !isObsecured),
                        icon: Icon(
                          isObsecured
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle OTP verification and password reset here
                        final otp = otpController.text.trim();
                        final newPassword = newPasswordController.text.trim();
                        AuthService.instance.verifyOtpAndSetPassword(
                          email: widget.email,
                          token: otp,
                          newPassword: newPassword,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Account created! Check your email to confirm before logging in.'),
                              backgroundColor: Colors.green.shade700
                            ),
                        ); 
                        Navigator.pop(context); // Go back to login screen after successful reset
                      }
                    },
                    child: const Text('Verify OTP'),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}