import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbus/database/busService.dart';
import 'package:toast/toast.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {

  BusService busService = BusService();


  List<OfferModel> offerList = <OfferModel>[];
  List<String> offerIds = <String>[];
  bool isLoaded = false;

  getAllOffers() async{
    QuerySnapshot querySnapshot = await busService.GetAllOffers();
    List<OfferModel> tempList = [];
    List<String> tempIds = [];
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for(int i = 0;i < querySnapshot.docs.length;i++){
      Map<String, dynamic> map = querySnapshot.docs[i].data() as Map<String, dynamic>;
      OfferModel offerModel = OfferModel();
      offerModel.offerName = map['offerName'];
      offerModel.offerCode = map['offerCode'];
      offerModel.validFrom = map['validFrom'];
      offerModel.validTo = map['validTo'];
      offerModel.discountPrice = map['discountPrice'];
      offerModel.isExpired = map['isExpired'];
      DateTime validFrom = DateTime.parse(offerModel.validFrom!);
      DateTime validTo = DateTime.parse(offerModel.validTo!);
      if (validFrom.isBefore(today) && validTo.isAfter(today)) {
        tempList.add(offerModel);
        tempIds.add(querySnapshot.docs[i].id);
      }
    }

    setState(() {
      offerList = tempList;
      offerIds = tempIds;
      isLoaded = true;
    });
  }

  bool isCopied = false;

  void copyToClipboard(String promoCode) {
    Clipboard.setData(ClipboardData(text: promoCode));
    setState(() {
      isCopied = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllOffers();
  }

  @override
  Widget build(BuildContext context) {
    getAllOffers();

    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (isLoaded && offerList.isEmpty) {
      return Scaffold(
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/noOffers.png'),
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.high,
                )
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          margin: const EdgeInsets.all(10.0),
          child: ListView.builder(
              itemCount: offerList.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Promo Name: ${offerList[index].offerName}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Promo Code: ${offerList[index].offerCode}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.blueGrey,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black
                              ),
                              onPressed: (){
                                isCopied ? null : copyToClipboard(offerList[index].offerCode!);
                              },
                              child: Text(isCopied ? 'Copied!' : 'Copy Promo Code'),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }

}

class OfferModel{
  String? offerName;
  String? offerCode;
  String? validFrom;
  String? validTo;
  int? discountPrice;
  bool? isExpired;

  offerMap(){
    var map = <String, dynamic>{};
    map['offerName'] = offerName;
    map['offerCode'] = offerCode;
    map['validFrom'] = validFrom;
    map['validTo'] = validTo;
    map['discountPrice'] = discountPrice;
    map['isExpired'] = isExpired;
    return map;
  }
}
