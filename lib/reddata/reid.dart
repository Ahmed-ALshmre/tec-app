import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/darkmode/models_providers/theme_provider.dart';
import 'package:tegnloge_app/model/prodcut.dart';
import 'package:tegnloge_app/reddata/redBody.dart';
import 'package:tegnloge_app/widget/appbardatascreen.dart';
import '../modelprodext.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:themeProvider.isLightTheme? Color(0xFFF5F6F9):Color(0xFF26242e),
      appBar: CustomAppBar(rating: 4.5),
      body: ReadData(product: agrs.product ,them: themeProvider.isLightTheme, ),
    );
  }
}
class ProductDetailsArguments {
  final ItemModel product;
  ProductDetailsArguments({@required this.product});
}
