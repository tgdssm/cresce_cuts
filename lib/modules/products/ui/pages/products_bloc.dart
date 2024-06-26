import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/core/state_management/bloc.dart';
import 'package:vale_vantagens/core/state_management/states/base_state.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/initial_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';

import '../../domain/usecases/get_products_usecase.dart';

class ProductsBloc extends Bloc<BaseState> {
  final GetProductsUseCase getProductsUseCase;
  ProductsBloc(this.getProductsUseCase) : super(InitialState());

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    emit(LoadingState());
    final result = await getProductsUseCase();
    await Future.delayed(const Duration(milliseconds: 500));
    result.fold(
      (e) => emit(
        ErrorState(
          e.message,
          e.code,
        ),
      ),
      (s) => emit(
        SuccessState<List<ProductEntity>>(s),
      ),
    );
  }
}
