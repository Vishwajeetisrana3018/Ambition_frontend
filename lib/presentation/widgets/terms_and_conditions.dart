import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditions extends StatelessWidget {
  final bool isChecked;
  final Function(bool) onChanged;

  const TermsAndConditions({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          activeColor: Colors.blue,
        ),
        const Text('I agree to the '),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () async {
            final url = Uri.parse(
                'https://app.termly.io/policy-viewer/policy.html?policyUUID=a50e99f6-911b-4b9c-92b8-33b3125bb29d');

            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
          child: const Text(
            'Terms and Conditions',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
