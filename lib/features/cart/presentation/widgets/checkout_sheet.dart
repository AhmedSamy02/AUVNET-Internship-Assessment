import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_ecommerce/core/constants/widgets/auth_normal_button.dart';
import 'package:simple_ecommerce/core/constants/widgets/terms_of_conditions.dart';
import 'package:simple_ecommerce/features/auth/presentation/widgets/auth_loading_button.dart';
import 'package:simple_ecommerce/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:simple_ecommerce/features/cart/presentation/controllers/cart_states.dart';
import 'package:simple_ecommerce/features/cart/presentation/widgets/checkout_row.dart';

class CheckoutSheet extends StatelessWidget {
  const CheckoutSheet({super.key, required this.totalCost});
  final double totalCost;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 14.sp, top: 10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  size: 25.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: const CheckoutRow(
            leading: 'Delivery',
            trailing: 'Select Method',
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: const CheckoutRow(
            leading: 'Payment',
            trailing: 'Cash',
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: const CheckoutRow(
            leading: 'Promo Code',
            trailing: 'Pick discount',
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: CheckoutRow(
            leading: 'Total Cost',
            trailing: '\$${totalCost.toString()}',
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: const TermsOfConditions(),
        ),
        SizedBox(
          width: 0.8.sw,
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if(state is CheckoutLoading) {
                return const AuthLoadingButton();
              }
              return MainNormalButton(
                text: 'Place Order',
                onPressed: () async{
                  await BlocProvider.of<CartCubit>(context).checkout(context);
                },
              );
            },
          ),
        ),
        SizedBox(height: 20.h)
      ],
    );
  }
}
