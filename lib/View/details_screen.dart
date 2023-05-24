import 'package:covid19_tracker_app/world_states.dart';
import'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int? totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;

   DetailScreen({
    required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.todayRecovered,
     required this.active,
     required this.critical,
     required this.totalRecovered,
     required this.test,

     });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.07,),
                      ReuseableRow(total: 'Cases', value: widget.totalCases.toString()),
                      ReuseableRow(total: 'Deaths', value: widget.totalDeaths.toString()),
                      ReuseableRow(total: 'Critical', value: widget.critical.toString()),
                      ReuseableRow(total: 'Active', value: widget.active.toString()),

                    ],

                  ),
                ),
              ),
              CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(widget.image),
              )

            ],
          )
        ],
      ),
    );
  }
}
