import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/darkmode/models_providers/theme_provider.dart';
import 'package:tegnloge_app/model/prodcut.dart';
import 'package:tegnloge_app/modelprodext.dart';
import 'package:tegnloge_app/reddata/reid.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import 'onpress.dart';
import 'package:tegnloge_app/tools/sized.dart';
class ProductCar extends StatefulWidget {
  const ProductCar({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);
  final double width, aspectRetio;
  final ItemModel product;

  @override
  _ProductCarState createState() => _ProductCarState();
}

class _ProductCarState extends State<ProductCar> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.only(right: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: widget.width,
        child: GestureDetector(
          onTap: ()=> Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product: widget.product),
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag:widget.product.id.toString(),
                    child: Image.network(widget.product.images[0]),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "${widget.product.title}",
                style: TextStyle(color: themeProvider.isLightTheme ?Colors.black:Colors.white),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\QAR ${widget.product.price.toString()}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height:getProportionateScreenHeight(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: widget.product.isFavourite
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: widget.product.isFavourite
                            ? Color(0xFFFF4848)
                            : Color(0xFFDBDEE4),
                      ),
                    ),
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
