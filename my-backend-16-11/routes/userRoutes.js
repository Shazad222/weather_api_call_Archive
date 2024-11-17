const express = require("express");
const { getAllUsers, createUser } = require("../controllers/userController"); // Ensure these are correctly exported and exist

const router = express.Router();

router.get("/", getAllUsers); // Ensure this is a valid function
router.post("/", createUser); // Ensure this is a valid function

module.exports = router;
