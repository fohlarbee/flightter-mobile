import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppBar extends StatelessWidget {
  final TextEditingController searchController;

  const AppBar({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 40,
              width: 150,
              child: CupertinoSearchTextField(
                controller: searchController,
                placeholder: 'Location',
                placeholderStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                onChanged: (value) {},
              )),
          InkWell(
            onTap: () {},
            child: Icon(
              Iconsax.search_normal_1,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
