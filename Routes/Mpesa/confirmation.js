const express = require("express");
var mysql = require("mysql");
var config = require("../../DB");

var con = mysql.createPool(config);
const confirmation = express.Router();
confirmation.get("/", (req, res) => {
  res.json({
    success: false,
    message: " err.message"
  });
});
confirmation.post("/", (req, res) => {
  console.log(req);
  let data = {
    TransactionType: req.body.TransactionType,
    TransID: req.body.TransID,
    TransTime: req.body.TransTime,
    TransAmount: req.body.TransAmount,
    BusinessShortCode: req.body.BusinessShortCode,
    BillRefNumber: req.body.BillRefNumber,
    InvoiceNumber: req.body.InvoiceNumber,
    OrgAccountBalance: req.body.OrgAccountBalance,
    ThirdPartyTransID: req.body.ThirdPartyTransID,
    MSISDN: req.body.MSISDN,
    FirstName: req.body.FirstName,
    MiddleName: req.body.MiddleName,
    LastName: req.body.LastName
  };
  con.getConnection(function(err, connection) {
    if (err) {
      // res.json({
      //   success: false,
      //   message: err.message
      // });
    } // not connected!
    else {
      let sp = "call SaveMpesaTransactions(?,?,?,?,?,?,?,?,?,?,?,?,?)";
      connection.query(sp, data, function(error, results, fields) {
        console.log(data);
        if (error) {
          console.log(error.message);
          // res.json({
          //   success: false,
          //   message: error.message
          // });
        } else {
          res.json({
            ResultCode: 0,
            ResultDesc: "success",
            ThirdPartyTransID: 0
          });
        }
        connection.release();
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});
module.exports = confirmation;
