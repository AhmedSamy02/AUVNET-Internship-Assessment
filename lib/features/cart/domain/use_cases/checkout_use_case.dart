import 'package:dartz/dartz.dart';
import 'package:simple_ecommerce/core/errors/failure.dart';
import 'package:simple_ecommerce/core/use_cases/use_case_with_params.dart';
import 'package:simple_ecommerce/features/cart/data/models/cart.dart';
import 'package:simple_ecommerce/features/cart/domain/repositories/cart_repo.dart';

class CheckoutUseCase extends UseCaseWithOneParam<void, List<Cart>> {
  final CartRepository cartRepository;

  CheckoutUseCase({required this.cartRepository});
  @override
  Future<Either<Failure, void>> call(List<Cart> parameter) async {
    return await cartRepository.checkout(parameter);
  }
}
