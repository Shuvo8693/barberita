import 'dart:math';
import 'dart:ui' as ui;

import 'package:barberita/common/custom_appbar/custom_appbar.dart';
import 'package:barberita/common/custom_map/reusable_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSelectionMapView extends StatefulWidget {
  const LocationSelectionMapView({super.key});

  @override
  State<LocationSelectionMapView> createState() =>
      _LocationSelectionMapViewState();
}

class _LocationSelectionMapViewState extends State<LocationSelectionMapView> {
  final GlobalKey<ReusableMapState> _mapKey = GlobalKey();
  BitmapDescriptor? customIcon;

  // Sample map position (Hamilton, ON area)
  static const LatLng _center = LatLng(43.2557, -79.8711);

  // Sample car positions
  final Set<Marker> _carMarkers = {
     Marker(
      markerId: MarkerId('car1'),
      position: LatLng(43.2567, -79.8721),
      icon: BitmapDescriptor.defaultMarker,
    ),
    const Marker(
      markerId: MarkerId('car2'),
      position: LatLng(43.2547, -79.8701),
      icon: BitmapDescriptor.defaultMarker,
    ),
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      customIcon = await bitmapDescriptorFromSvgAsset();
      setState(() {});
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      // extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Reusable Map Layer
            ReusableMap(
              key: _mapKey,
              initialPosition: _center,
              initialZoom: 15.0,
              markers: {
                Marker(
                  markerId: MarkerId('car1'),
                  position: LatLng(43.2567, -79.8721),
                  icon: customIcon??BitmapDescriptor.defaultMarker,
                  draggable: true,
                  onDragEnd: (lastLocation){
                    print(lastLocation);
                  }
                ),
              },
              darkMode: true,
              showMyLocation: true,
              onTap: (LatLng location) {
                // Handle map tap
                print(
                  'Map tapped at: ${location.latitude}, ${location.longitude}',
                );
              },
              customFloatingButton: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () {
                  // Center to current location
                  _mapKey.currentState?.animateToLocation(_center, zoom: 16.0);
                },
                child: Icon(
                  Icons.my_location,
                  color: Colors.black87,
                  size: 20.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),

            /// Language Selector Popup
            /// Bottom Sheet with TabBarView
          ],
        ),
      ),
    );
  }

  /// convert svg to bitmap
  Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset([Size size = const Size(60, 60),]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader('assets/svg/nav_pin.svg'), null);

    double devicePixelRatio = ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
    int width = (size.width * devicePixelRatio * 3).toInt();
    int height = (size.height * devicePixelRatio * 3).toInt();

    final scaleFactor = min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = ui.PictureRecorder();

    ui.Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return BitmapDescriptor.bytes(bytes.buffer.asUint8List(),height: 60.h);
  }
}

// Location Item Model
class LocationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final LatLng position;

  const LocationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.position,
  });
}
