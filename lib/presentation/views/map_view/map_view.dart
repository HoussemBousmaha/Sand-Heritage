import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sand_culture/app/shared/functions.dart';
import 'package:sand_culture/presentation/resources/size_manager.dart';

class MapView extends StatefulHookConsumerWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  @override
  Widget build(BuildContext context) {
    final dir3iyadhMarkerIconNotifier = useState<BitmapDescriptor?>(null);
    final riyadhParkMarkerIconNotifier = useState<BitmapDescriptor?>(null);
    final riyadhFrontMarkerIconNotifier = useState<BitmapDescriptor?>(null);

    useAsyncEffect(() async {
      dir3iyadhMarkerIconNotifier.value = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        'assets/images/dir3iyah.png',
      );

      riyadhParkMarkerIconNotifier.value = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        'assets/images/riyadhPark.png',
      );

      riyadhFrontMarkerIconNotifier.value = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        'assets/images/riyadhFront.png',
      );

      return null;
    }, []);
    const dir3iyadhMarkerId = MarkerId('dir3iyadh');
    const riyadhParkMarkerId = MarkerId('riyadhPark');
    const riyadhFrontMarkerId = MarkerId('riyadhFront');

    final dir3iyadhMarker = Marker(
      markerId: dir3iyadhMarkerId,
      position: const LatLng(24.749094382382204, 46.53624008999472),
      onTap: () {},
      icon: dir3iyadhMarkerIconNotifier.value ?? BitmapDescriptor.defaultMarker,
    );

    final riyadhParkMarker = Marker(
      markerId: riyadhParkMarkerId,
      position: const LatLng(24.755925604259545, 46.630435008245),
      onTap: () {},
      icon: riyadhParkMarkerIconNotifier.value ?? BitmapDescriptor.defaultMarker,
    );

    final riyadhFrontMarker = Marker(
      markerId: riyadhFrontMarkerId,
      position: const LatLng(24.84138450431199, 46.73325804260371),
      onTap: () {},
      icon: riyadhFrontMarkerIconNotifier.value ?? BitmapDescriptor.defaultMarker,
    );

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            GoogleMap(
              markers: <Marker>{dir3iyadhMarker, riyadhParkMarker, riyadhFrontMarker},
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 60), vertical: getHeight(context, 50)),
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (controller) {},
              initialCameraPosition: const CameraPosition(zoom: 10, target: LatLng(24.774265, 46.738586)),
            ),
          ],
        ),
      ),
    );
  }
}
