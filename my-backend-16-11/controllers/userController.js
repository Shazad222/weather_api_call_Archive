const User = require("../models/userModel");

// Get all users
const getAllUsers = async (req, res) => {
  try {
    const users = await User.getAllUsers(); // Ensure User.getAllUsers() is defined in your model
    res.status(200).json(users);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

// Create a new user
const createUser = async (req, res) => {
  try {
    const { name, email } = req.body;
    const newUser = await User.createUser(name, email); // Ensure User.createUser() is defined in your model
    res.status(201).json(newUser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

// Export the functions
module.exports = {
  getAllUsers,
  createUser,
};
