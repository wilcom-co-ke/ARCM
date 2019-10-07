var express = require("express");
var CaseScheduling = express();
var mysql = require("mysql");
var config = require("../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("../../auth");
CaseScheduling.get("/", auth.validateRole("Case Scheduling"), function(
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
      let sp = "call GetRespondedApplicationsToBeScheduled()";
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
CaseScheduling.get("/:ID", auth.validateRole("Case Scheduling"), function(
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
CaseScheduling.get(
  "/:ID/:Value",
  auth.validateRole("Case Scheduling"),
  function(req, res) {
    const ID = req.params.ID;
    const Value = req.params.Value;
    if (Value === "AllBookings") {
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call GetAllVenueBookings()";
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
    }

    if (Value === "Venues") {
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call GetvenuesPerBranch(?)";
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
    }
    if (Value === "ContactList") {
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!s
        else {
          let sp = "call GetHearingNotificationContacts(?)";
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
    }
    if (Value === "UpdateSentNotice") {
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call SetSentHearingNotice(?)";
          connection.query(sp, [ID], function(error, results, fields) {
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
    }
  }
);

CaseScheduling.post("/", auth.validateRole("Case Scheduling"), function(
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
        let sp = "call BookVenue(?,?,?,?,?)";
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
CaseScheduling.put("/", auth.validateRole("Case Scheduling"), function(
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
module.exports = CaseScheduling;
