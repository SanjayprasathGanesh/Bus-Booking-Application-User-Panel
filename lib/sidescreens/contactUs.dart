import 'package:flutter/material.dart';
import 'package:redbus/database/busService.dart';
import 'package:redbus/models/contactusModel.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contactSubmitted.dart';

class ContactUs extends StatefulWidget {
  final String uEmail;
  const ContactUs({Key? key, required this.uEmail}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  TextEditingController date = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController sub = TextEditingController();
  TextEditingController content = TextEditingController();

  bool validateDate = false, validateEmail = false, validateDay = false, validateSub = false, validateContent = false;
  List<String> days = ['','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];


  selectDate() async{
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year+1),
    );

    if(selected != null){
      setState(() {
        date.text = selected.toString().split(" ")[0];
        day.text = days[selected.weekday];
      });
    }
  }

  @override
  initState(){
    super.initState();
    email.text = widget.uEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us",style: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        label: const Text("Select The Date",style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),),
                        errorText: validateDate ? 'Empty To Date Field' : null,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            )
                        ),
                      ),
                      controller: date,
                      readOnly: true,
                      onTap: (){
                        selectDate();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        label: const Text("Select the Day",style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),),
                        errorText: validateDay ? 'Empty To Day Field' : null,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            )
                        ),
                      ),
                      controller: day,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Enter the E-mail",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                  ),),
                  errorText: validateEmail ? 'Empty To EMail Field' : null,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      )
                  ),
                ),
                controller: email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Enter the Subject",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                  ),),
                  errorText: validateSub ? 'Empty To Subject Field' : null,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      )
                  ),
                ),
                controller: sub,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Enter the Content",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                  ),),
                  errorText: validateContent ? 'Empty Content Field' : null,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      )
                  ),
                ),
                controller: content,
                keyboardType: TextInputType.text,
                maxLines: 5,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: (){
                        setState(() {
                          date.clear();
                          day.clear();
                          email.clear();
                          content.clear();
                          sub.clear();
                        });
                      },
                      child: const Text("Clear",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                      ),)
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: (){
                        setState(() {
                          validateDate = date.text.isEmpty;
                          validateDay = day.text.isEmpty;
                          validateEmail = email.text.isEmpty;
                          validateSub = sub.text.isEmpty;
                          validateContent = content.text.isEmpty;
                        });

                        ToastContext().init(context);

                        if(!validateDate && !validateDay && !validateSub && !validateEmail && !validateContent){

                          ContactUsModel con = ContactUsModel();
                          con.uEmail = widget.uEmail;
                          con.date = date.text;
                          con.day = day.text;
                          con.email = email.text;
                          con.sub = sub.text;
                          con.content = content.text;
                          con.isReplied = false;

                          BusService busService = BusService();
                          busService.ContactUs(con);
                          
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactSubmitted())).then((data){
                            if(data != null){
                              Navigator.pop(context);
                            }
                          });
                        }
                        else{
                          Toast.show(
                            'Empty Fields',
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Raleway',
                              fontSize: 14.0,
                            ),
                            duration: 3,
                            backgroundColor: Colors.red,
                            gravity: Toast.bottom
                          );
                        }


                      },
                      child: const Text("Save",style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                      ),)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
