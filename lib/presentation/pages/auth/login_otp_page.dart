import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import '../../bloc/auth_bloc.dart';

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage(
      {super.key, required this.phoneNumber, required this.userType});
  final String phoneNumber;
  final String userType;

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthSuccess) {
          if (widget.userType == 'Passenger') {
            Navigator.pushNamedAndRemoveUntil(
                context, '/passenger_home', (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/driver_home', (route) => false);
          }
        } else if (state is UserLoginOtpResent ||
            state is DriverLoginOtpResent) {
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      }, builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter the OTP sent to your phone number',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                // Pinput for OTP
                Pinput(
                  controller: otpController,
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onCompleted: (otp) {
                    // Handle OTP completion if needed
                  },
                ),
                const SizedBox(height: 16),
                // Verify OTP Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (otpController.text.isEmpty ||
                          otpController.text.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid OTP'),
                          ),
                        );
                        return;
                      }
                      if (widget.userType == 'Passenger') {
                        context
                            .read<AuthBloc>()
                            .add(VerifyUserLoginOtpEvent(otp: {
                              'phone': widget.phoneNumber,
                              'otp': otpController.text,
                            }));
                      } else {
                        context
                            .read<AuthBloc>()
                            .add(VerifyDriverLoginOtpEvent(otp: {
                              'phone': widget.phoneNumber,
                              'otp': otpController.text,
                            }));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Verify OTP',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Haven't received OTP? ",
                    ),

                    // Resend OTP Button
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        if (widget.userType == 'Passenger') {
                          context.read<AuthBloc>().add(ResendUserLoginOtpEvent(
                                otp: {
                                  'phone': widget.phoneNumber,
                                },
                              ));
                        } else {
                          context
                              .read<AuthBloc>()
                              .add(ResendDriverLoginOtpEvent(
                                otp: {
                                  'phone': widget.phoneNumber,
                                },
                              ));
                        }
                      },
                      child: const Text(
                        "Resend OTP",
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
