const express = require('express');
const router = express.Router();
const Comment = require('../models/comments');
const Post = require('../models/post');
//const Post = 
router.get('/', async (req,res)=>{
    
    const list =await Comment.find();
    res.send(list);
})

router.get('/:id',async(req,res)=>{

    const list = await Comment.find({post_id : req.params.id});
    if(!list){
        res.status(200).json({succes:false,message:'the post with the given id not found'});
    }
    res.send(list);    
})


router.post('/do-comment',async (req,res)=>{
     newComment = new Comment({
        post_id: req.body.post_id,
        comment: req.body.comment,
    })

    newComment = await newComment.save();
    
        
    // const data = await Post.findByIdAndUpdate(req.body.post_id,{
    //     "$push":{"comment":[newComment._id]},
    //    // comment: ,
    //     //title: "miki",        
    // }
    //)
    if(!newComment){
        return res.status(200).json({succes:FinalizationRegistry,message:'the data with the given id not found'});
    }
    res.send(newComment);


})

module.exports = router;




// {
//     "comments":[
//         {
//             "comment":"good"
//         },
//         {
//             "comment":"very nddice"
//         }
//     ],
//     "title": "Abebeeeee",
//     "description": "lorem ipsem mdkfaksdfam  dsfhbhewb wejjqhjwer sdf",
//     "category": " nothing"
    
// }