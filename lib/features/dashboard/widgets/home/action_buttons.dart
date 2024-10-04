import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  context.push('/camera');
                },
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 3),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 3),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
