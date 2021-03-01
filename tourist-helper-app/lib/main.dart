import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tourist_helper/bloc/user_bloc.dart';
import 'package:flutter_tourist_helper/repository/repository.dart';
import 'package:flutter_tourist_helper/screens/add_place.dart';
import 'package:flutter_tourist_helper/screens/place_routes.dart';


import 'bloc/bloc.dart';
import 'bloc/place_bloc.dart';
import 'bloc_observer.dart';
import 'data_provider/data_provider.dart';
import 'package:http/http.dart' as http;

import 'models/place.dart';
import 'repository/place_repository.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final UserRepository placeRepository = UserRepository(
    dataProvider: UserDataProvider(
      httpClient: http.Client(),
    ),
  );
  final PlaceRepository userRepository = PlaceRepository(
    dataProvider: PlaceDataProvider(
      httpClient: http.Client(),
    ),
  );
  final ChatRepository chatRepository = ChatRepository(
    dataProvider: ChatDataProvider(
      httpClient: http.Client(),
    ),
  );

  runApp(MyApp(placeRepository: placeRepository,userRepository:userRepository,chatRepository: chatRepository,));
}

class MyApp extends StatelessWidget {
  final UserRepository placeRepository;
  final PlaceRepository userRepository;
  final ChatRepository chatRepository;

  MyApp({@required this.placeRepository, @required this.userRepository,@required this.chatRepository})
    :assert(placeRepository != null);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: this.placeRepository,),
        RepositoryProvider.value(value: this.userRepository,),
        RepositoryProvider.value(value: this.chatRepository,),
      ],
      //value: this.placeRepository,
      child: MultiBlocProvider(
        providers: [

          BlocProvider(
            create: (context) => UserBloc(userRepository: this.placeRepository),
            
          ),

         BlocProvider(
          create: (context) => PlaceBloc(placeRepository: this.userRepository)..add(PlaceLoad()),
       
          ),
          BlocProvider(
          create: (context) => ChatBloc(chatRepository: this.chatRepository),
       
          ),
          

      ],
      child: MaterialApp(
                title: 'Place App',
                theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              onGenerateRoute: PlaceRout.generateRoute,
            )
      ,),
        //   BlocProvider(
        // create: (context) => PlaceBloc(placeRepository: this.placeRepository)..add(PlaceLoad()),
        // child: MaterialApp(
        //   title: 'Place App',
        //   theme: ThemeData(
        //     primarySwatch: Colors.blue,
        //     visualDensity: VisualDensity.adaptivePlatformDensity,
        //    )
        // )
        //   ),
        //   BlocProvider(
        // create: (context) => UserBloc(userRepository: this.placeRepository),
        
        // child: MaterialApp(
        //   title: 'Place App',
        //   theme: ThemeData(
        //     primarySwatch: Colors.blue,
        //     visualDensity: VisualDensity.adaptivePlatformDensity,
        //    ),
        //    onGenerateRoute: PlaceRout.generateRoute,
        // )
        //   )
        
      
      // child: BlocProvider(
      //   create: (context) => PlaceBloc(placeRepository: this.placeRepository)..add(PlaceLoad()),
      //   child: MaterialApp(
      //     title: 'Place App',
      //     theme: ThemeData(
      //       primarySwatch: Colors.blue,
      //       visualDensity: VisualDensity.adaptivePlatformDensity,
      //     ),
      //     onGenerateRoute: PlaceRout.generateRoute,
      //   ),
      // ),
    );
    // return MaterialApp( 
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //     // This makes the visual density adapt to the platform that you run
    //     // the app on. For desktop platforms, the controls will be smaller and
    //     // closer together (more dense) than on mobile platforms.
    //     
    //   ),
    //   home: MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}





