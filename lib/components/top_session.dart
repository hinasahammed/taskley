import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskley/components/custom_search_bar.dart';

class TopSession extends StatelessWidget {
  const TopSession({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 30,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            height: 210,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/black_container.jpg',
                  ),
                  fit: BoxFit.cover),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey Hinas!',
                  style: TextStyle(color: Color.fromARGB(255, 237, 231, 231)),
                ),
                Gap(10),
                Text(
                  'Let\' complete\nyour task!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 190,
            right: 0,
            left: 0,
            child: CustomSearchBar(),
          ),
        ],
      ),
    );
  }
}
