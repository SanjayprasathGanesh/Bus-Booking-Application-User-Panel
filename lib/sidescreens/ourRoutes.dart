import 'package:flutter/material.dart';

class OurRoutes extends StatefulWidget {
  @override
  _OurRoutesState createState() => _OurRoutesState();
}

class _OurRoutesState extends State<OurRoutes> {
  final List<BusRoute> busRoutes = [
    BusRoute(
      fromCity: 'Coimbatore',
      toCity: 'Tenkasi',
      image: 'images/tenkasi.jpg',
      busType: 'Non AC-Sleeper, Semi Sleeper, Seater Cum Sleeper',
      price: '600'
    ),
    BusRoute(
      fromCity: 'Coimbatore',
      toCity: 'Chennai',
      image: 'images/chennai.jpg',
      busType: 'Non AC-Sleeper, Semi Sleeper, Seater Cum Sleeper, Benz , Volvo Multi Axle',
      price: '800'
    ),
    BusRoute(
      fromCity: 'Coimbatore',
      toCity: 'Bangalore',
      image: 'images/bangalore.jpg',
      busType: 'Non AC-Sleeper, Semi Sleeper, Seater Cum Sleeper, Benz , Volvo Multi Axle',
      price: '600'
    ),
    BusRoute(
      fromCity: 'Coimbatore',
      toCity: 'Tirunelveli',
      image: 'images/tirunelveli.jpg',
      busType: 'AC-Sleeper, Non AC-Sleeper,Non AC-Semi Sleeper, Seater Cum Sleeper,',
      price: '650'
    ),
    BusRoute(
      fromCity: 'Coimbatore',
      toCity: 'Kochi',
      image: 'images/kochi.jpg',
      busType: 'AC-Sleeper,AC-Semi Sleeper',
      price: '600'
    ),
    BusRoute(
      fromCity: 'Chennai',
      toCity: 'Tirunelveli',
      image: 'images/tirunelveli.jpg',
      busType: 'AC-Sleeper, Non AC-Sleeper,Non AC-Semi Sleeper, Seater Cum Sleeper,',
      price: '1200'
    ),
    BusRoute(
      fromCity: 'Chennai',
      toCity: 'Tenkasi',
      image: 'images/tenkasi.jpg',
      busType: 'AC-Sleeper,Non AC-Sleeper,Non AC-Semi Sleeper,Seater Cum Sleeper,Benz, Scania(Upcomming Soon)',
      price: '1450'
    ),
    BusRoute(
      fromCity: 'Chennai',
      toCity: 'Coimbatore',
      image: 'images/coimbatore.jpg',
      busType: 'AC-Sleeper,Non AC-Sleeper,Non AC-Semi Sleeper,Seater Cum Sleeper,Benz',
      price: '800'
    ),
    BusRoute(
      fromCity: 'Bangalore',
      toCity: 'Coimbatore',
      image: 'images/coimbatore.jpg',
      busType: 'AC-Sleeper,Non AC-Sleeper,Non AC-Semi Sleeper,Seater Cum Sleeper,Benz',
      price: '650'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Routes',style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: ListView.builder(
        itemCount: busRoutes.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text('${busRoutes[index].fromCity} - ${busRoutes[index].toCity}',style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                              ),),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text('Price : Starts From Rs ${busRoutes[index].price}',style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                              ),),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            busRoutes[index].image,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(busRoutes[index].busType,style: const TextStyle(
                      fontFamily: 'Raleway',
                    ),),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BusRoute {
  final String fromCity;
  final String toCity;
  final String image;
  final String busType;
  final String price;

  BusRoute({
    required this.fromCity,
    required this.toCity,
    required this.image,
    required this.busType,
    required this.price,
  });
}
