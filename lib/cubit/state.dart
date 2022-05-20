

import 'package:mego_market/model/cart/add_cart_model.dart';
import 'package:mego_market/model/favorite/favorite_model.dart';
import 'package:mego_market/model/home/home_model.dart';
import 'package:mego_market/model/login/login_model.dart';

abstract class MainStates {}

class MainInitialStates extends MainStates {}


////////////////////// User ///////////////////////////////

class UserLoginLoadingStates extends MainStates {}

class UserLoginSuccessStates extends MainStates {

  final LoginModel  loginModel;

  UserLoginSuccessStates(this.loginModel);
}

class UserLoginErrorStates extends MainStates {
  final String error;

  UserLoginErrorStates( this.error);
}

class UserUpdateLoadingStates extends MainStates {}

class UserUpdateSuccessStates  extends MainStates {
  final LoginModel  loginModel;

  UserUpdateSuccessStates(this.loginModel);
}

class UserUpdateErrorStates extends MainStates {
  final String error;

  UserUpdateErrorStates( this.error);
}



////////////////////// Home ///////////////////////////////

class HomeLoadingStates extends MainStates {}

class HomeSuccessStates extends MainStates {}

class HomeErrorStates extends MainStates {}

////////////////////// Favorites ///////////////////////////////

class FavoritesLoadingStates extends MainStates{}

class GetFavoritesSuccessStates extends MainStates{}

class GetFavoritesErrorStates extends MainStates{}

class ChangeFavoritesStates extends MainStates{}

class ChangeFavoritesSuccessStates extends MainStates
{
  final  ChangeFavoritesModel model;

  ChangeFavoritesSuccessStates(this.model);

}


class ChangeFavoritesErrorStates extends MainStates{}

////////////////////// Products_Details ///////////////////////////////

class ProductLoadingStates extends MainStates{}

class ProductSuccessStates extends MainStates {
  final ProductResponse productResponse;

  ProductSuccessStates(this.productResponse);
}

class ProductErrorStates extends MainStates{}

////////////////////// Category  ///////////////////////////////

class CategoriesSuccessStates extends MainStates{}

class CategoriesErrorStates extends MainStates{}

class CategoryDetailsLoadingStates extends MainStates{}

class CategoryDetailsSuccessStates extends MainStates{}

class CategoryDetailsErrorStates extends MainStates{}

////////////////////// Cart  ///////////////////////////////

class CartLoadingStates extends MainStates{}

class GetCartSuccessStates extends MainStates{}

class GetCartErrorStates extends MainStates{}

class ChangeCartStates extends MainStates{}

class ChangeCartSuccessStates extends MainStates{

  final  ChangeCartModel model;

  ChangeCartSuccessStates(this.model);

}

class ChangeCartErrorStates extends MainStates{}

class UpdateCartLoadingStates extends MainStates{}

class UpdateCartSuccessStates extends MainStates{}

class UpdateCartErrorStates extends MainStates{}




//////////////////////   ///////////////////////////////

class ShowPasswordStates extends MainStates {}

class ChangeNavBarItem extends MainStates {}

class FaqLoadingStates extends MainStates {}

class GetFaqSuccessStates extends MainStates {}

class GetFaqErrorStates extends MainStates {}

class NotificationLoadingStates extends MainStates {}

class GetNotificationSuccessStates extends MainStates {}

class GetNotificationErrorStates extends MainStates {}







