import 'package:dropdown_search/dropdown_search.dart';
import 'package:flighterr/features/dashboard/widgets/build_profile.dart';
import 'package:flighterr/features/dashboard/widgets/home/action_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _formKey = GlobalKey<FormState>();
final _searchController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 40,
                        width: 200,
                        child: DropdownSearch(
                          items: [
                            "All",
                            "Business",
                            "Economy",
                            "First",
                            "Premium Economy",
                          ],
                          onChanged: (value) {},
                          selectedItem: "All",
                          dropdownBuilder: (context, seletedItem) {
                            return Text(
                              seletedItem ?? "Location",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            );
                          },
                          popupProps: PopupProps.menu(),
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
              ),
              const SizedBox(
                height: 100,
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RotatingProfileWidget(
                                  profilePhoto:
                                      'https://images.unsplash.com/photo-1666615435088-4865bf5ed3fd?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                ),
                                Text(
                                  'Dev Arome @aromedev',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Into your arms keeps playing in my head...',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    ActionButtons()
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

buildProfile(String profilePhoto) {
  return SizedBox(
    width: 60,
    height: 60,
    child: Stack(
      children: [
        Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ))
      ],
    ),
  );
}
