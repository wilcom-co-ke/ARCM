var express = require("express");
var FeesApproval = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");

FeesApproval.get("/", auth.validateRole("Fees Approval"), function(req, res) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetPendingFeesApprovals()";
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
FeesApproval.get("/:ID", auth.validateRole("Fees Approval"), function(
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
      let sp = "call GetPendingApplicationFees(?)";
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
FeesApproval.put("/", auth.validateRole("Fees Approval"), function(req, res) {
  const schema = Joi.object().keys({
    Approver: Joi.string()
      .min(1)
      .required(),
    ApplicationNo: Joi.string()
      .min(1)
      .required(),
    Remarks: Joi.string()
      .min(1)
      .required()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [req.body.Approver, req.body.ApplicationNo, req.body.Remarks];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call DeclineApplication(?,?,?)";
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
FeesApproval.post("/", auth.validateRole("Fees Approval"), function(req, res) {
  const schema = Joi.object().keys({
    Approver: Joi.string()
      .min(1)
      .required(),
    ApplicationID: Joi.number().min(1),
    ApprovedAmount: Joi.number().min(1),
    FeeEntryType: Joi.string()
      .min(1)
      .required(),
    Narration: Joi.string()
      .min(1)
      .required()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.Approver,
      req.body.ApplicationID,
      req.body.ApprovedAmount,
      req.body.FeeEntryType,
      req.body.Narration
    ];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call ApproveApplicationFees(?,?,?,?,?)";
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

module.exports = FeesApproval;
