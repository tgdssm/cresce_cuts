import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/core/navigation/base_path.dart';
import 'package:vale_vantagens/modules/discount_detail/ui/pages/discount_detail_page.dart';

class DiscountDetailModule extends Module {
  static const root = BasePath('/discount-detail');
  static const initial = BasePath('/', root);

  @override
  void routes(RouteManager r) {
    r.child(
      initial.path,
      child: (context) => DiscountDetailPage(
        discount: r.args.data,
      ),
    );
    super.routes(r);
  }
}
