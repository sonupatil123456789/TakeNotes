import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/colorpallets.dart';

class SearchNotesScreen extends StatelessWidget {
  SearchNotesScreen({super.key});

  // late ProductController productController = ProductController();

  // @override
  // void initState() {

  //   super.initState();
  // }

  TextEditingController searchBarInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    // productController = Provider.of<ProductController>(context, listen: false);
    // productController.searchProductsController(context, "");

    return Scaffold(
      body: SafeArea(
          child: SafeArea(
              child: Container(
        // color: Colors.amberAccent,
        child: Column(
          children: [
////////////////////////////
            Container(
              width: screenwidth,
              height: screenhight * 0.07,
              // color: Color.fromARGB(255, 7, 52, 255),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: screenwidth * 0.11,
                              height: screenhight * 0.05,
                              // color: Color.fromARGB(255, 207, 212, 222),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: screenwidth * 0.05,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ////////////////////////////////
                      Container(
                        width: screenwidth * 0.76,
                        height: screenhight * 0.05,
                        // color: Color.fromARGB(255, 207, 212, 222),
                        child: TextFormField(
                            autocorrect: true,
                            // onEditingComplete: () =>
                            //     productController.searchProductsController(
                            //         context, searchBarInput.text.toString()),
                            onFieldSubmitted: (String value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Product should not be empty ';
                              } else {
                                return null;
                              }
                            },
                            controller: searchBarInput,
                            onChanged: (value) {},
                            textAlign: TextAlign.justify,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              hintText: "Search product here",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                    color: TheamColors.backgroundColor,
                                    width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                    color: TheamColors.backgroundColor,
                                    width: 0),
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
///////////////////////////////////
            SizedBox(
              height: screenhight * 0.01,
            ),
            // Consumer<ProductController>(
            //   builder: (BuildContext context, value, Widget? child) {
            //     var dataListLength = value.searchProducts;
            //     if (value.loading == true) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else {
            //       if (dataListLength == 0 || dataListLength == null) {
            //         return Center(
            //           child: Text("No product found"),
            //         );
            //       } else {
            //         return Expanded(
            //           child: Container(
            //               width: screenwidth,
            //               height: screenhight * 0.36,
            //               // color: Color.fromARGB(255, 214, 83, 83),
            //               child: ListView.builder(
            //                 scrollDirection: Axis.vertical,
            //                 itemCount: value.searchProducts.products!.length,
            //                 itemBuilder: (context, index) {
            //                   var items = value.searchProducts.products![index];
            //                   return Wrap(
            //                     runSpacing: screenwidth * 0.03,
            //                     alignment: WrapAlignment.spaceEvenly,
            //                     children: [
            //                       Card2(
            //                         discription: items.discription.toString(),
            //                         price: items.price.toString(),
            //                         thumbnailImage: items.thumbnail.toString(),
            //                         title: items.title.toString(),
            //                         productId: items.sId.toString(),
            //                         SingleProduct: items,
            //                         starRating: items.rating as num,
            //                         likes: items.likes,
            //                       ),
            //                     ],
            //                   );
            //                 },
            //               )),
            //         );
            //       }
            //     }
            //   },
            // ),
          ],
        ),
      ))),
    );
  }
}
