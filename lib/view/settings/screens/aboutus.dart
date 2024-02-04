import 'package:flutter/material.dart';

class AboutUsDialog extends StatelessWidget {
  const AboutUsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About Us'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '''
              About Us

              Welcome to Admin Gardenia, your go-to platform for managing and selling plants with ease. 

              Our mission is to provide plant enthusiasts, sellers, and administrators with a seamless experience in managing plant products, processing orders, and tracking earnings. 

              Key Features:

              - **Plant Management:** Effortlessly add and update plant information including names, images, descriptions, and categories (indoor or outdoor).

              - **Order Processing:** Streamline your order management process, ensuring accurate and timely processing.

              - **Earnings Tracking:** Keep a close eye on your earnings and revenue related to plant sales.

              Admin Gardenia is committed to maintaining the privacy and security of your information. Please refer to our Privacy Policy for more details.

              Contact Us:

              For any inquiries or assistance, please contact us at ansertp47@gmail.com.
              ''',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
