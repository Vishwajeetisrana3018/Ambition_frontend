import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class BasicInfoForm extends StatelessWidget {
  final bool isDriver;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(String) onPhoneNumberChanged;

  const BasicInfoForm({
    super.key,
    required this.isDriver,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onPhoneNumberChanged,
  });

  @override
  Widget build(BuildContext context) {
    final PhoneController phoneNumberController = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.GB, nsn: ''),
    );

    return Column(
      children: [
        // Phone number field
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
          countrySelectorNavigator: CountrySelectorNavigator.bottomSheet(
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

        if (isDriver) ...[
          // Name field
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/name_icon.png',
                  height: 16,
                  color: Colors.black,
                ),
              ),
              hintText: 'Name',
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Email field
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/email_icon.png',
                  height: 16,
                  color: Colors.black,
                ),
              ),
              hintText: 'Email',
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password field
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/password_icon.png',
                  height: 16,
                  color: Colors.black,
                ),
              ),
              hintText: 'Password',
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
        ],
      ],
    );
  }
}
