const Post = require('../models/post');
const express = require('express');
const router = express.Router();
const verifytoken = require('../helper/verify-token');
const jwt = require('jsonwebtoken');
const expressJwt = require('express-jwt');
const multer = require('multer');
const mongose = require('mongoose');
const Comment = require('../models/comments');

const FILE_TYPE_MAP = {
    'image/png': 'png',
    'image/jpeg': 'jpeg',
    'image/jpg': 'jpg'
}


const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        const isValid = FILE_TYPE_MAP[file.mimetype];
        let uploadError = new Error('invalid image type');

        if(isValid) {
            uploadError = null
        }
      cb(uploadError, 'public/uploads')
    },
    filename: function (req, file, cb) {
        
      const fileName = file.originalname.split(' ').join('-');
      const extension = FILE_TYPE_MAP[file.mimetype];
      cb(null, `${fileName}-${Date.now()}.${extension}`)
    }
  })


  const uploadOptions = multer({ storage: storage })



const secret = process.env.SECR;
router.get('/', async (req,res)=>{
    
    const user = await Post.find();
    res.send(user);
})
// router.get('/', verifytoken, async (req,res)=>{
//     jwt.verify(req.token,secret,(err,authData)=>{
//         if(err){
//             console.log(req.token);
//             res.json({
//                 error:err
//             });
//         }else{
//             res.send('working')
//         }
//     });
//     const list =await Post.find();
//     //res.send(list);
//})


router.get('/:id',async(req,res)=>{
    const list = await Post.findById(req.params.id);
    if(!list){
        res.status(200).json({succes:FinalizationRegistry,message:'the post with the given id not found'});
    }
    res.send(list);    
})

router.post('/', uploadOptions.single('image') ,async (req,res)=>{
    console.log(await req.body);
    console.log("testingggg");
    // const commentsIds = Promise.all(req.body.comments.map(async comment =>{
    //     let newComment = new Comment({
    //         comment: comment.comment
    //     })

    //     newComment = await newComment.save();

    //     return newComment._id;
    // })
    // )

    //const commentsidResolved = await commentsIds;
    //console.log(commentsidResolved);
    //const fileName = req.file.filename;
    //const basePath = `${req.protocol}://${req.get('host')}/public/uploads/`;
    //const file = req.file;
    //if(!file) return res.status(400).send('There is no file');
    const post = new Post({
        
        //comment: commentsidResolved,
        title: req.body.title,
        //image: `${basePath}${fileName}`,
        description: req.body.description,
        date: req.body.date,
        rating: req.body.rating,
        category: req.body.category,
        id: req.body.id,
    })
    post.save().then((createdproduct =>{
        res.status(201).json(createdproduct)
    })).catch((err)=>{
        res.status(500).json({
            error:err,
            succes: false,
        })
    })
})

router.delete('/:id',(req,res)=>{
    Post.findByIdAndRemove(req.params.id).then((post)=>{
        if(post){
            return res.status(200).json({succes:true,message:'deleted succesfully'});
        }else{
            return res.status(404).json({succes:false,message:'delete unseccusfull'});
        }
    }).catch((err)=>{
        return res.status(400).json({succes:false,error:err});
    })
})

router.put('/:id', async(req,res)=>{

    console.log(req.body)
    const data = await Post.findByIdAndUpdate(req.params.id,{
        description: req.body.description,
        title: req.body.title,
        category: req.body.category
        
    })
    if(!data){
        return res.status(200).json({succes:FinalizationRegistry,message:'the data with the given id not found'});
    }
    res.send(data);  

})


router.put(
    '/gallery-images/:id', 
    uploadOptions.array('images', 10), 
    async (req, res)=> {
        console.log(req.body);
        if(!mongose.isValidObjectId(req.params.id)) {
            return res.status(400).send('Invalid Product Id')
         }
         //const files = req.files
        //  let imagesPaths = [];
        //  const basePath = `${req.protocol}://${req.get('host')}/public/uploads/`;

        //  if(files) {
        //     files.map(file =>{
        //         imagesPaths.push(`${basePath}${file.filename}`);
        //     })
        //  }

         const product = await Product.findByIdAndUpdate(
            req.params.id,
            {
                description:req.body.description,
                //images: imagesPaths
            },
            { new: true}
        )

        // if(!product)
        //     return res.status(500).send('the gallery cannot be updated!')

        res.send(product);
    }
)

module.exports = router;