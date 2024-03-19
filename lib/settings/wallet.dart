import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redbus/database/busService.dart';
import 'package:redbus/sidescreens/walletHistroy.dart';

class Wallet extends StatefulWidget {
  final String uEmail;
  const Wallet({Key? key, required this.uEmail}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  BusService busService = BusService();
  List<String> walletList = <String>[];
  var total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWalletDetails();
  }

  getWalletDetails() async{
    QuerySnapshot querySnapshot = await busService.ReadWallet(widget.uEmail!);
    int length = querySnapshot.docs.length;
    for(int i = 0;i < length;i++){
      setState(() {
        Map<String, dynamic> map = querySnapshot.docs[i].data() as Map<String, dynamic>;
        walletList.add(map.toString());
        if(walletList[i].split(',')[7].split(':')[1].replaceAll('}', '') == 'false'){
          total -= int.parse(walletList[i].split(',')[2].split(':')[1]);
        }
        else{
          total += int.parse(walletList[i].split(',')[2].split(':')[1]);
        }
      });
      print('Date : ${walletList[i].split(',')[0].split(':')[1]} - ${walletList[i].split(',')[0].split(':')[1]}');
      print('UEMail : ${walletList[i].split(',')[1].split(':')[1]} - ${walletList[i].split(',')[1].split(':')[1]}');
      print('Price ${walletList[i].split(',')[2].split(':')[1]} - ${walletList[i].split(',')[2].split(':')[1]}');
      print('Used Date : ${walletList[i].split(',')[3].split(':')[1]} - ${walletList[i].split(',')[3].split(':')[1]}');
      print('Used Bus :${walletList[i].split(',')[4].split(':')[1]} - ${walletList[i].split(',')[4].split(':')[1]}');
      print('Bus Name: ${walletList[i].split(',')[5].split(':')[1]} - ${walletList[i].split(',')[5].split(':')[1]}');
      print('Bus Number : ${walletList[i].split(',')[6].split(':')[1]} - ${walletList[i].split(',')[6].split(':')[1]}');
      print('Is used : ${walletList[i].split(',')[7].split(':')[1]} - ${walletList[i].split(',')[7].split(':')[1]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // getWalletDetails();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet",style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Raleway'
        ),),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(12.0),
            // padding: EdgeInsets.all(10.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,size: 50.0,color: Colors.blue,),
                        const SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("TOTAL WALLET BALANCE",style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway'
                            ),),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text("$total",style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway'
                            ),),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 550,
            child: Visibility(
              visible: walletList.isNotEmpty,
              replacement: Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/empty2.jpg',))
                ),
                child: const Text('Empty Wallet Found',style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 25.0,
                  color: Colors.black,
                ),),
              ),
              child: ListView.builder(
                  itemCount: walletList.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                        leading: walletList[index].split(',')[7].split(':')[1].replaceAll('}', '') == 'true' ? const CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.wallet_rounded, color: Colors.black,),
                        ) : const CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.wallet_rounded, color: Colors.black,),
                        ),
                        title: Column(
                          children: [
                            Text(walletList[index].split(',')[0].split(':')[1].replaceAll('{', ''),style: const TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.grey,
                            ),),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(walletList[index].split(',')[5].split(':')[1],style: const TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.black,
                            ),)
                          ],
                        ),
                        trailing: Column(
                          children: [
                            walletList[index].split(',')[7].split(':')[1].replaceAll('}', '') == 'true' ? Text('- ${walletList[index].split(',')[2].split(':')[1]}',style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 13.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),) :
                            Text('+ ${walletList[index].split(',')[2].split(':')[1]}',style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 13.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text('(Cancelled Ticket)',style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'Raleway',
                              color: Colors.grey,
                            ),
                              maxLines: 3,
                            )
                          ],
                        ),
                      )
                    );
                  }
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => WalletHistroy(uEmail: widget.uEmail)));
        },
        child: const Icon(Icons.history_outlined),
      ),
    );
  }
}
