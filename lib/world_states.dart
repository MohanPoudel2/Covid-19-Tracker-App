import 'dart:async';

import 'package:covid19_tracker_app/View/countires_list.dart';
import 'package:covid19_tracker_app/models/WorldStateModel.dart';
import 'package:covid19_tracker_app/services/utils/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> {
  // late final _controller=AnimationController(
  //     duration: const Duration(milliseconds: 1200),
  //     vsync: this
  // )..repeat();


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(
  //       const Duration(seconds: 5),
  //           ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => const WorldStatesScreen(),)) );
  //
  // }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _controller.dispose();
  // }
  final colorList=<Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context,AsyncSnapshot<WorldStateModel> snapshot) {
                  if(!snapshot.hasData){
                   return const Expanded(
                     flex: 1,

                     // child: SpinKitFadingCircle(
                     //   color: Colors.white,
                     //   size: 50,
                     //   controller: _controller,
                     // ),
                     child: Center(
                       child: CircularProgressIndicator(
                         strokeWidth: 2,
                         color: Colors.white,
                       ),
                     )
                   );

                  }
                  else{
                    return Column(
                      children: [
                        PieChart(
                          dataMap:  {
                            'Total':snapshot.data?.cases !=null?double.parse(snapshot.data!.cases.toString()):0.0,
                            'recovered':snapshot.data?.recovered!=null?double.parse(snapshot.data!.recovered.toString()):0.0,
                            'Deaths':snapshot.data?.deaths!=null?double.parse(snapshot.data!.deaths.toString()):0.0,
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true
                          ),
                          chartRadius: MediaQuery.of(context).size.width/4,
                          legendOptions:const LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          //animationDuration :const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(

                          padding:  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.08 ),
                          child: Card(
                            child: Column(
                              children:  [
                                ReuseableRow(total: 'Total', value: snapshot.data!.cases.toString()),
                                ReuseableRow(total: 'Death', value: snapshot.data!.deaths.toString()),
                                ReuseableRow(total: 'Recovered', value: snapshot.data!.recovered.toString()),
                                ReuseableRow(total: 'Critical', value: snapshot.data!.critical.toString()),
                                ReuseableRow(total: 'Today Death', value: snapshot.data!.todayDeaths.toString()),
                                ReuseableRow(total: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),




                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesList() ,));
                             },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:const Center(
                              child: Text('Track Countries'),
                            ),
                          ),
                        )
                      ],
                    );


                  }



              },),



            ],
          ),
        ),
      ),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  final String total,value;
   const ReuseableRow({Key? key,required this.total,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(total),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider(),
        ],
      ),
    );
  }
}