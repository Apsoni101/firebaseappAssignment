import 'package:flutter/material.dart';

class RecaptchaVerification extends StatelessWidget {
  final String siteKey;
  final Function(String) onVerified;

  const RecaptchaVerification({
    super.key,
    required this.siteKey,
    required this.onVerified,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Verify reCAPTCHA'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          const Text("Please verify you are not a robot."),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            final String simulatedToken = 'sample_recaptcha_token';
            onVerified(simulatedToken);
            Navigator.of(context).pop();
          },
          child: const Text('Verify'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
