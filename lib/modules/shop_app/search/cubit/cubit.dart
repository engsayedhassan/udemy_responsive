import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/shop_app/search_model.dart';
import 'package:untitled1/modules/shop_app/search/cubit/states.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/network/end_points.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void search(String text) {
    emit(SearchLoadingStates());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {'text': text},
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }
}
