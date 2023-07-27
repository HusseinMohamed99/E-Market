import 'package:super_marko/model/cart/add_cart_model.dart';
import 'package:super_marko/model/changePassword/change_password_model.dart';
import 'package:super_marko/model/favorite/favorite_model.dart';
import 'package:super_marko/model/home/home_model.dart';
import 'package:super_marko/model/login/login_model.dart';

abstract class MainStates {}

class MainInitialStates extends MainStates {}

class AppChangeModeState extends MainStates {}

class UserLoginLoadingStates extends MainStates {}

class UserLoginSuccessStates extends MainStates {
  final LoginModel loginModel;

  UserLoginSuccessStates(this.loginModel);
}

class UserLoginErrorStates extends MainStates {
  final String error;

  UserLoginErrorStates(this.error);
}

class UserUpdateLoadingStates extends MainStates {}

class UserUpdateSuccessStates extends MainStates {
  final LoginModel loginModel;

  UserUpdateSuccessStates(this.loginModel);
}

class UserUpdateErrorStates extends MainStates {
  final String error;

  UserUpdateErrorStates(this.error);
}

class HomeLoadingStates extends MainStates {}

class HomeSuccessStates extends MainStates {}

class HomeErrorStates extends MainStates {}

class FavoritesLoadingStates extends MainStates {}

class GetFavoritesSuccessStates extends MainStates {}

class GetFavoritesErrorStates extends MainStates {}

class ChangeFavoritesStates extends MainStates {}

class ChangeFavoritesSuccessStates extends MainStates {
  final ChangeFavoritesModel model;

  ChangeFavoritesSuccessStates(this.model);
}

class ChangeFavoritesErrorStates extends MainStates {}

class ProductLoadingStates extends MainStates {}

class ProductSuccessStates extends MainStates {
  final ProductResponse productResponse;

  ProductSuccessStates(this.productResponse);
}

class ProductErrorStates extends MainStates {}

class CategoriesSuccessStates extends MainStates {}

class CategoriesErrorStates extends MainStates {}

class CategoryDetailsLoadingStates extends MainStates {}

class CategoryDetailsSuccessStates extends MainStates {}

class CategoryDetailsErrorStates extends MainStates {}

class CartLoadingStates extends MainStates {}

class GetCartSuccessStates extends MainStates {}

class GetCartErrorStates extends MainStates {}

class ChangeCartStates extends MainStates {}

class ChangeCartSuccessStates extends MainStates {
  final ChangeCartModel model;

  ChangeCartSuccessStates(this.model);
}

class ChangeCartErrorStates extends MainStates {}

class UpdateCartLoadingStates extends MainStates {}

class UpdateCartSuccessStates extends MainStates {}

class UpdateCartErrorStates extends MainStates {}

class ShowPasswordStates extends MainStates {}

class ChangeNavBarItem extends MainStates {}

class FaqLoadingStates extends MainStates {}

class GetFaqSuccessStates extends MainStates {}

class GetFaqErrorStates extends MainStates {}

class NotificationLoadingStates extends MainStates {}

class GetNotificationSuccessStates extends MainStates {}

class GetNotificationErrorStates extends MainStates {}

class ProfileImagePickedSuccessState extends MainStates {}

class ProfileImagePickedErrorState extends MainStates {}

class SearchLoadingStates extends MainStates {}

class SearchSuccessStates extends MainStates {}

class SearchErrorStates extends MainStates {}

class OnPageChangeState extends MainStates {}

class AddAddressLoadingState extends MainStates {}

class AddAddressSuccessState extends MainStates {}

class AddAddressErrorState extends MainStates {
  final String error;

  AddAddressErrorState(this.error);
}

class AddOrderLoadingState extends MainStates {}

class AddOrderSuccessState extends MainStates {}

class AddOrderErrorState extends MainStates {
  final String error;

  AddOrderErrorState(this.error);
}

class GetOrdersLoadingState extends MainStates {}

class GetOrdersSuccessState extends MainStates {}

class GetOrdersErrorState extends MainStates {
  final String error;

  GetOrdersErrorState(this.error);
}

class CancelOrdersLoadingState extends MainStates {}

class CancelOrdersSuccessState extends MainStates {}

class CancelOrdersErrorState extends MainStates {
  final String error;

  CancelOrdersErrorState(this.error);
}

class ChangePasswordLoadingState extends MainStates {}

class ChangePasswordSuccessState extends MainStates {
  final ChangePasswordModel changePasswordModel;

  ChangePasswordSuccessState(this.changePasswordModel);
}

class ChangePasswordErrorState extends MainStates {
  final String error;

  ChangePasswordErrorState(this.error);
}
