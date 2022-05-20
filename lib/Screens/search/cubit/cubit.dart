// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/Screens/search/cubit/state.dart';
import 'package:mego_market/model/search/search_model.dart';
import 'package:mego_market/network/End_Points.dart';
import 'package:mego_market/network/dio_helper.dart';
import 'package:mego_market/shared/componnetns/constants.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  var SearchController = TextEditingController();
  void getSearch({String? text}) {
    emit(SearchLoadingStates());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'search': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }

  void clearSearchData() {
    SearchController.clear();
    searchModel ;
  }
}
