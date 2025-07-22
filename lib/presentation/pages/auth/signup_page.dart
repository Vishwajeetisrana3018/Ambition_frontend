import 'package:ambition_delivery/data/models/driver_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../bloc/auth_bloc.dart';
import '../../widgets/user_type_selector.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DriverFormData driverFormData = DriverFormData();
  final List<String> _dropdownMenuItems = ['Passenger', 'Driver'];
  String? _selectedItem = 'Passenger';

  final PhoneController phoneNumberController = PhoneController(
    initialValue: const PhoneNumber(isoCode: IsoCode.GB, nsn: ''),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: _handleAuthStateChanges,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return _buildSignupForm(context, state);
            },
          ),
        ),
      ),
    );
  }

  void _handleAuthStateChanges(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    }
    if (state is AuthSuccess) {}

    if (state is UserTempOtpSent) {
      Navigator.pushNamed(context, '/passenger_signup_otp',
          arguments: driverFormData.phoneNumber ?? "");
    } else if (state is DriverTempOtpSent) {
      Navigator.pushNamed(context, '/driver_signup_otp_page',
          arguments: driverFormData);
    }
  }

  Widget _buildSignupForm(BuildContext context, AuthState state) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const SizedBox(height: 12),

            

              const SizedBox(height: 30),

              // === FORM STARTS ===
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    UserTypeSelector(
                      items: _dropdownMenuItems,
                      selectedItem: _selectedItem,
                      onSelected: (value) {
                        setState(() {
                          _selectedItem = value;
                          driverFormData.userType = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    PhoneFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
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
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onChanged: (phone) {
                        driverFormData.phoneNumber =
                            "+${phone.countryCode}${phone.nsn}";
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

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _handleSignUp(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Proceed',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                       SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement Google login
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Google login clicked")));
                  },
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text("Continue with Google"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
                   SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement Email login
                    Navigator.pushNamed(context, '/email_signup_page');
                  },
                  icon: const Icon(Icons.email_outlined, color: Colors.blue),
                  label: const Text("Continue with Email"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUp(BuildContext context) {
    if (_selectedItem == 'Passenger') {
      _handlePassengerSignUp(context);
    } else {
      _handleDriverSignUp(context);
    }
  }

  void _handlePassengerSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = driverFormData.phoneNumber ?? "";
      context
          .read<AuthBloc>()
          .add(SendUserTempOtpEvent(otp: {'phone': phoneNumber}));
    } else {
      context.read<AuthBloc>().add(
          const InvalidFormEvent(message: "Please fill a valid phone number"));
    }
  }

  void _handleDriverSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = driverFormData.phoneNumber ?? "";
      context
          .read<AuthBloc>()
          .add(SendDriverTempOtpEvent(otp: {'phone': phoneNumber}));
    } else {
      context.read<AuthBloc>().add(
          const InvalidFormEvent(message: "Please fill a valid phone number"));
    }
  }
}
