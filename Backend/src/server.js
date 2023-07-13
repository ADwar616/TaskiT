//Initialization
const express = require("express");
const app = express();

const mongoose = require("mongoose");
const Note=require('./models/note');

const bodyParser=require('body-parser');
app.use(bodyParser.urlencoded({extended:false}));
//if extended:true->Nested Objects(Correct)
//if extended:false->Nested Objects(Not Correct)

app.use(bodyParser.json());

mongoose
  .connect(
    "mongodb+srv://ADwar616:J9rwAawVx99uor5j@cluster0.iqkqehv.mongodb.net/notesdb"
  )
  .then(function () {
    //Home Route (/)
    app.get("/", function (req, res) {
        const response={message: "API Works!"};
        res.json(response);
    });

    //importing noteRouter
    const noteRouter=require('./routes/note');
    //URL becomes /notes/notes/add or /notes/notes/delete
    app.use("/notes", noteRouter)

  });

//Starting the server on a PORT
app.listen(5000, function () {
  console.log("Server started at PORT: 5000");
});
