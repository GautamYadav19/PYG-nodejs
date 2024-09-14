const express = require("express");
const apiRouter = require("./routes");
const cors = require("cors");
const bodyparser = require("body-parser");
const app = express();
app.use(bodyparser.json());
app.use(
  bodyparser.urlencoded({
    extended: false,
  })
);
app.use(cors());
app.use(express.json());
app.use("/api", apiRouter);
app.listen(process.env.PORT || "3000", () => {
  console.log(`server is running on port ${process.env.PORT || "3000"}`);
});

// hi