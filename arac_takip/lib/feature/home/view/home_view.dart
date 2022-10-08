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
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  void _listenScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

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

//video 1.28de kaldım
  Widget _bodyListView() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.isInitial) {}
      },
      builder: (context, state) {
        return ListView.builder(
          controller: _scrollController,
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
}
