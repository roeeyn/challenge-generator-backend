const dotenv = require("dotenv");
dotenv.config();

const app = require("express")();
const cors = require("cors");
const bodyParser = require("body-parser");
const PORT = process.env.PORT || 5000;

const { main } = require("./src/challengeGenerator");

const { connect2db } = require("./db/db.js");

connect2db()
  .then(async dbConnection => {
    console.log("Connected to the DB");

    app.use(cors());
    app.use(bodyParser.json());

    app.get("/", (req, res) => res.send("Todo al 100 en el server"));

    app.get("/getChallenges", main);

    app.listen(PORT, () => console.log(`Server running at port ${PORT}`));
  })
  .catch(err => console.log(err));
