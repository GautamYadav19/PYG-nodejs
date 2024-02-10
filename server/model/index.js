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
rootdb.getlist = () => {
  return new Promise((resolve, reject) => {
    pool.query("select * from product_table", (err, result) => {
      if (err) {
        return reject(err);
      }
      return resolve(result);
    });
  });
};

rootdb.CreateProduct = (input) => {
  let dummyList = "";
  for (let i = 0; i < input.desc.dlist.length; i++) {
    dummyList = dummyList + input.desc.dlist[i] + ",&,";
  }
  let dummyHeader = "";
  let dummyDes = "";
  for (let i = 0; i < input.desc.dtable.length; i++) {
    dummyHeader = dummyHeader + input.desc.dtable[i].header + ",&,";
    dummyDes = dummyDes + input.desc.dtable[i].des + ",&,";
  }
  return new Promise((resolve, reject) => {
    let sql1 = "insert into image_table(path,created_at) value(?,now())";

    pool.query(sql1, input.image, (err, image_id) => {
      if (image_id) {
        let sql2 =
          "insert into tablesformate_table(headerName,description,created_at)values(?,?,now());";
        pool.query(sql2, [dummyHeader, dummyDes], (err, tableFormate_id) => {
          if (tableFormate_id) {
            // sql2
            let sql3 =
              "insert into listformate_table(description,created_at)values(?,now());";
            pool.query(sql3, [dummyList], (err, list_id) => {
              if (list_id) {
                // sql3
                let sql4 =
                  "insert into description_table(tableFormateId,listFormateId,created_at) values(?,?,now());";
                pool.query(
                  sql4,
                  [tableFormate_id.insertId, list_id.insertId],
                  (err, desc_id) => {
                    if (desc_id) {
                      //sql4
                      let sql5 =
                        "insert into product_inventory(quantity,warranty,created_at) values(?,?,now());";
                      pool.query(
                        sql5,
                        [input.inventory.quantity, input.inventory.warranty],
                        (err, inventory_id) => {
                          if (inventory_id) {
                            //sql5
                            let sql6 =
                              "insert into price_compare_table(fixedPrice,fakePrice,created_at) values(?,?,now());";
                            pool.query(
                              sql6,
                              [input.price.realprice, input.price.fakeprice],
                              (err, price_compare_id) => {
                                if (price_compare_id) {
                                  //sql6
                                  console.log(input.Category);
                                  let sql7 =
                                    "insert into product_table(name,category,tax,description_ID,inventory_ID,price_compare_ID,discount_ID,image_ID,created_at) values(?,?,?,?,?,?,?,?,now());";
                                  pool.query(
                                    sql7,
                                    [
                                      input.pname,
                                      input.Category,
                                      input.price.tax,
                                      desc_id.insertId,
                                      inventory_id.insertId,
                                      price_compare_id.insertId,
                                      null,
                                      image_id.insertId,
                                    ],
                                    (err, result) => {
                                      if (err) {
                                        return reject(err);
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
      return resolve(true);
    });
  });
};

module.exports = rootdb;
