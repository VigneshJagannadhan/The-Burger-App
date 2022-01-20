import 'package:flutter/material.dart';
import 'package:open_cart/providers/food_items_provider.dart';
import 'package:open_cart/screens/product_detail_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/custom_product_image_box_widget.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  static const String route = '/produtsScreen';
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late FoodProvider _foodProvider;

  @override
  void initState() {
    _foodProvider = FoodProvider();
    _initAsync();
    super.initState();
  }

  @override
  void dispose() {
    _foodProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FoodProvider>.value(value: _foodProvider)
      ],
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Burgers'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<FoodProvider>(builder: (context, provider, _) {
                  List _foodList = provider.foodList;
                  return Container(
                    color: colorDarkGrey,
                    height: deviceSize.height,
                    width: deviceSize.width,
                    child: ListView.builder(
                      itemCount: _foodList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = _foodList[index].toMap();
                        return SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                                ProductDetailScreen.route,
                                arguments: map),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ProductDetailsWidget(
                                    map: map,
                                  ),
                                ),
                                CustomProductImageBox(
                                  map: map,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  _initAsync() async {
    await _foodProvider.fetchProducts();
  }
}

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({Key? key, required this.map}) : super(key: key);
  final Map map;

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(builder: (context, provider, _) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: map["isVeg"] ? Colors.green : colorRed, width: 1)),
            width: 20,
            height: 20,
            child: Center(
              child: Icon(Icons.circle,
                  size: 15, color: map["isVeg"] ? Colors.green : colorRed),
            ),
          ),
          Text(
            map["foodName"],
            style: tsCOrangeCustomFFPrimaryS20,
          ),
          const SBH5(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    map["foodRating"].toString(),
                    style: tsCwhiteFFPrimaryS15,
                  ),
                  const SBW5(),
                  Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.amber.shade400,
                  )
                ],
              ),
              const SBW5(),
              Text(
                "${map["foodPrepTime"].toString()} mins",
                style: tsCwhiteFFPrimaryS12,
              ),
            ],
          ),
          const SBH5(),
          Text(
            map["foodDetails"],
            style: TextStyle(
                fontSize: 12, color: colorFF, fontWeight: FontWeight.w400),
          ),
        ]),
      );
    });
  }
}
