import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ's",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FAQItem(
              question: 'How can I book a Ticket?',
              answer:
              'In the Home page, users can search for buses by providing the source and destination. If buses are available, a list of options will be displayed. Users can then select their preferred bus operator, choose a seat based on availability, provide passenger details, make payment, and confirm their booked seat. After confirmation, users can download the e-ticket and view their booked ticket in the My Bookings page.',
            ),
            FAQItem(
              question: 'Can I track the bus which i have booked',
              answer:
              'Yes, but this is a beta version, withing next few updates, the tracking will also be available. ',
            ),
            FAQItem(
              question: 'How do I get my refund for cancelling ticket',
              answer:
              'The refund amount will be credited to your wallet in our app withing 24 working hrs',
            ),
            FAQItem(
              question: 'How to utify the amount in my wallet',
              answer:
              'You can able to use the wallet amount for your upcoming journeys',
            ),
            FAQItem(
                question: 'Who Developed this App?',
                answer: 'This App was developed by a College Student named Sanjay Prasath Ganesh.'
            ),
            FAQItem(
                question: 'What was the Total Time Period for Deploying this App ? ',
                answer: 'This App took 2 month for Development'
            ),
            FAQItem(
                question: 'When this App was Released',
                answer: 'On March 01 2024'
            ),
            FAQItem(
                question: 'When will the stable version be Released?',
                answer: 'Expected to Release it in the next Year mid (2024)'
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Raleway',
          fontSize: 17.0,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer,style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Raleway',
            fontSize: 15.0,
          ),),
        ),
      ],
    );
  }
}
