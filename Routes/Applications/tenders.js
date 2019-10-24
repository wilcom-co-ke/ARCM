var express = require("express");
var tenders = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");
tenders.get("/", auth.validateRole("Applications"), function(req, res) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetAllTenders()";
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
tenders.get("/:ID", auth.validateRole("Applications"), function(req, res) {
  const ID = req.params.ID;
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetOneTender(?)";
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
tenders.post("/", auth.validateRole("Applications"), function(req, res) {
  const schema = Joi.object().keys({
    TenderNo: Joi.string().required(),
    TenderName: Joi.string().required(),
    PEID: Joi.string().required(),
    StartDate: Joi.date().required(),
    ClosingDate: Joi.date().required(),
    TenderValue: Joi.number()
      .allow(null)
      .allow(""),
    TenderType: Joi.string().required(),
    TenderSubCategory: Joi.string()
      .allow(null)
      .allow(""),
    TenderCategory: Joi.string()
      .allow(null)
      .allow(""),
    Timer: Joi.string()
      .allow(null)
      .allow("")
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.TenderNo,
      req.body.TenderName,
      req.body.PEID,
      req.body.StartDate,
      req.body.ClosingDate,
      res.locals.user,
      req.body.TenderValue,
      req.body.TenderType,
      req.body.TenderSubCategory,
      req.body.TenderCategory,
      req.body.Timer
    ];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call SaveTender(?,?,?,?,?,?,?,?,?,?,?)";
        connection.query(sp, data, function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json({
              success: true,
              message: "saved",
              results: results[0]
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
tenders.put("/:ID", auth.validateRole("Applications"), function(req, res) {
  const schema = Joi.object().keys({
    TenderNo: Joi.string()
      .min(3)
      .required(),
    TenderName: Joi.string()
      .min(3)
      .required(),
    PEID: Joi.string()
      .min(1)
      .required(),
    StartDate: Joi.date().required(),
    ClosingDate: Joi.date().required(),

    TenderValue: Joi.number()
      .allow(null)
      .allow(""),
    TenderType: Joi.string().required(),
    TenderSubCategory: Joi.string()
      .allow(null)
      .allow(""),
    TenderCategory: Joi.string()
      .allow(null)
      .allow("")
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    const ID = req.params.ID;
    let data = [
      ID,
      req.body.TenderNo,
      req.body.TenderName,
      req.body.PEID,
      req.body.StartDate,
      req.body.ClosingDate,
      res.locals.user,
      req.body.TenderValue,
      req.body.TenderType,
      req.body.TenderSubCategory,
      req.body.TenderCategory
    ];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call UpdateTender(?,?,?,?,?,?,?,?,?,?,?)";
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
tenders.delete("/:ID", auth.validateRole("Applications"), function(req, res) {
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
      let sp = "call DeleteTender(?,?)";
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
module.exports = tenders;
