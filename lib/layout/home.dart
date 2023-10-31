import 'package:flutter/material.dart';
import 'package:news_c8_monday/models/category_model.dart';
import 'package:news_c8_monday/screens/categories.dart';
import 'package:news_c8_monday/screens/drawer_widget.dart';
import 'package:news_c8_monday/screens/news_Screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  bool v1 = false;
  bool select = false;
  TextEditingController searchtxt = TextEditingController();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> suggestion = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(onDrawerClicked),
      appBar: AppBar(
        toolbarHeight: 80,
        actions: [

          Visibility(
            visible:
                categoryModel == null ? widget.v1 == true : widget.v1 == false,
            child: IconButton(
                onPressed: () {
                  widget.select=true;
                  setState(() {});
                },
                icon: const Icon(Icons.search)),
          )
        ],
        centerTitle: true,
        elevation: 0,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            )),
        backgroundColor: Color(0xFF39A552),
        title: widget.select==true ?TextField(
          decoration: InputDecoration(

            fillColor: Colors.white,
              filled: true,
              hintText: "Search",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.white)),
              prefixIcon: IconButton(onPressed: (){
                widget.searchtxt.clear();
                widget.select=false;
                setState(() {

                });

              },

                  icon: Icon(Icons.close)),
            suffixIcon: IconButton(onPressed: (){
              setState(() {

              });

            },

                icon: Icon(Icons.search))




          ),
          controller: widget.searchtxt,
        ):
        Text(categoryModel == null ? "News App" : categoryModel!.name),
      ),
      body: categoryModel == null
          ? CategoriesScreen(onCategorySelected)
          : NewsScreen(categoryModel!, widget.searchtxt.text ?? ""),
    );
  }

  CategoryModel? categoryModel = null;

  void onDrawerClicked(number) {
    if (number == DrawerWidget.CATEGORY) {
      categoryModel = null;
    } else if (number == DrawerWidget.SETTINGS) {
      // open settings tab
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  void onCategorySelected(category) {
    categoryModel = category;
    setState(() {});
  }
}

class CustomSearch extends SearchDelegate {
  List<String> allData = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox();
  }
}
