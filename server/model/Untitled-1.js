const mysql = require("mysql2");
const jwt = require("jsonwebtoken");
const e = require("express");
const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  database: "ecommerce",
  password: "mysql@123",
  port: 3306,
});
let rootdb = {};

rootdb.login = (username, password) => {
  return new Promise((resolve, reject) => {
    pool.query(
      `SELECT * FROM users WHERE (username = ?) AND password = ?`,
      [username, username, password],
      (err, results) => {
        if (err) {
          console.log(err);

          return reject(err);
        } else if (!results.length) {
          console.log("else if  ", results);
          pool.query(
            `select count(1) from users where username =?`,
            [username],
            (err, result) => {
              if (err) {
                return reject({ status: 0, data: err });
              }
              return resolve({
                status: 0,
                data: ["Incorrect_password"],
              });
            }
          );
          return resolve({
            status: 0,
            data: ["No_user_exist"],
          });
        } else {
          // console.log("else ", results);
          let token = jwt.sign({ data: results }, "secret");
          const user = { status: 1, data: results, token: token };
          return resolve(user);
        }
      }
    );
  });
};
rootdb.registeration = (input) => {
  var sql = `Insert Into users (username, password) VALUES ( ?, ?, ? )`;
  console.log(input);
  return new Promise((resolve, reject) => {
    pool.query(
      `SELECT username FROM users WHERE username = ?`,
      [input.username],
      (err, results) => {
        if (err) {
          return reject({ status: 0, data: err });
        } else if (!results.length) {
          console.log("else if  ", results);
          pool.query(sql, [input.username, input.password], (err, result) => {
            if (err) {
              return reject({ status: 0, data: err });
            }
            let token = jwt.sign({ data: result }, "secret");
            return resolve({ status: 1, data: result, token: token });
          });
        } else {
          console.log("else if  ", results);
          return resolve({ status: 0, data: "username already exist" });
        }
      }
    );
  });
};
rootdb.getlist=()=>{
  return new Promise((resolve,reject)=>{
    pool.query('select * from product_table',(err,result)=>{
      if(err){
        return reject(err)
      }
      return resolve(result)
    })
  })
}

rootdb.CreateProduct = (input) => {
  // console.log(input)
  
  return new Promise((resolve, reject) => {
    let sql1 = "insert into image_table(path,created_at) value(?,now())";
    pool.query(sql1, input.image, (err, result1) => {
      if (result1) {
        let sql2 =
          "insert into tablesformate_table(headerName,description,created_at)values(?,?,now());";
        pool.query(sql2, [input.header, input.desc], (err, result2) => {
          if (result2) {
            // sql2
            let sql3 =
              "insert into listformate_table(description,created_at)values(?,now());";
            pool.query(sql3, [input.dlist], (err, result3) => {
              if (result3) {
                // sql3
                let sql4 =
                  "insert into description_table(tableFormateId,listFormateId,created_at) values(?,?,now());";
                pool.query(
                  sql4,
                  [result2.insertId, result3.insertId],
                  (err, result4) => {
                    if (result4) {
                      //sql4
                      let sql5 =
                        "insert into product_inventory(quantity,warranty,created_at) values(?,?,now());";
                      pool.query(
                        sql5,
                        [input.quantity, input.warranty],
                        (err, result5) => {
                          if (result5) {
                            //sql5
                            let sql6 =
                              "insert into price_compare_table(fixedPrice,fakePrice,created_at) values(?,?,now());";
                            pool.query(
                              sql6,
                              [input.fixedPrice, input.fakePrice],
                              (err, result6) => {
                                if (result6) {
                                  //sql6
                                  let sql7 =
                                    "insert into product_table(name,category,tax,description_ID,inventory_ID,price_compare_ID,discount_ID,image_ID,created_at) values(?,?,?,?,?,?,?,?,now());";
                                  pool.query(
                                    sql7,
                                    [
                                      input.pname,
                                      input.category,
                                      input.tax,                                      
                                      result4.insertId,
                                      result5.insertId,
                                      result6.insertId,
                                      null,
                                      result1.insertId,
                                    ],
                                    (err, result) => {
                                      if (result) {
                                        return resolve(true);
                                      }
                                    }
                                  );
                                }
                              }
                            );
                          }
                        }
                      );
                    }
                  }
                );
              }
            });
          }
        });
      }
      return reject(err);
    });
  });
};
module.exports = rootdb;
