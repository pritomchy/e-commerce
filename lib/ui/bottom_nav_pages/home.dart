import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/const/AppColors.dart';
import 'package:ecommerce_app/pages/edit_profile.dart';
import 'package:ecommerce_app/ui/bottom_nav_pages/profile.dart';
import 'package:ecommerce_app/ui/horizontal_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../product_details_screen.dart';
import '../search_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Boi Pori",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchScreen()),
              );

            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfilePage()),
              );
            },
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(4, 248, 207, 1),
                    Color.fromRGBO(251, 243, 100, 1),
                  ])),
              child: Container(
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      elevation: 10,
                      child: Image.asset(
                        "assets/images/bookshop.jpg",
                        width: 100,
                        height: 100,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Boi Pori')
                  ],
                ),
              ),
            ),
            CustomListTile(
              icon: Icons.person,
              textTitle: "Group Members",
            ),

            CustomListTile(
              icon: Icons.star,
              textTitle: "Pritom Chowdhury",
            ),
            CustomListTile(
              icon: Icons.engineering,
              textTitle: "Supervised By",
            ),
            CustomListTile(
              icon: Icons.assistant_photo,
              textTitle: "Md. Jamir Ahmed",
            ),
            Divider(),
            ListTile(
              title: Text('0.0.1'),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w,top: 10.w),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: "Search products here",
                      hintStyle: TextStyle(fontSize: 15.sp),
                    ),
                    onTap: () => Navigator.push(context,
                        CupertinoPageRoute(builder: (_) => SearchScreen())),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                AspectRatio(
                  aspectRatio: 3.5,
                  child: CarouselSlider(
                      items: _carouselImages
                          .map((item) => Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fitWidth)),
                        ),
                      ))
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (val, carouselPageChangedReason) {
                            setState(() {
                              _dotPosition = val;
                            });
                          })),
                ),
                SizedBox(
                  height: 2.h,
                ),
                DotsIndicator(
                  dotsCount:
                  _carouselImages.length == 0 ? 1 : _carouselImages.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.deep_orange,
                    color: AppColors.deep_orange.withOpacity(0.5),
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(8, 8),
                    size: Size(6, 6),
                  ),
                ),

                new Padding(padding: const EdgeInsets.all(8.0),

                ),
                HorizontalList(),
                SizedBox(
                  height: 15.h,
                ),
                Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetails(_products[index]))),
                          child: Card(
                            elevation: 3,
                            child: Column(
                              children: [
                                AspectRatio(
                                    aspectRatio: 2,
                                    child: Container(
                                        color: Colors.white70,
                                        child: Image.network(
                                          _products[index]["product-img"][0],
                                        ))),
                                Text("${_products[index]["product-name"]}"),
                                Text(
                                    "${_products[index]["product-price"].toString()}"),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
class CustomListTile extends StatelessWidget {
  IconData? icon;
  String? textTitle;

  CustomListTile({this.icon, this.textTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Column(
          children: <Widget>[
            Divider(),
            ListTile(leading: Icon(icon), title: Text(textTitle!)),
          ],
        ),
      ),
    );
  }
}