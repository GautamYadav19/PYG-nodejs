const express = require("express");
const router = express.Router();
const controller = require('../controllers/index')
const db = require("../model/index");

router.post("/login", async function (req, res, next) {
    try {
      let { username, password } = req.body;
      let results = await db.login(username, password);
      res.json(results);
    } catch (error) {
      res, send({ status: 0, error: error });
    }
  });
  router.post("/register", async (req, res, next) => {
    try {
      console.log();
      let results = await db.registeration(req.body);
      res.json(results);
    } catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
  });

  
router.post("/createproduct",controller.createProduct)
router.get("/getproductlist",controller.getProductList)

module.exports= router