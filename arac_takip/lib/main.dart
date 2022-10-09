import 'package:arac_takip/feature/home/model/car_tracking_info_model.dart';
import 'package:arac_takip/feature/home/view/home_view.dart';
import 'package:arac_takip/feature/home_detail/view/home_detail_view.dart';
import 'package:arac_takip/product/constant/application_constant.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomeView(),
      routes: {
        HomeDetailView.routeName: (ctx) => const HomeDetailView(null),
      },
    );
  }
}
