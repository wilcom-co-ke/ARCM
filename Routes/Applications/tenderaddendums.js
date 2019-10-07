var express = require("express");
var tenderaddendums = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");
tenderaddendums.get("/", auth.validateRole("Applications"), function(req, res) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetAlltenderaddendums()";
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
tenderaddendums.get("/:ID", auth.validateRole("Applications"), function(
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
      let sp = "call GetOnetenderaddendums(?)";
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
tenderaddendums.post("/", auth.validateRole("Applications"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    TenderID: Joi.number()
      .integer()
      .min(1),
    Description: Joi.string()
      .min(3)
      .required(),
    StartDate: Joi.date().required(),
    ClosingDate: Joi.date().required(),
    AdendumNo: Joi.string()
      .min(1)
      .required()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.TenderID,
      req.body.Description,
      req.body.StartDate,
      req.body.ClosingDate,
      res.locals.user,
      req.body.AdendumNo
    ];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call Savetenderaddendums(?,?,?,?,?,?)";
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
tenderaddendums.put("/:ID", auth.validateRole("Applications"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    Description: Joi.string()
      .min(3)
      .required(),
    StartDate: Joi.date().required(),
    ClosingDate: Joi.date().required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    const ID = req.params.ID;
    let data = [
      ID,
      req.body.Description,
      req.body.StartDate,
      req.body.ClosingDate,
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
        let sp = "call Updatetenderaddendums(?,?,?,?,?)";
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
tenderaddendums.delete("/:ID", auth.validateRole("Applications"), function(
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
      let sp = "call Deletetenderaddendums(?,?)";
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
module.exports = tenderaddendums;
