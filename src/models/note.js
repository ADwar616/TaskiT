const mongoose=require('mongoose');

const noteSchema=mongoose.Schema({
    id:{
        type: String,
        unique: true,
        required: true,
    },
    userid:{
        type: String,
        required: true,
    },
    title:{
        type: String,
        required: true,
    },
    content:{
        type: String,
    },
    dateadded:{
        type: Date,
        //if any date value is not given
        default: Date.now,
    }
});

//model needs to be exported first in order to be used in other files
module.exports=mongoose.model("Note",noteSchema);