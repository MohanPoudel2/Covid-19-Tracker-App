import 'package:covid19_tracker_app/View/details_screen.dart';
import 'package:covid19_tracker_app/services/utils/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class CountriesList extends StatefulWidget {
   CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController=TextEditingController();


  @override
  Widget build(BuildContext context) {

    StatesServices statesServices=StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);

          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children:  [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              onChanged: (value){
               setState(() {

               });
              },

              controller: searchController,
              decoration: InputDecoration(
                hintText: 'search your country here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              ),
            ),
          ),
          Expanded(
            child:FutureBuilder(
              future: statesServices.countriesListApi(),
              builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                if(!snapshot.hasData){
                  return  ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,

                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              title:Container(height: 10,width: 90,color: Colors.white,),
                              subtitle:Container(height: 10,width: 90,color: Colors.white,),
                              leading: Container(height: 50,width: 50,color: Colors.white,),
                            )
                          ],
                        ),
                      );

                    },);
                }else{
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {

                      String name=snapshot.data![index]['country'];
                      if(searchController.text.isEmpty){
                        return Column(
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                  name: snapshot.data![index]['country'] as String,
                                  image: snapshot.data![index]['countryInfo']['flag']as String,
                                  totalCases:snapshot.data![index]['cases']as int? ,
                                  todayRecovered: snapshot.data![index]['recovered']as int?,
                                  totalDeaths: snapshot.data![index]['deaths']as int?,
                                  active: snapshot.data![index]['active']as int?,
                                  test: snapshot.data![index]['test']as int? ,
                                  critical: snapshot.data![index]['critical']as int?,
                                  totalRecovered: snapshot.data![index]['totalRecovered']as int?,

                                ),));
                                },
                              child: ListTile(
                                title:Text(snapshot.data![index]['country']),
                                subtitle:Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height:50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                ),
                              ),
                            )
                          ],
                        );

                      }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                        return Column(

                          children: [
                            InkWell(
                              onTap:(){

                              },
                              child: ListTile(
                                title:Text(snapshot.data![index]['country']),
                                subtitle:Text(snapshot.data![index]['cases'].toString()),
                                leading:Image(
                                  height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag'],)),
                                ),
                            ),

                          ],
                        );

                      }else{
                        return Container();

                      }


                  },);
                }

              },
            )
          ),

        ],
      ),
    );
  }
}

