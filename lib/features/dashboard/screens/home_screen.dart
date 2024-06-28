import 'package:flighterr/features/dashboard/widgets/build_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
                      width: 150,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color:
                                        Colors.white), // Enabled border color
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color:
                                        Colors.white), // Focused border color
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: Colors.red), // Error border color
                              ),
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.white),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Iconsax.search_normal1,
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RotatingProfileWidget(
                                    profilePhoto:
                                        'https://images.unsplash.com/photo-1666615435088-4865bf5ed3fd?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                                Text(
                                  'Dev Arome @aromedev',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                            const Text(
                              'Into your arms keeps playing in my head...',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '82.3k',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    Icon(
                                      Ionicons.chatbubble_ellipses,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '511',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    Icon(
                                      Ionicons.bookmark,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '2493',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    Icon(
                                      MaterialCommunityIcons.share,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '2451',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    Icon(
                                      Ionicons.eye,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '149k',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          )
                        ],
                      ),
                    )
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
