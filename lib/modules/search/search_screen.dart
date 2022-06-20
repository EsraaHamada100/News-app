import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/shared/components/News_app_components.dart';
import 'package:News_App/shared/cubit/cubit.dart';
import 'package:News_App/shared/cubit/statues.dart';
import "package:conditional_builder_null_safety/conditional_builder_null_safety.dart";

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    NewsCubit.get(context).getSearch('gold');
    var list = NewsCubit.get(context).search;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (String? value) {
                    if (value == null) {
                      return 'Search can\'t be empty';
                    } else {
                      return null;
                    }
                  },
                  label: 'Search',
                  prefix: Icon(Icons.search),
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              // buildArticleItem(list[0], context),
              ConditionalBuilder(
                condition: list.isNotEmpty,
                // It's a normal ListView but with a separator that separate items
                // the separator can be any widget
                builder: (context) => Column(children: [
                  buildArticleItem(list[0], context)
        ],),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
// ListView.separated(
//                     // adding a good animation when reaching the top of scrolling list
//                     physics: const BouncingScrollPhysics(),
//                     itemBuilder: (BuildContext context, int index) =>
//                         buildArticleItem(list[index], context),
//                     separatorBuilder: (BuildContext context, int index) =>
//                         const Divider(),
//                     itemCount: list.length),
