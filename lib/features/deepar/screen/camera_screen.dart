import 'dart:io';

import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flighterr/constants/constants.dart';
import 'package:path_provider/path_provider.dart';
import '../data/filter_data.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final deepArController = DeepArController();

  Future<void> initializeController() async {
    await deepArController.initialize(
      androidLicenseKey: licenseKey,
      iosLicenseKey: '',
      resolution: Resolution.high,
    );
  }

  Widget buildButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IconButton(
          //   onPressed: deepArController.flipCamera,
          //   icon: const Icon(
          //     Icons.flip_camera_ios_outlined,
          //     size: 34,
          //     color: Colors.white,
          //   ),
          // ),
          IconButton(
            onPressed: () async {
              await deepArController.stopVideoRecording();
            },
            icon: const Icon(
              Icons.stop,
              size: 34,
              color: Colors.white,
            ),
          ),
          FilledButton(
            onPressed: () async {
              await deepArController.startVideoRecording();
              final File file = await deepArController.takeScreenshot();

              if (await file.exists()) {
                final Directory? appDocDir =
                    await getExternalStorageDirectory();
                if (appDocDir != null) {
                  final String picturesPath = '${appDocDir.path}/Pictures';
                  final Directory picturesDir = Directory(picturesPath);
                  if (!await picturesDir.exists()) {
                    picturesDir.create(recursive: true);
                  }
                  final String localPath = '$picturesPath/image.jpg';
                  await file.rename(localPath);
                  debugPrint('File moved to: $localPath');
                } else {
                  debugPrint('External storage directory not found');
                }
              } else {
                debugPrint('File does not exist');
              }
            },
            child: const Icon(Icons.camera),
          ),
          IconButton(
            onPressed: deepArController.toggleFlash,
            icon: const Icon(
              Icons.flash_on,
              size: 34,
              color: Colors.white,
            ),
          ),
        ],
      );

  Widget buildCameraPreview() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.72,
        child: Transform.scale(
          scale: 1.5,
          child: DeepArPreview(deepArController),
        ),
      );

  Widget buildFilters() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final filter = filters[index];
              final effectFile =
                  File('assets/filters/${filter.filterPath}').path;
              return InkWell(
                onTap: () => deepArController.switchEffect(effectFile),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image:
                            AssetImage('assets/previews/${filter.imagePath}'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initializeController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildCameraPreview(),
                buildButtons(),
                buildFilters(),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
