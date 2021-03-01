const mongose = require('mongoose');

const userSchema = mongose.Schema({
    name:{
        type:String,
        required: true
    },
    email:{
        type:String,
        required:true,
    },
    phone:{
        type:String,
        required:true,
    },
    passwordHash:{
        type: String,
        required: true,
    },
    isAdmin:{
        type:Boolean,
        default: false,
    }
})

userSchema.virtual('id').get(function(){
    return this._id.toHexString();
});
userSchema.set('toJSON',{
    virtuals: true
})


const User = mongose.model('User',userSchema);
module.exports = User;