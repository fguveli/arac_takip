import 'package:arac_takip/product/constant/application_constant.dart';
import 'package:arac_takip/product/network/product_db_manager.dart';
import 'package:arac_takip/feature/home/view/cubit/home_cubit.dart';
import 'package:arac_takip/product/padding/page_padding.dart';
import 'package:arac_takip/product/widget/loading_center_widget.dart';
import 'package:arac_takip/product/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/home_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeService(DBManager())),
      child: Scaffold(
        appBar: AppBar(
          leading: _loadingCenter(),
        ),
        body: _bodyListView(),
      ),
    );
  }
}

//video 1.28de kaldım
Widget _bodyListView() {
  return BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      return ListView.builder(
        itemCount: state.records?.length ?? kZero.toInt(),
        itemBuilder: (BuildContext context, int index) => ProductCard(info: state.records?[index]),
      );
    },
  );
}

Widget _loadingCenter() {
  return BlocSelector<HomeCubit, HomeState, bool>(
    selector: (state) {
      return state.isLoading ?? false;
    },
    builder: (context, state) {
      return AnimatedOpacity(
        opacity: state ? kOne : kZero,
        duration: const Duration(milliseconds: 5000),
        child: const LoadingCenter(),
      );
    },
  );
}
