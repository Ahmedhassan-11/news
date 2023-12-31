import 'package:flutter/material.dart';
import 'package:news_c8_monday/models/category_model.dart';
import 'package:news_c8_monday/screens/tabs_screen.dart';
import 'package:news_c8_monday/shared/network/remote/api_manager.dart';

class NewsScreen extends StatelessWidget {
  CategoryModel categoryModel;
  String txt;

  NewsScreen(this.categoryModel,this.txt);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSources(categoryModel.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Column(
            children: [
              Center(child: Text("Something went wrong",textAlign: TextAlign.center,)),
              TextButton(
                onPressed: () {},
                child: Text("Try Again"),
              )
            ],
          );
        }

        if (snapshot.data?.status != "ok") {
          return Column(
            children: [
              Text("Error ..!!"),
              TextButton(
                onPressed: () {},
                child: Text("Try Again"),
              )
            ],
          );
        }
        var sources = snapshot.data?.sources ?? [];
        return TabsScreen(sources,txt);
      },
    );
  }
}
