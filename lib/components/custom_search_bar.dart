import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskley/view/search_view.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: InkWell(
        onTap: () {
          Get.to(
            () => const SearchView(),
          );
        },
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Search'),
              Icon(Icons.search),
            ],
          ),
        ),
      ),
    );
  }
}
