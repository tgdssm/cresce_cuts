import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/core/state_management/states/base_state.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/initial_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';
import 'package:vale_vantagens/modules/discounts/domain/usecases/get_discounts_usecase.dart';

import '../../../../core/state_management/bloc.dart';

class DiscountsBloc extends Bloc<BaseState> {
  final GetDiscountsUseCase useCase;
  DiscountsBloc(this.useCase) : super(InitialState());

  @override
  onInit() {
    super.onInit();
    getDiscounts();
  }

  Future<void> getDiscounts() async {
    emit(LoadingState());
    final result = await useCase();
    result.fold(
      (e) => emit(
        ErrorState(e.message),
      ),
      (s) => emit(
        SuccessState<List<DiscountEntity>>(s),
      ),
    );
  }
}
