import 'package:flutter/material.dart';

class TermsAndPolicies extends StatelessWidget {
  const TermsAndPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeading('Terms and Policies'),
            const SizedBox(height: 20),
            _buildSubHeading('1. Booking Process:'),
            _buildPoint(
              ' Users must agree to the terms and conditions outlined in the application before proceeding with booking a ticket.',
            ),
            _buildSubHeading('2. Accuracy of Information:'),
            _buildPoint(
              ' Users are responsible for providing accurate and up-to-date information during the booking process, including personal details and travel preferences.',
            ),
            _buildSubHeading('3. Ticket Availability:'),
            _buildPoint(
              ' Booking of tickets is subject to availability. The application does not guarantee the availability of tickets for all routes and dates.',
            ),
            _buildSubHeading('4. Payment::'),
            _buildPoint(
              ' Users must make payment for the booked tickets through the designated payment methods provided in the application. All payments are non-refundable unless otherwise specified.',
            ),
            _buildSubHeading('5. Cancellation and Refund:'),
            _buildPoint(
              ' Users may cancel their booked tickets subject to the cancellation policy of the respective bus operator. Refunds, if applicable, will be processed according to the cancellation policy and may be subject to cancellation fees.',
            ),
            _buildSubHeading('6. Travel Responsibility:'),
            _buildPoint(
              ' Users are responsible for boarding the bus on time and complying with the rules and regulations of the bus operator during travel.',
            ),
            _buildSubHeading('7. Luggage:'),
            _buildPoint(
              ' Users are responsible for their luggage and must adhere to the luggage policy of the bus operator. The application is not liable for any loss or damage to luggage during travel.',
            ),
            _buildSubHeading('8. Change of Schedule:'),
            _buildPoint(
              ' The bus operator reserves the right to change the schedule, route, or bus type without prior notice. Users will be notified of any changes through the contact information provided during booking.',
            ),
            _buildSubHeading('9. User Conduct:'),
            _buildPoint(
              ' Users must conduct themselves in a respectful manner towards other passengers and bus staff. Any behavior deemed disruptive or inappropriate may result in refusal of service or removal from the bus.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }


  Widget _buildPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Raleway',
          fontSize: 14,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

