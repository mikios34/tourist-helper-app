const expressJwt = require('express-jwt');

 let jw = expressJwt({
        
       secret: 'secrettt',
       algorithms: ['HS256'],
       isRevoked: isRevoked
    }).unless({
        path: [
            {url:/\/public\/uploads(.*)/ ,method:['GET'] },
            //{url:/\/posts\/(.*)/ ,method:['GET','OPTIONS'] },
            '/posts',
            '/user',
            '/user/login',
            '/user/register'
            
        ]
    })

async function isRevoked(req, payload, done){
    if(!payload.isAdmin){
        done(null, true)
    }
    done();
}

module.exports = jw;