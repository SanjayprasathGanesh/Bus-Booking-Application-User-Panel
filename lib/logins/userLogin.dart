import 'package:flutter/material.dart';
import 'package:redbus/logins/userSignup.dart';
import 'package:redbus/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../database/busService.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  TextEditingController uEmail = TextEditingController();
  TextEditingController psw = TextEditingController();

  BusService busService = BusService();

  bool validateName = false, validatePsw = false, showPsw = false;

  void saveUserLogin() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('userEmail', uEmail.text);
    await sharedPreferences.setString('userPsw', psw.text);
  }

  void getUserLogin() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // setState(() {
      uEmail.text = sharedPreferences.getString('userEmail')!;
      psw.text = sharedPreferences.getString('userPsw')!;
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLogin();
  }

  /*void _saveAdminCredentials(String uEmail, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', uEmail);
    await prefs.setString('password', password);
  }

  // Retrieve admin credentials from shared preferences
  Future<Map<String, String>> _getAdminCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    String? password = prefs.getString('password');
    return {'userEmail': userEmail ?? '', 'password': password ?? ''};
  }

  Future<void> _loadAdminCredentials() async {
    Map<String, String> credentials = await _getAdminCredentials();
    uEmail.text = credentials['userEmail'] ?? '';
    psw.text = credentials['password'] ?? '';
  }

  @override
  void initState() {
    super.initState();
    _loadAdminCredentials(); // Load admin credentials when the widget initializes
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: const DecorationImage(
                    image: AssetImage(
                      'images/logo.jpg',
                    ),
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.high,
                  ),
              ),
            ),
            const Text('Log In Now',style: TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8
            ),),
            const SizedBox(
              height: 5.0,
            ),
            const Text('Please login to continue using our app',style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8
            ),),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.blue,
                  width: 3.0,
                ),
              ),
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Enter the Email Name",style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontSize: 14.0
                      ),),
                      errorText: validateName ? 'Empty Email Name Field' : null,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          )
                      ),
                    ),
                    controller: uEmail,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.blue,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Stack(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          label: const Text("Enter the Password",style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Raleway',
                              fontSize: 14.0
                          ),),
                          errorText: validatePsw ? 'Empty Password Field' : null,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              )
                          ),
                          // suffix:
                        ),
                        controller: psw,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.blue,
                        obscureText: !showPsw,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.all(7.0),
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                showPsw = !showPsw;
                              });
                            },
                            icon: showPsw ? const Icon(Icons.visibility_off,color: Colors.black,size: 25.0,) : const Icon(Icons.visibility_outlined,color: Colors.black,size: 25.0,),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0,bottom: 10.0),
                    height: 45.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                      ),
                      onPressed: () async{
                        ToastContext().init(context);
                        setState(() {
                          validateName = uEmail.text.isEmpty;
                          validatePsw = psw.text.isEmpty;
                        });
                        if(!validateName && !validatePsw){
                          var check = await busService.CheckUser(uEmail.text.trim(), psw.text.trim());
                          print(check);
                          saveUserLogin();

                          if(check){
                            Toast.show(
                              'Logined Successfully',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Raleway',
                                fontSize: 13.0,
                              ),
                              duration: 2,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.green,
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RedbusApp(uEmail: uEmail.text,)));
                          }
                          else{
                            Toast.show(
                              'User Not Found or Wrong Credentials',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Raleway',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                              duration: 2,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.red,
                            );
                          }
                        }
                      },
                      child: const Text('Log In',style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                  InkWell(
                    child: const Text("Don't have an account ? Sign up",style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserSignup()));
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'images/insta.png'
                          )
                      )
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'images/facebook.png'
                          )
                      )
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'images/twitter.png'
                          )
                      )
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
