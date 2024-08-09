import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_ecommerce/core/constants/methods.dart';
import 'package:simple_ecommerce/core/constants/screens.dart';
import 'package:simple_ecommerce/core/constants/values.dart';
import 'package:simple_ecommerce/features/auth/presentation/screens/login_screen.dart';
import 'package:simple_ecommerce/features/auth/presentation/screens/register_screen.dart';
import 'package:simple_ecommerce/features/cart/data/repositories/cart_repo_impl.dart';
import 'package:simple_ecommerce/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:simple_ecommerce/features/home_screen.dart';
import 'package:simple_ecommerce/features/landing_screen.dart';
import 'package:simple_ecommerce/features/shop/presentation/screens/product_details_screen.dart';

void main() async {
  await initializeHive();
  initializeLocators();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: BlocProvider(
        create: (context) => CartCubit(getit.get<CartRepositoryImpl>())..getCart(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Gilroy',
          ),
          routes: {
            kLandingScreen: (context) => const LandingScreen(),
            kLoginScreen: (context) => const LoginScreen(),
            kHomeScreen: (context) => const HomeScreen(),
            kRegisterScreen: (context) => const RegisterScreen(),
            kProductDetailsScreen: (context) => const ProductDetailsScreen(),
          },
          initialRoute: kHomeScreen,
        ),
      ),
    );
  }
}
