import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tegnloge_app/model/prodcut.dart';
import 'package:tegnloge_app/reddata/reid.dart';
import 'package:tegnloge_app/tools/sized.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import 'appbarsearch.dart';

class SearchProduct extends StatefulWidget {
  static String routeName = "/search";
  @override
  _SearchProductState createState() => new _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  Future<QuerySnapshot> listQuery;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          bottom: PreferredSize(
            child: serachWid(context),
            preferredSize: Size(56.0, 56.0),
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: listQuery,
          builder: (context, snapShout) {
            return snapShout.hasData
                ? ListView.builder(
                    itemCount: snapShout.data.documents.length,
                    itemBuilder: (context, index) {
                      ItemModel model = ItemModel.fromJson(
                          snapShout.data.documents[index].data);
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(10) ,horizontal: getProportionateScreenWidth(15)),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments:
                                  ProductDetailsArguments(product: model),
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 88,
                                child: AspectRatio(
                                  aspectRatio: 0.88,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F6F9),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: model.images != null
                                        ? Image.network(
                                            model.images[0],
                                            fit: BoxFit.cover,
                                          )
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${model.title}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 10),
                                  Text.rich(
                                    TextSpan(
                                      text: "\QAR ${model.price}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor),
                                      children: [
                                        TextSpan(
                                            // text: " x${cart.numOfItem}",
                                            //style: Theme.of(context).textTheme.bodyText1),
                                            ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text('لا توجد بيانات'),
                  );
          },
        ),
      ),
    );
  }
  Widget serachWid(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) =>  startSearch(value),
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.symmetric(
          //     horizontal:0 ,
          //     vertical:0,
          // ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "البحث عن المنتج",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
  Widget sizedWidth() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.lightGreenAccent,
              Colors.pink,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 40.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  onChanged: (value) {

                  },
                  decoration:
                      InputDecoration.collapsed(hintText: "Search here"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: missing_return
  Future startSearch(String query) async {
    listQuery = Firestore.instance
        .collection('all')
        .where('title', isGreaterThanOrEqualTo: query)
        .getDocuments();
  }
}
