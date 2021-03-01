const mongose = require('mongoose');
const productSchema = mongose.Schema({
    comment: [{
        type: mongose.Schema.Types.ObjectId,
        ref: 'comments'
    }],
    title: String,
    image:String,
    description: String,
    date: String,
    rating: String,
    category: String
    
})

const Post = mongose.model('post',productSchema);

productSchema.virtual('id').get(function(){
    return this._id.toHexString();
});
productSchema.set('toJSON',{
    virtuals: true
})
module.exports = Post;

