import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';


class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>  NewsCubit(),
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context , state){},
        builder: (context , state)
        {
          var list = NewsCubit.get(context).search;

          return  Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormFild(
                    controller: searchController,
                    type: TextInputType.text,
                    onChanged: (value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                ),
                Expanded(child: articleBulider(list, context , isSearch: true,),),
              ],
            ),
          );
        },
      ),
    );
  }
}
