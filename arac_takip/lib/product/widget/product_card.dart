import 'package:arac_takip/feature/home/model/car_tracking_info_model.dart';
import 'package:flutter/material.dart';

import '../padding/page_padding.dart';

class ProductCard extends StatelessWidget {
  final CarTrackingInfo? info;
  const ProductCard({Key? key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (info == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const PagePadding.all(),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.car_rental),
          //title: Text(info?.model ?? 'Fatih'),
          //subtitle: Text(info?.plate ?? 'Fatih'),
          title: Column(
            children: [
              Row(children: [
                Text(info?.takenfrom ?? 'Fatih'),
                Text(info?.fromdate.toString() ?? 'Fatih'),
              ]),
              Row(children: [
                Text(info?.givento ?? 'Fatih'),
                Text(info?.todate.toString() ?? 'Fatih'),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
