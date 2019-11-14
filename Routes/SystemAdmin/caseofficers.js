var express = require("express");
var caseofficers = express();
var mysql = require("mysql");
var config = require("../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("../../auth");
caseofficers.get("/", auth.validateRole("Case officers"), function(req, res) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetAllCaseOfficers()";
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
caseofficers.get("/:ID", auth.validateRole("Case officers"), function(
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
      let sp = "call getOneCaseOfficer(?)";
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
caseofficers.post("/", auth.validateRole("Case officers"), function(req, res) {
  const schema = Joi.object().keys({
    Username: Joi.string()
      .min(3)
      .required(),

    NotAvailableFrom: Joi.date()
      .allow("")
      .allow(null),
    NotAvailableTo: Joi.date()
      .allow("")
      .allow(null),
    Active: Joi.boolean()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.Username,

      req.body.Active,
      req.body.NotAvailableFrom,
      req.body.NotAvailableTo,
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
        let sp = "call SaveCaseOfficers(?,?,?,?,?)";
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
caseofficers.put("/:ID", auth.validateRole("Case officers"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    Username: Joi.string()
      .min(3)
      .required(),

    NotAvailableFrom: Joi.date()
      .allow("")
      .allow(null),
    NotAvailableTo: Joi.date()
      .allow("")
      .allow(null),
    Active: Joi.boolean()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    const ID = req.params.ID;
    let data = [
      ID,

      req.body.Active,
      req.body.NotAvailableFrom,
      req.body.NotAvailableTo,
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
        let sp = "call UpdateCaseOfficers(?,?,?,?,?)";
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
caseofficers.delete("/:ID", auth.validateRole("Case officers"), function(
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
      let sp = "call DeleteCaseOfficers(?,?)";
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
module.exports = caseofficers;
