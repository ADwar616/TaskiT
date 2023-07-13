const express=require('express');

//using router of express instead of app
const router=express.Router();

const Note=require('./../models/note');

//Notes Route (/)
//:userid is a parameter
router.get("/list", async function (req, res) {
  //find and store any note type found in the database
  //await-> wait for note.find() to get finished (make the function asynsronous to use this function)
  var notes = await Note.find({ userid: req.body.userid });
  res.json(notes);
});

router.post("/add", async function (req, res) {
  await Note.deleteOne({ id: req.body.id });

  const newNote = new Note({
    id: req.body.id,
    userid: req.body.userid,
    title: req.body.title,
    content: req.body.content,
  });
  await newNote.save();

  const response = { message: "New Note Created!" + `id: ${req.body.id}` };
  res.json(response);
});

router.post("/delete", async function (req, res) {
  await Note.deleteOne({ id: req.body.id });
  const response = { message: "Note Deleted" + `id: ${req.body.id}` };
  res.json(response);
});


//export the router
module.exports=router;