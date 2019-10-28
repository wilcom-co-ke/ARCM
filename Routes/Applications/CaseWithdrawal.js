var express = require("express");
var CaseWithdrawal = express();
var mysql = require("mysql");
var config = require("../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("../../auth");
CaseWithdrawal.get("/", auth.validateRole("Case Withdrawal"), function(
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
CaseWithdrawal.get("/:ID", auth.validateRole("Case Withdrawal"), function(
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
      let sp = "call getCaseWithdrawalPendingApproval(?)";
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

CaseWithdrawal.post("/", auth.validateRole("Case Withdrawal"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    Applicant: Joi.string().required(),
    ApplicationNo: Joi.string().required(),
    Reason: Joi.string().required()
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
        let sp = "call SaveCaseWithdrawal(?,?,?,?)";
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
CaseWithdrawal.put("/:ID", auth.validateRole("Case Withdrawal"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    ApplicationNo: Joi.string()
      .min(1)
      .required(),
    RejectionReason: Joi.string()
      .min(1)
      .required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.RejectionReason,
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
          let sp = "call ApprovecaseWithdrawal(?,?,?)";
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
    if (ID === "frivolous") {
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call MarkcaseWithdrawalasfrivolous(?,?)";
          connection.query(
            sp,
            [req.body.ApplicationNo, res.locals.user],
            function(error, results, fields) {
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
            }
          );
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
          let sp = "call DeclinecaseWithdrawal(?,?,?)";
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
module.exports = CaseWithdrawal;
