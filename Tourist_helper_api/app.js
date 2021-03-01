const express = require('express');
require('dotenv/config');
const bodypareser = require('body-parser');
const mongose = require('mongoose');
const app = express();
const authJwt = require('./helper/jwt');
const errorHandler = require('./helper/error-handler');


const expressJwt = require('express-jwt');

//authJwt;

app.use(bodypareser.json());
// app.use(expressJwt({
//     secret: process.env.SECR,
//     algorithms: ['HS256']
// }))

app.use(authJwt);
app.use(errorHandler)
app.use('/public/uploads', express.static(__dirname + '/public/uploads'));


const commentRoute = require('./routers/comments');
const postRout = require('./routers/posts');
const userRout = require('./routers/users');
//const chatRout = require('./routers/chats');
//const jwtAuth = require('./helper/jwt');





//app.use(errorHandler);
app.use('/posts',postRout);
app.use('/user', userRout);
app.use('/comments',commentRoute);
//app.use('/user', chatRout);

//midleware



mongose.connect('mongodb://127.0.0.1:27017/Tourist_Helper',{
    keepAlive: true,
  useNewUrlParser: true,
  useCreateIndex: true,
  useFindAndModify: false,
    
    useNewUrlParser: true,
    useUnifiedTopology: true,
    dbName: 'Tourist_Helper'
}).then(()=>{
    console.log('conection has been made');
}).catch((error)=>{
    console.log('error');
})


//  app.listen(3011,()=>{
//     console.log("server started at https://localhost:3000");
// })
app.listen(3011,'10.6.198.159' || 'localhost',function() {
    console.log('Application worker ' + process.pid + ' started...');
  }
);