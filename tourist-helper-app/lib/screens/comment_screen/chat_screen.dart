import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tourist_helper/bloc/bloc.dart';
import 'package:flutter_tourist_helper/models/models.dart';
import 'package:flutter_tourist_helper/screens/comment_screen/update_chat.dart';
import 'package:flutter_tourist_helper/screens/place_routes.dart';


class ChatScreen extends StatefulWidget {
  static const routeName = '/comment';
  //final PlaceArgument args;
  final Place place;
  ChatScreen({this.place});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController desc = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _course = {};
  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<ChatBloc>(context).add(ChatLoad());
    BlocProvider.of<ChatBloc>(context).add(ChatLoadbyId(widget.place));
    print("___________________________________________");
    print(widget.place.title);
    print("___________________________________________");
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text('List of chats')),
        
      ),
      body: Column(
        children: [
          newMethod(context),
      TextFormField(
        controller: desc,
         onSaved: (value) {
                      this._course["description"] = value;
                    },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefix: IconButton(
                    icon: Icon(Icons.image),
                    onPressed: (){
                      
                    },
                  ),
                  suffix: IconButton(
                    icon: Icon(Icons.send),
                    
                    onPressed: (){
                      print("------------------------------------------------------------------");
                       final form = _formKey.currentState;
                    
                      //form.save();
                      final ChatEvent event = ChatCreate(
                              Chat(
                                //image: this._course["image"],
                                post_id: widget.place.id,
                                comment: desc.text
                                
                              ),
                            );
                    
                      BlocProvider.of<ChatBloc>(context).add(event);
                      BlocProvider.of<ChatBloc>(context).add(ChatLoad());
                      desc = TextEditingController(text: '');
                     }
                    ,
                  ),
                  hintText: 'Message' ,

                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
        ],
      ),
      
      
      
        
        
        
      );
      
  }

  BlocBuilder<dynamic, ChatState> newMethod(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (_, state) {
        if (state is ChatOperationFailure) {
          return Text('Could not do chat operation');
        }

        if (state is ChatsLoadSuccess) {
          print('---------------------fas-dfas-dfa-sd-f-------------fasd-fa-sdf-asd-fas--------');
          final places = state.chats;
          print(places[0].comment);

          
             
             return Expanded(
               child: ListView.builder(
            itemCount: places.length,
            itemBuilder: (_, idx) => Card(
                child: makeCards(places, idx,context),
            ),
           
           ),
             );
           
            
          
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget makeCards(List<Chat> chats,int id,BuildContext ctx){
   // PageController pageController;
    //List<Post> posts;

   

    //   _buildPost(BuildContext context, int index) {
    // //Post post = posts[index];
    return  Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: 100,
      
      child: Stack(
          children: <Widget>[
            
            Positioned(
              left: 10.0,
              bottom: 10.0,
              right: 10.0,
              child: Container(
                padding: EdgeInsets.all(12.0),
                height: 110.0,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      //"miki",
                      '${chats[id].comment}',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.red,
                            ),
                            onPressed: (){
                              Navigator.of(context)
                              .pushNamed(UpdateChat.routeName, arguments: ChatArgument(chat: chats[id],edit: true));
                            },
                            ),
                            SizedBox(width: 6.0),
                            IconButton(
                              onPressed: (){
                               
                               context.read<ChatBloc>().add(ChatDelete(chats[id]));
                                BlocProvider.of<ChatBloc>(context).add(ChatLoad());
                            
                              }, 
                              icon: Icon(Icons.delete),
                              //child: Text("Vote"),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
      //  ),
      ),
    );



    
  }
}