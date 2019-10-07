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
      .min(1),
    AmountDue: Joi.number()
    .min(1),
    EntryType: Joi.string()
      .min(3)
      .required(),
    RefNo: Joi.string()
      .min(3)
      .required()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationID,
      req.body.EntryType,
      req.body.AmountDue,
      req.body.RefNo,
      res.locals.user
    ];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call SaveApplicationFees(?,?,?,?,?)";
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
applicationfees.put("/:ID", auth.validateRole("Applications"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    EntryType: Joi.string()
      .min(3)
      .required(),
    AmountDue: Joi.number().min(1)
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    const ID = req.params.ID;
    let data = [ID, req.body.EntryType, req.body.AmountDue, res.locals.user];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call UpdateApplicationFees(?,?,?,?)";
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
  } else {
    res.json({
      success: false,
      message: result.error.details[0].message
    });
  }
});

module.exports = applicationfees;
