var express = require("express");
var applicationfees = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");
applicationfees.get("/", auth.validateRole("Applications"), function(req, res) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetAllgroundsandrequestedorders()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          res.json(results[0]);
        }
        connection.release();
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});
applicationfees.get("/:ID/:Value", auth.validateRole("Applications"), function(
  req,
  res
) {
  const ID = req.params.ID;
  const Value = req.params.Value;
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      if (Value === "Bankslips") {
        let sp = "call GetBankSlips(?)";
        connection.query(sp, [ID], function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json(results[0]);
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
      if (Value === "PaymentDetails") {
        let sp = "call GetApplicationPaymentDetails(?)";
        connection.query(sp, [ID], function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json(results[0]);
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
      if (Value === "PreliminaryObjectionsFeesPaymentDetails") {
        let sp = "call GetPreliminaryObjectionsFeesPaymentDetails(?)";
        connection.query(sp, [ID], function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json(results[0]);
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
      if (Value === "PreliminaryObjectionsFees") {
        let sp = "call getPreliminaryObjections()";
        connection.query(sp, [ID], function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json(results[0]);
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
    }
  });
});
applicationfees.get("/:ID", auth.validateRole("Applications"), function(
  req,
  res
) {
  const ID = req.params.ID;
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetApplicationFees(?)";
      connection.query(sp, [ID], function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          res.json(results[0]);
        }
        connection.release();
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});
applicationfees.post("/", auth.validateRole("Applications"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    ApplicationID: Joi.number()
      .integer()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [req.body.ApplicationID, res.locals.user];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call Computefeestest(?,?)";
        connection.query(sp, data, function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json({
              success: true,
              message: "saved"
            });
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
    });
  } else {
    res.json({
      success: false,
      message: result.error.details[0].message
    });
  }
});
applicationfees.post("/:ID", auth.validateRole("Applications"), function(
  req,
  res
) {
  let data = [
    req.body.ApplicationID,
    req.body.filename,
    "uploads/BankSlips",
    res.locals.user,
    req.body.Category
  ];
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call SaveBankSlip(?,?,?,?,?)";
      connection.query(sp, data, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
          // return res.status(500).json(error.message);
        }
        connection.release();
        res.json({
          success: true
        });
        // return res.status(200).send(filename);
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});
applicationfees.post(
  "/:ID/:Paymentdetails",
  auth.validateRole("Applications"),
  function(req, res) {
    const schema = Joi.object().keys({
      Category: Joi.string().required(),
      DateOfpayment: Joi.date().required(),
      AmountPaid: Joi.number().required(),
      Reference: Joi.string().required(),
      Paidby: Joi.string().required(),
      ApplicationID: Joi.number()
        .integer()
        .min(1)
    });
    const result = Joi.validate(req.body, schema);
    if (!result.error) {
      let data = [
        req.body.ApplicationID,
        req.body.Paidby,
        req.body.Reference,
        req.body.DateOfpayment,
        req.body.AmountPaid,
        res.locals.user,
        req.body.Category
      ];
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call SavePaymentdetails(?,?,?,?,?,?,?)";
          connection.query(sp, data, function(error, results, fields) {
            if (error) {
              res.json({
                success: false,
                message: error.message
              });
              // return res.status(500).json(error.message);
            }
            connection.release();
            res.json({
              success: true
            });
            // return res.status(200).send(filename);
            // Don't use the connection here, it has been returned to the pool.
          });
        }
      });
    } else {
      res.json({
        success: false,
        message: result.error.details[0].message
      });
    }
  }
);
applicationfees.put("/:ID", auth.validateRole("Applications"), function(
  req,
  res
) {
  const ID = req.params.ID;
  let data = [ID, res.locals.user];
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call Computefeestest(?,?)";
      connection.query(sp, data, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          res.json({
            success: true,
            message: "updated"
          });
        }
        connection.release();
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});
applicationfees.delete("/:ID", auth.validateRole("Applications"), function(
  req,
  res
) {
  const ID = req.params.ID;
  let data = [ID, res.locals.user];
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call DeleteBankSlips(?,?)";
      connection.query(sp, data, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          res.json({
            success: true,
            message: "Deleted Successfully"
          });
        }
        connection.release();
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});
module.exports = applicationfees;
