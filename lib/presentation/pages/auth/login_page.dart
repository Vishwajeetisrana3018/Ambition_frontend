import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../bloc/auth_bloc.dart';
import '../../widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final PhoneController phoneNumberController = PhoneController(
    initialValue: const PhoneNumber(isoCode: IsoCode.GB, nsn: ''),
  );

  String? phoneNumber;
  void onPhoneNumberChanged(String value) {
    setState(() {
      phoneNumber = value;
    });
  }

  final List<String> _dropdownMenuItems = ['Passenger', 'Driver'];
  String? _selectedItem = 'Passenger';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is UserLoginOtpSent || state is DriverLoginOtpSent) {
          Navigator.pushNamed(context, '/login_otp_page', arguments: {
            'phone_number': phoneNumber,
            'user_type': _selectedItem,
          });
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is AuthUserDisabledError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User is disabled"),
            ),
          );
        } else if (state is AuthUserNotFoundError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User not found"),
            ),
          );
        } else if (state is AuthDriverDisabledError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Driver is disabled"),
            ),
          );
        } else if (state is AuthDriverNotFoundError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Driver not found"),
            ),
          );
        }
      }, builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                // Logo
                Image.asset(
                  'assets/app_icon.png',
                  height: 120,
                ),
                const Text(
                  'Move with Ambition',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                DropdownMenu<String>(
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.white,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      elevation: WidgetStateProperty.all(4),
                    ),
                    textStyle: const TextStyle(),
                    initialSelection: _selectedItem,
                    onSelected: (String? value) {
                      setState(() {
                        _selectedItem = value;
                      });
                    },
                    dropdownMenuEntries: _dropdownMenuItems.map((String item) {
                      return DropdownMenuEntry<String>(
                        value: item,
                        label: item,
                      );
                    }).toList()),
                const SizedBox(height: 20),
                // Email TextField
                PhoneFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(width: 1.0),
                    ),
                  ),
                  validator: PhoneValidator.compose([
                    PhoneValidator.required(context,
                        errorText: 'Phone Number is required'),
                    PhoneValidator.validMobile(context,
                        errorText: 'Phone Number is invalid')
                  ]),
                  countrySelectorNavigator:
                      CountrySelectorNavigator.bottomSheet(
                    searchBoxDecoration: InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 1.0),
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  onChanged: (phone) {
                    onPhoneNumberChanged("+${phone.countryCode}${phone.nsn}");
                  },
                  enabled: true,
                  isCountrySelectionEnabled: true,
                  isCountryButtonPersistent: true,
                  countryButtonStyle: const CountryButtonStyle(
                    showDialCode: true,
                    showFlag: true,
                    flagSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                // Login Button
                LoginButton(
                  onPressed: () {
                    if (_selectedItem == 'Passenger') {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SendUserLoginOtpEvent(
                              otp: {
                                'phone': phoneNumber,
                              },
                            ));
                      } else {
                        context.read<AuthBloc>().add(const InvalidFormEvent(
                            message: "Please enter a valid phone number"));
                      }
                    } else {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SendDriverLoginOtpEvent(
                              otp: {
                                'phone': phoneNumber,
                              },
                            ));
                      } else {
                        context.read<AuthBloc>().add(const InvalidFormEvent(
                            message: "Please enter a valid phone number"));
                      }
                    }
                  },
                ),
                const SizedBox(height: 16),
                // Forgot Password Link

                // Create Account Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/signup', (route) => false);
                      },
                      child: const Text(
                        "Create Account",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}
