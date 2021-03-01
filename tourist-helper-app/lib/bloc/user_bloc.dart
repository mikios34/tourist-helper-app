import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tourist_helper/bloc/user_event.dart';
import 'package:flutter_tourist_helper/models/user.dart';
import 'package:flutter_tourist_helper/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  
  final UserRepository userRepository;

  UserBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(UserLoading());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoad) {
      yield UserLoading();
      try {
        final users = await userRepository.getUsers();
        yield UsersLoadSuccess(users);
      } catch (_) {
        yield UserOperationFailure();
      }
    }

    if (event is UserCreate) {
      try {
        await userRepository.createUser(event.user);
        final users = await userRepository.getUsers();
        yield UsersLoadSuccess(users);
      } catch (_) {
        yield UserOperationFailure();
      }
    }

    if (event is UserLogin) {
      print("trying");
      try {
        await userRepository.loginUser(event.user);
        
        //final users = await userRepository.getUsers();
        List<User>  u= [User(email: "dd")];
        print("succes");
        yield UsersLoadSuccess(u);
        
      } catch (_) {
        print("failed");
        yield UserOperationFailure();
        
      }
    }

    if (event is UserUpdate) {
      try {
        await userRepository.updateUser(event.user);
        final places = await userRepository.getUsers();
        yield UsersLoadSuccess(places);
      } catch (_) {
        yield UserOperationFailure();
      }
    }

    if (event is UserDelete) {
      try {
        await userRepository.deleteUser(event.user.id);
        final places = await userRepository.getUsers();
        yield UsersLoadSuccess(places);
      } catch (_) {
        yield UserOperationFailure();
      }
    }
  }
}