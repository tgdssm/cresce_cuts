import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/core/state_management/bloc.dart';
import 'package:vale_vantagens/core/state_management/states/base_state.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/initial_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/register_discount_states.dart';

import '../../../../commons/models/discount_model.dart';
import '../../domain/usecases/register_discount_usecase.dart';

class RegisterDiscountBloc extends Bloc<BaseState> {
  final RegisterDiscountUseCase useCase;
  RegisterDiscountBloc(this.useCase) : super(InitialState());

  void updateDiscountType(DiscountType type) {
    switch (type) {
      case DiscountType.price:
        emit(DiscountPriceState());
        break;
      case DiscountType.percentage:
        emit(DiscountPercentageState());
        break;
      case DiscountType.takePay:
        emit(DiscountTakePayState());
        break;
    }
  }

  Future<void> register(DiscountEntity entity) async {
    emit(LoadingState());
    final result = await useCase(entity);
    result.fold(
      (e) => emit(
        ErrorState(e.message),
      ),
      (s) => emit(
        const SuccessState<bool>(true),
      ),
    );
  }
}
