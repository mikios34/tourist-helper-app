const User = require('../models/user')
const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

router.get('/', async (req,res)=>{
    const list =await User.find();
    res.send(list);
})

router.post('/register',(req,res)=>{
    const user =  new User({
        name: req.body.name,
        phone: req.body.phone,
        email: req.body.email,
        passwordHash: bcrypt.hashSync(req.body.password, 10),
        isAdmin: req.body.isAdmin,
    })
    user.save().then((createdUser =>{
        res.status(201).json(createdUSer)
    })).catch((err)=>{
        res.status(500).json({
            error:err,
            succes: false,
        })
    })
})

router.post('/login', async(req,res)=>{
    const user = await User.findOne({email: req.body.email});

    if(!user){
        return res.status(400).send('The user not found');
    }
    //return res.status(200).send(user);

    if(user && bcrypt.compareSync(req.body.password, user.passwordHash)){
        const secret = process.env.SECR;
        const token = jwt.sign(
            {
                userId: user.id,
                isAdmin: user.isAdmin,
            },
            secret,
            {expiresIn : '1d'}
        )

        res.status(200).send({user:user.email, token:token})
    }else{
        res.status(400).send('password wrong') 
    }
    

})


module.exports = router;