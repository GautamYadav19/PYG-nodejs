const {host,database,user,password,port} =process.env

const mysql = require("mysql2");
const getPool = async ()=>{
    const pool =null;

    try {
    
       pool =mysql.createPool({
            host:host,
            user:user,
            database:database,
            password:password,
            port:port,
        });
        return pool;
        } catch (error) {
        return {error:error,errormessage:"database connection problem"}    
        }
        
           
}
module.exports.getPool=getPool


