import 'package:clup/bloc/category/category_event.dart';
import 'package:clup/bloc/category/category_state.dart';
import 'package:clup/controller/repository/storeRepository.dart';
import 'package:clup/model/store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  StoreRepository _storeRepository = StoreRepository();

  CategoryBloc(InitialState initialState) : super(initialState);

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is NoSelected) {
      List<Store> store = await _storeRepository.getStore();
      yield NoCategoryState(stores: store);
    }

    if (event is SelectSupermarket) {
      List<Store> store =
          await _storeRepository.getStoreByCategory("supermercato");
      yield SupermarketState(stores: store);
    }
    if (event is SelectHealtCare) {
      List<Store> store = await _storeRepository.getStoreByCategory("sanità");
      yield SupermarketState(stores: store);
    }
    if (event is SelectServices) {
      List<Store> store = await _storeRepository.getStoreByCategory("servizio");
      yield SupermarketState(stores: store);
    }
    if (event is SelectOtherActivity) {
      List<Store> store = await _storeRepository.getStoreByCategory("attività");
      yield SupermarketState(stores: store);
    }
    //throw UnimplementedError();
  }
}
