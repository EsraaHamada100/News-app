import 'package:flutter/material.dart';
import "package:conditional_builder_null_safety/conditional_builder_null_safety.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/shared/components/News_app_components.dart';
import 'package:News_App/shared/cubit/cubit.dart';
import 'package:News_App/shared/cubit/statues.dart';
class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).sports;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // it comes from conditional_builder_null_safety: ^0.0.6 package
        // I use it to add a condition to do CircularProgressIndicator
        // until he get the data
        return ConditionalBuilder(
          condition: state != NewsGetSportsLoadingState(),
          // It's a normal ListView but with a separator that separate items
          // the separator can be any widget
          builder: (context) => ListView.separated(
            // adding a good animation when reaching the top of scrolling list
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  buildArticleItem(list[index], context),
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
              itemCount: list.length),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}