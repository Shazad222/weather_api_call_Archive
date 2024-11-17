const express = require("express");
const dotenv = require("dotenv");
const userRoutes = require("./routes/userRoutes");

// load environment variables
dotenv.config();

// initialize express
const app = express();
const PORT = process.env.PORT || 5000;

// Middleware to parse JSON
app.use(express.json());

// Routes
app.use("/api/users", userRoutes);

// default route

app.get("/", (req, res) => {
  res.send("Api is running ..");
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
