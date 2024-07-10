import 'package:ar_hardware/viewModel/product_viewmodel.dart';
import 'package:ar_hardware/widgets/user_product_cards.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class SearchPlot extends SearchDelegate {
  final productViewModel = Get.put(ProductViewModel());

  @override
  String? get searchFieldLabel => "Search Tool";

  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 16);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    productViewModel.searchProducts(query: query);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          StreamBuilder<List<ProductModel>>(
            stream: productViewModel.productsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else {
                List<ProductModel>? products = snapshot.data;
                if (products != null && products.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) =>
                          UserProductCard(product: products[index]),
                    ),
                  );
                } else {
                  return const Center(
                    child: AutoSizeText(
                      'No product found!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search Tool'),
    );
  }
}
