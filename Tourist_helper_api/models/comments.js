const mongose = require('mongoose');


const commentSchema = mongose.Schema({
    userId:{
        type:mongose.Schema.Types.ObjectId,
        ref: 'user',
        //required: true
    },
    comment:{
        required: true,
        type: String
    },
    post_id:{
        required: true,
        type: String
    }
})

const Comment = mongose.model('Comment',commentSchema);


module.exports = Comment;