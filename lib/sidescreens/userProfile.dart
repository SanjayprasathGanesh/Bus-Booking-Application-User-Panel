import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redbus/database/busService.dart';
import 'package:redbus/models/userModel.dart';
import 'package:redbus/sidescreens/updateUserProfile.dart';

class UserProfile extends StatefulWidget {
  final String uEmail;
  const UserProfile({Key? key, required this.uEmail}) : super(key: key);


  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  TextEditingController name = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController psw = TextEditingController();
  TextEditingController uEmail = TextEditingController();


  BusService busService = BusService();

  @override
  initState(){
    super.initState();
    getUser();
  }

  getUser() async{
    QuerySnapshot querySnapshot = await busService.GetUser(widget.uEmail);
    List<UserModel> tempList = <UserModel>[];
    for(int i = 0;i < querySnapshot.size;i++){
      Map<String, dynamic> map = querySnapshot.docs[i].data() as Map<String, dynamic>;
      var user = UserModel();
      user.uEmail = map['uEmail'];
      user.name = map['name'];
      user.phoneNum = map['phoneNum'];
      user.gender = map['gender'];
      user.dob = map['dob'];
      user.age = map['age'];
      user.psw = map['psw'];

      tempList.add(user);
    }

    setState(() {
      name.text = tempList[0].name!;
      phoneNo.text = tempList[0].phoneNum!;
      gender.text = tempList[0].gender!;
      dob.text = tempList[0].dob!;
      age.text = tempList[0].age!.toString();
      uEmail.text = tempList[0].uEmail!;
      psw.text = tempList[0].psw!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile",style: TextStyle(
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
                ),
                controller: name,
                keyboardType: TextInputType.text,
                readOnly: true,
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
                ),
                controller: phoneNo,
                keyboardType: TextInputType.phone,
                readOnly: true,
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
                ),
                controller: dob,
                keyboardType: TextInputType.datetime,
                readOnly: true,
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
                ),
                controller: age,
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Gender",style: TextStyle(
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
                controller: gender,
                keyboardType: TextInputType.text,
                readOnly: true,
              ),
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
              const Divider(
                indent: 60.0,
                endIndent: 5.0,
                thickness: 2.0,
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.lock_clock_outlined,color: Colors.red,),
                title: const Text("Change Password",style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),),
                onTap: (){
                  openCircularProgress();
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(uEmail: widget.uEmail,)));
                },
              ),
              const Divider(
                indent: 60.0,
                endIndent: 5.0,
                thickness: 2.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserProfile(uEmail: widget.uEmail))).then((data){
            if(data != null){
              getUser();
            }
          });
        },
        tooltip: 'Update Your User Profile',
        child: const Icon(Icons.update_rounded,color: Colors.white,),
      ),
    );
  }

  openCircularProgress(){
    showDialog(
        context: context,
        builder: (param){
          return Container(
            height: 50,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
      }
    );
  }
}
