var express = require("express");
var adjournment = express();
var mysql = require("mysql");
var config = require("../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("../../auth");
adjournment.get("/", auth.validateRole("Case Adjournment"), function(req, res) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call getCaseWithdrawalPendingApproval()";
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
adjournment.get("/:ID/:Desc", auth.validateRole("Case Adjournment"), function(
  req,
  res
) {
  const ID = req.params.ID;
  const Desc = req.params.Desc;

  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      if (Desc === "PendingRequests") {
        let sp = "call GetadjournmentPendingApproval(?)";
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
      if (Desc === "Documents") {
        let sp = "call GetAdjournmentDocuments(?)";
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
adjournment.post("/", auth.validateRole("Case Adjournment"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    Applicant: Joi.string()
      .min(1)
      .required(),
    ApplicationNo: Joi.string()
      .min(1)
      .required(),
    Reason: Joi.string()
      .min(1)
      .required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.Applicant,
      req.body.ApplicationNo,
      req.body.Reason,
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
        let sp = "call Saveadjournment(?,?,?,?)";
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
adjournment.post("/:ID", auth.validateRole("Case Adjournment"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    Description: Joi.string()
      .min(1)
      .required(),
    ApplicationNo: Joi.string()
      .min(1)
      .required(),
    Path: Joi.string()
      .min(1)
      .required(),
    Name: Joi.string()
      .min(1)
      .required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.Description,
      req.body.Path,
      req.body.Name,
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
        let sp = "call SaveadjournmentDocuments(?,?,?,?,?)";
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
adjournment.delete("/:ID", auth.validateRole("Case Adjournment"), function(
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
      let sp = "call DeleteadjournmentDocuments(?,?)";
      connection.query(sp, [ID, res.locals.user], function(
        error,
        results,
        fields
      ) {
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
});
adjournment.put("/:ID", auth.validateRole("Case Adjournment"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    ApplicationNo: Joi.string()
      .min(1)
      .required(),
    ApprovalRemarks: Joi.string()
      .min(1)
      .required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.ApprovalRemarks,
      res.locals.user
    ];

    const ID = req.params.ID;
    if (ID === "Approve") {
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call ApprovecaseAdjournment(?,?,?)";
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
    }

    if (ID === "Decline") {
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call DeclinecaseAdjournment(?,?,?)";
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
    }
  } else {
    res.json({
      success: false,
      message: result.error.details[0].message
    });
  }
});
module.exports = adjournment;
