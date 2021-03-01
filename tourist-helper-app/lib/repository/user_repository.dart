import 'package:flutter_tourist_helper/data_provider/data_provider.dart';
import 'package:flutter_tourist_helper/models/models.dart';

class UserRepository {
  final UserDataProvider dataProvider;

  UserRepository({this.dataProvider}): 
      assert(dataProvider != null);

  Future<User> createUser(User user) async {
    return await dataProvider.createUser(user);
  }
  Future<User> loginUser(User user) async {
    return await dataProvider.loginUser(user);
  }

  Future<List<User>> getUsers() async{
    return await dataProvider.getUser();
  }

  Future<void> updateUser(User user) async {
    await dataProvider.updateUser(user);
  }

  Future<void> deleteUser(String id) async {
    await dataProvider.deleteUser(id);
  }
}