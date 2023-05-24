import 'dart:convert';

import 'package:covid19_tracker_app/models/WorldStateModel.dart';
import 'package:covid19_tracker_app/services/utils/app_url.dart';
import 'package:http/http.dart'as http;



class StatesServices{
  Future<WorldStateModel> fetchWorldStatesRecords() async{
    final response= await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    }else{
     throw Exception('error');
    }
    
  }
  Future<List<dynamic>> countriesListApi() async{
    var data;
    final response= await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
       data=jsonDecode(response.body);
      return data;
    }else{
      throw Exception('error');
    }

  }
}