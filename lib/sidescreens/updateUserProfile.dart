import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbus/database/busService.dart';
import 'package:toast/toast.dart';

import '../models/userModel.dart';

class UpdateUserProfile extends StatefulWidget {
  final String uEmail;
  const UpdateUserProfile({Key? key, required this.uEmail}) : super(key: key);


  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {

  TextEditingController name = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController psw = TextEditingController();
  TextEditingController uEmail = TextEditingController();
  String selectedGender = 'Male', docId = '';

  BusService busService = BusService();

  bool validateName = false, validatePhone = false, validateAge = false, validateDOB = false;

  @override
  initState(){
    super.initState();
    getUser();
  }

  getUser() async{
    QuerySnapshot querySnapshot = await busService.GetUser(widget.uEmail);
    List<UserModel> tempList = <UserModel>[];
    String id = '';
    for(int i = 0;i < querySnapshot.size;i++){
      Map<String, dynamic> map = querySnapshot.docs[i].data() as Map<String, dynamic>;
      id = querySnapshot.docs[i].id;
      var user = UserModel();
      user.uEmail = map['uEmail'];
      user.name = map['name'];
      user.phoneNum = map['phoneNum'];
      user.dob = map['dob'];
      user.age = map['age'];
      user.psw = map['psw'];

      tempList.add(user);
    }

    setState(() {
      name.text = tempList[0].name!;
      phoneNo.text = tempList[0].phoneNum!;
      dob.text = tempList[0].dob!;
      age.text = tempList[0].age!.toString();
      uEmail.text = tempList[0].uEmail!;
      psw.text = tempList[0].psw!;
      docId = id;
    });
  }

  selectDOB() async{
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(1950),
      lastDate: DateTime(2011),
    );

    if(selected != null){
      setState(() {
        dob.text = selected.toString().split(' ')[0];
        age.text = (DateTime.now().year - selected.year).toString();
      });
    }
  }

  selectGender() {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.blue,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0)
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          DropdownButton<String>(
            value: selectedGender,
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue!;
              });
            },
            isExpanded: true,
            items: <String>[
              'Male',
              'Female',
              'Transgender',
              'Non-Binary',
              'Prefer not to say',
              'Other',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,style: const TextStyle(
                  fontFamily: 'Raleway',
                ),),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update User Profile",style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 17.0
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0,),
              const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 80.0,
                  child: Icon(Icons.person_sharp,size: 60.0,color: Colors.white,),
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Name",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                  ),),
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
                  errorText: validateName ? 'Empty Name Field' : null,
                ),
                controller: name,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Phone Number",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                  ),),
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
                  errorText: validatePhone ? 'Empty Phone Number Field' : null,
                ),
                controller: phoneNo,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10)
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("DOB",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                  ),),
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
                  errorText: validateDOB ? 'Empty DOB Field' : null,
                ),
                controller: dob,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (){
                  selectDOB();
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Age",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                  ),),
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
                  errorText: validateAge ? 'Empty Age Field' : null,
                ),
                controller: age,
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              selectGender(),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("User Email",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                  ),),
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
                controller: uEmail,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Password",style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                  ),),
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
                controller: psw,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                readOnly: true,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () async{
                    ToastContext().init(context);
                    setState(() {
                      validateName = name.text.isEmpty;
                      validateDOB = dob.text.isEmpty;
                      validatePhone = phoneNo.text.isEmpty;
                      validateAge = age.text.isEmpty;
                    });

                    if(!validateName && !validatePhone && !validateDOB && !validateAge){
                      var user = UserModel();
                      user.name = name.text;
                      user.phoneNum = phoneNo.text;
                      user.dob = dob.text;
                      user.gender = selectedGender;
                      user.age = int.parse(age.text);
                      user.uEmail = uEmail.text;
                      user.psw = psw.text;

                      await busService.UpdateUser(docId, user);

                      Toast.show(
                        'User Details Updated Sucessfully',
                        duration: 3,
                        backgroundColor: Colors.green,
                        gravity: Toast.bottom,
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Raleway',
                        )
                      );

                      Navigator.pop(context, 1);
                    }
                    else{
                      Toast.show(
                          'Some Empty Fields',
                          duration: 3,
                          backgroundColor: Colors.red,
                          gravity: Toast.bottom,
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway',
                          )
                      );
                    }
                  },
                  child: const Text("Update Profile",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold
                  ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
