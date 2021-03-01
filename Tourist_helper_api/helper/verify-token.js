function verifytoken(req, res, next){
    const bearerHeader = req.headers['authorization'];

    if(typeof bearerHeader !== 'undefined'){

        //console.log(bearerHeader);
        const bearer = bearerHeader.split(' ');

        const bearerToken = bearer[1];
        console.log(bearerToken);
        req.token = bearerToken;
        next();

    }else{
        res.sendStatus(403);
    }
}

module.exports = verifytoken;