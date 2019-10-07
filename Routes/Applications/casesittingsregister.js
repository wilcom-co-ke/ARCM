var express = require("express");
var casesittingsregister = express();
var mysql = require("mysql");
var config = require("../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("../../auth");
casesittingsregister.get("/", auth.validateRole("Case Scheduling"), function(
  req,
  res
) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetApplicationForHearing()";
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
casesittingsregister.get("/:ID", auth.validateRole("Case Scheduling"), function(
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
      let sp = "call getPrimaryCaseOfficer(?)";
      connection.query(sp, [ID], function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          res.json({
            results: results[0]
          });
        }
        connection.release();
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});
casesittingsregister.post("/", auth.validateRole("Case Scheduling"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    Date: Joi.date().required(),
    VenueID: Joi.number()
      .integer()
      .min(1),
    ApplicationNo: Joi.string()
      .min(1)
      .required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.VenueID,
      req.body.Date,
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
        let sp = "call registercasesittings(?,?,?,?)";
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
casesittingsregister.post(
  "/:ID",
  auth.validateRole("Case Scheduling"),
  function(req, res) {
    const schema = Joi.object().keys({
      IDNO: Joi.string()
        .min(4)
        .required(),
      RegisterID: Joi.number()
        .integer()
        .min(1),
      Name: Joi.string()
        .min(3)
        .required(),
      Category: Joi.string()
        .min(2)
        .required(),
      Email: Joi.string().email({ minDomainAtoms: 2 }),
      MobileNo: Joi.string()
        .min(1)
        .required()
    });
    const result = Joi.validate(req.body, schema);
    if (!result.error) {
      let data = [
        req.body.RegisterID,
        req.body.Name,
        req.body.IDNO,
        req.body.MobileNo,
        req.body.Category,
        res.locals.user,
        req.body.Email
      ];

      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call selfAttendanceregistration(?,?,?,?,?,?,?)";
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
  }
);
casesittingsregister.put("/", auth.validateRole("Case Scheduling"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    Date: Joi.string()
      .min(3)
      .required(),
    VenueID: Joi.number()
      .integer()
      .min(1),
    Slot: Joi.string()
      .min(1)
      .required(),
    Content: Joi.string()
      .min(1)
      .required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.VenueID,
      req.body.Date,
      req.body.Slot,
      res.locals.user,
      req.body.Content
    ];

    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call UnBookVenue(?,?,?,?,?)";
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
module.exports = casesittingsregister;
