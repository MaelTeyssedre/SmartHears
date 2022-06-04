import 'package:smarthears_mobile/models/content_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  const ColumnBuilder(
      {Key? key,
      required this.itemBuilder,
      required this.itemCount,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      required this.textDirection,
      this.verticalDirection = VerticalDirection.down})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
      children: List.generate(itemCount, (index) => itemBuilder(context, index))
          .toList());
}

class GeolocationList extends StatefulWidget {
  final SoundPacks item;
  final double? startLatitude;
  final double? startLongitude;

  const GeolocationList(
      {Key? key, required this.item, this.startLatitude, this.startLongitude})
      : super(key: key);

  @override
  State<GeolocationList> createState() => _GeolocationListState();
}

class _GeolocationListState extends State<GeolocationList> {
  bool showItems = false;
  late geo.Position startPosition;
  late Future<geo.Position?> determinePosition;

  bool _isGeoUnlock(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude, int radius) {
    double distanceInMeters = geo.Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return (distanceInMeters <= radius.toDouble());
  }

  double _distanceBetween(double startLatitude, double startLongitude,
          double endLatitude, double endLongitude, int radius) =>
      (geo.Geolocator.distanceBetween(
              startLatitude, startLongitude, endLatitude, endLongitude) -
          radius.toDouble()) /
      1000;

  String _distanceBetweenToString(double value) {
    if (value < 0) return "0 m";
    if (value < 1) {
      return "${(value * 1000).toStringAsFixed(0)} m";
    } else if (value < 10) {
      return "${value.toStringAsFixed(2)} km";
    } else {
      return "${value.toStringAsFixed(0)} km";
    }
  }

  Widget adressItem(context, position) => Material(
      color: Colors.transparent,
      child: AnimatedOpacity(
          opacity: showItems ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<geo.Position?>(
                        future: determinePosition,
                        builder: (BuildContext context,
                            AsyncSnapshot<geo.Position?> snapshot) {
                          Widget child = const Icon(Icons.lock_rounded);
                          if (snapshot.hasData) {
                            startPosition = snapshot.data!;
                            child = _isGeoUnlock(
                                    snapshot.data!.latitude,
                                    snapshot.data!.longitude,
                                    position.coordinates[0],
                                    position.coordinates[1],
                                    position.radius)
                                ? const Icon(Icons.lock_open_rounded)
                                : const Icon(Icons.lock_rounded);
                          } else if (snapshot.hasError) {
                            child = const Icon(Icons.lock_rounded);
                          } else {
                            child = const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator()));
                          }
                          return child;
                        }),
                    Flexible(
                        child: Column(children: [
                      Container(
                          width: 250,
                          height: 95,
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          alignment: Alignment.center,
                          child: Text(position.title,
                              overflow: TextOverflow.visible,
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodyText1,
                              textWidthBasis: TextWidthBasis.parent)),
                      Container(
                          width: 250,
                          height: 10,
                          alignment: Alignment.center,
                          child: Text(
                              _distanceBetweenToString(_distanceBetween(
                                  startPosition.latitude,
                                  startPosition.longitude,
                                  position.coordinates[0],
                                  position.coordinates[1],
                                  position.radius)),
                              overflow: TextOverflow.visible,
                              softWrap: true,
                              style: Theme.of(context).textTheme.overline,
                              textWidthBasis: TextWidthBasis.parent))
                    ]))
                  ]))));

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50),
        () => setState(() => showItems = true));
  }

  @override
  Widget build(BuildContext context) => ColumnBuilder(
      textDirection: TextDirection.ltr,
      itemCount: widget.item.getVisiblePositions().length,
      itemBuilder: (BuildContext context, int index) =>
          adressItem(context, widget.item.getVisiblePositions()[index]));
}
