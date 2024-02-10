const model =require('../model/index');

let controller ={};

controller.login= async(req,res)=>{
    try {
        let { username, password } = req.body;
        let results = await db.login(username, password);
        res.json(results);
      } catch (error) {
        res, send({ status: 0, error: error });
      }
}

controller.getCategoriesList= async(req,res)=>{
    try {
        let result = await model.getCategoriesList()
        // if (result.length == 0 ? res.status(404).json({ error: "data not found" }) :
         res.status(200).json(result)
        //  );
    } catch (error) {
        res.status(500).json(error)
    }
}
controller.createProduct = async (req,res)=>{
    try {
        console.log("from controller",req.body)
        let result =await model.CreateProduct(req.body)
        res.status(200).json(result)
    } catch (error) {
        res.status(500).json(error)
    }
}

controller.getList =async (req,res)=>{
    try {
        let result = await model.getlist()
        res.status(200).json(result)
    } catch (error) {
        res.status(500).json(error)
        
    }
}
module.exports =controller;