import "package:flutter/material.dart";

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController mapController;
  List<Marker> allMarkers = [];
  PageController pageController;
  int prevPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coffeShops.forEach((element) {
      allMarkers.add(
        new Marker(
          markerId: new MarkerId(
            element.shopName,
          ),
          draggable: false,
          infoWindow: new InfoWindow(
            title: element.shopName,
            snippet: element.address,
          ),
          position: element.locationCoords,
        ),
      );
    });
    pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Maps"),
          centerTitle: true,
          backgroundColor: Color(0xff161661),
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height - 50.00,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: new CameraPosition(
                  target: new LatLng(-1.0858334, 121.537563),
                  zoom: 12.0,
                ),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
              ),
            ),
            new Positioned(
              bottom: 20.0,
              child: new Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: new PageView.builder(
                  controller: pageController,
                  itemCount: coffeShops.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCoffeeList(index);
                  },
                ),
              ),
            )
          ],
        ));
  }

  void mapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  void moveCamera() {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: coffeShops[pageController.page.toInt()].locationCoords,
          zoom: 14.0,
          bearing: 45.0,
          tilt: 45.0,
        ),
      ),
    );
  }

  void _onScroll() {
    if (pageController.page.toInt() != prevPage) {
      prevPage = pageController.page.toInt();
      moveCamera();
    }
  }

  Widget _buildCoffeeList(index) {
    return new AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: new InkWell(
        onTap: () {
          // moveCamera();
        },
        child: new Stack(
          children: <Widget>[
            new Center(
              child: new Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: 125.0,
                width: 275.0,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black54,
                      offset: new Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      height: 90,
                      width: 90,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                        ),
                        image: new DecorationImage(
                          image: new AssetImage(coffeShops[index].thumbnail),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 5.0,
                    ),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 170.0,
                          child: new Text(
                            coffeShops[index].shopName,
                            style: new TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 170.0,
                          child: new Text(
                            coffeShops[index].address,
                            style: new TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        new Container(
                          width: 170.0,
                          child: new Text(
                            coffeShops[index].description,
                            style: new TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Coffee {
  String shopName;
  String address;
  String description;
  String thumbnail;
  LatLng locationCoords;

  Coffee(
      {this.shopName,
      this.address,
      this.description,
      this.thumbnail,
      this.locationCoords});
}

final List<Coffee> coffeShops = [
  Coffee(
    shopName: "Lentera Lipuku Sekretariat",
    address: "Jl. Nusantara (Kompleks Kabaka)",
    description: "Sekretariat Lentera Lipuku",
    locationCoords: LatLng(-0.871517, 121.585705),
    thumbnail: "assets/images/gambar1.jpg",
  ),
  Coffee(
    shopName: "Mpoa Lipu",
    address: "Vananga Bulan",
    description: "Kegiatan Lentera Lipuku Chapter 1.0",
    locationCoords: LatLng(-1.299292, 121.978819),
    thumbnail: "assets/images/gambar1.jpg",
  ),
  Coffee(
    shopName: "Takibangke",
    address: "Takibangke, Ulubongka, Tojo Una-Una Regency",
    description: "Kegiatan Lentera Lipuku Chapter 2.0",
    locationCoords: LatLng(-1.131029, 121.540278),
    thumbnail: "assets/images/gambar1.jpg",
  )
];
