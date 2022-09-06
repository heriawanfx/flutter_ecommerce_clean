import 'package:account/presentation/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:account/presentation/bloc/logout_bloc/logout_cubit.dart';
import 'package:account/presentation/bloc/update_photo_bloc/update_photo_bloc.dart';
import 'package:account/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:account/presentation/ui/edit_profile_screen.dart';
import 'package:auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:auth/presentation/ui/sign_in_screen.dart';
import 'package:auth/presentation/ui/sign_up_screen.dart';
import 'package:cart_feature/presentation/bloc/bloc.dart';
import 'package:common/utils/navigation/argument/arguments.dart';
import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/firebase/firebase.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:detail_product/presentation/bloc/product_detail_bloc/bloc.dart';
import 'package:detail_product/presentation/ui/product/detail_product_screen.dart';
import 'package:payment_feature/presentation/bloc/history/bloc.dart';
import 'package:payment_feature/presentation/bloc/payment/bloc.dart';
import 'package:payment_feature/presentation/ui/payment/payment_screen.dart';
import 'package:payment_feature/presentation/ui/payment/payment_method_screen.dart';
import 'package:payment_feature/presentation/ui/payment/payment_va_screen.dart';
import 'package:cart_feature/presentation/ui/cart_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:home_page/presentation/bloc/banner_bloc/banner_cubit.dart';
import 'package:home_page/presentation/bloc/home_bloc/home_cubit.dart';
import 'package:home_page/presentation/bloc/product_bloc/product_cubit.dart';
import 'package:home_page/presentation/bloc/product_category_bloc/product_category_cubit.dart';
import 'package:home_page/presentation/ui/bottom_navigation.dart';
import 'package:onboarding/presentation/bloc/onboarding_bloc/onboarding_cubit.dart';
import 'package:onboarding/presentation/bloc/splash_bloc/splash_cubit.dart';
import 'package:onboarding/presentation/ui/on_boarding_screen.dart';
import 'package:onboarding/presentation/ui/splash_screen.dart';
import 'package:common/utils/navigation/router/app_routes.dart';
import 'injections/injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injections().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, __) => MaterialApp(
        title: 'Flutter E Commerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) => SplashCubit(
              getOnBoardingStatusUseCase: getInstance(),
              getTokenUseCase: getInstance(),
            )..initSplash(),
          )
        ], child: SplashScreen()),
        navigatorKey: NavigationHelperImpl.navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          final argument = settings.arguments;
          switch (settings.name) {
            case AppRoutes.splash:
              return MaterialPageRoute(builder: (_) => SplashScreen());
            case AppRoutes.onboarding:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => OnBoardingCubit(
                    cacheOnBoardingUseCase: getInstance(),
                  ),
                  child: OnBoardingScreen(),
                ),
              );
            case AppRoutes.signIn:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => SignInBloc(
                    cacheTokenUseCase: getInstance(),
                    signInUseCase: getInstance(),
                  ),
                  child: SignInScreen(),
                ),
              );
            case AppRoutes.signUp:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => SignUpBloc(
                    cacheTokenUseCase: getInstance(),
                    signUpUseCase: getInstance(),
                  ),
                  child: SignUpScreen(),
                ),
              );
            case AppRoutes.home:
              return MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<HomeCubit>(
                      create: (_) => HomeCubit(),
                    ),
                    BlocProvider<BannerCubit>(
                      create: (_) => BannerCubit(
                        getBannerUseCase: getInstance(),
                      )..getBanner(),
                    ),
                    BlocProvider<ProductCubit>(
                      create: (_) => ProductCubit(
                        getProductUseCase: getInstance(),
                      )..getProduct(),
                    ),
                    BlocProvider<ProductCategoryCubit>(
                      create: (_) => ProductCategoryCubit(
                        getProductCategoryCase: getInstance(),
                      )..getProductCategory(),
                    ),
                    BlocProvider<UserCubit>(
                      create: (_) => UserCubit(
                        getUserUseCase: getInstance(),
                      )..getUser(),
                    ),
                    BlocProvider<LogoutCubit>(
                      create: (_) => LogoutCubit(
                        logoutUseCase: getInstance(),
                      ),
                    ),
                    BlocProvider<HistoryCubit>(
                      create: (_) => HistoryCubit(
                        getHistoryUseCase: getInstance(),
                      )..getHistory(),
                    ),
                  ],
                  child: const BottomNavigation(),
                ),
              );
            case AppRoutes.editProfile:
              return MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<UserCubit>(
                      create: (_) => UserCubit(
                        getUserUseCase: getInstance(),
                      )..getUser(),
                    ),
                    BlocProvider<EditProfileBloc>(
                      create: (_) => EditProfileBloc(
                        firebaseMessaging: getInstance(),
                        updateUserUseCase: getInstance(),
                      ),
                    ),
                    BlocProvider<UpdatePhotoCubit>(
                      create: (_) => UpdatePhotoCubit(
                        imagePicker: getInstance(),
                        uploadPhotoUsecase: getInstance(),
                      ),
                    ),
                  ],
                  child: EditProfileScreen(),
                ),
              );
            case AppRoutes.detailProduct:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<ProductDetailCubit>(
                  create: (_) => ProductDetailCubit(
                    getProductUseCase: getInstance(),
                    getSellerUseCase: getInstance(),
                    addToCartUseCase: getInstance(),
                    saveProductUseCase: getInstance(),
                    deleteProductUseCase: getInstance(),
                    getFavoriteProductByUrlUseCase: getInstance(),
                  ),
                  child: DetailProductScreen(
                    argument: argument as DetailProductArgument,
                  ),
                ),
              );
            case AppRoutes.cartList:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<CartCubit>(
                  create: (_) => CartCubit(
                    getCartUseCase: getInstance(),
                    addToCartUseCase: getInstance(),
                    deleteCartUseCase: getInstance(),
                  ),
                  child: const CartListScreen(),
                ),
              );
            case AppRoutes.payment:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<PaymentCubit>(
                  create: (_) => PaymentCubit(
                    getAllPaymentMethodUseCase: getInstance(),
                    createTransactionUseCase: getInstance(),
                  ),
                  child: PaymentScreen(
                    argument: argument as PaymentArgument,
                  ),
                ),
              );
            case AppRoutes.paymentMethod:
              return MaterialPageRoute(
                builder: (_) => BlocProvider<PaymentCubit>(
                  create: (_) => PaymentCubit(
                    getAllPaymentMethodUseCase: getInstance(),
                    createTransactionUseCase: getInstance(),
                  ),
                  child: const PaymentMethodScreen(),
                ),
              );
            case AppRoutes.paymentVa:
              return MaterialPageRoute(
                builder: (_) => PaymentVAScreen(
                  argument: argument as PaymentVAArgument,
                ),
              );
            default:
              return MaterialPageRoute(builder: (_) => SplashScreen());
          }
        },
      ),
    );
  }
}
