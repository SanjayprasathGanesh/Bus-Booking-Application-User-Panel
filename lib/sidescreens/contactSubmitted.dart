import 'package:flutter/material.dart';

class ContactSubmitted extends StatefulWidget {
  const ContactSubmitted({super.key});

  @override
  State<ContactSubmitted> createState() => _ContactSubmittedState();
}

class _ContactSubmittedState extends State<ContactSubmitted> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://media.istockphoto.com/id/1319184864/vector/thank-you-vector-lettering-on-tropical-leaves-background-isolated.jpg?s=612x612&w=0&k=20&c=aqyiCtLdkUON3Gs0tR6PJ2R3tfD5ZERD9uS6Q8FYifE='
                  ),
                  fit: BoxFit.fill,
                )
              ),
            ),
            Container(
              margin: EdgeInsets.all(25.0),
              child: const Text('Your Contact Form has been Submitted Successfully, our Executive will Reach You Soon',style: TextStyle(
                color: Colors.blue,
                fontSize: 15.0,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
                textAlign: TextAlign.justify,
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: (){
                  Navigator.pop(context, 1);
                  },
                child: const Text('Back to Home',style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 15.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),)
            )
          ],
        )
      ),
    );
  }
}
