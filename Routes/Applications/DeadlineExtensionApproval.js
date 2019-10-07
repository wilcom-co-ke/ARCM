var express = require("express");
var DeadlineExtensionApproval = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");

DeadlineExtensionApproval.get(
  "/:Value/:ID",
  auth.validateRole("Deadline Extension Approval"),
  function(req, res) {
    const Value = req.params.Value;
    if (Value === "Requests") {
      const ID = req.params.ID;
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call getdeadLineRequestApprovals(?)";
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
    if (Value === "tenderdetails") {
      const ID = req.params.ID;
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call GetTenderDetailsPerApplicationNo(?)";
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
  }
);
DeadlineExtensionApproval.put(
  "/",
  auth.validateRole("Deadline Extension Approval"),
  function(req, res) {
    const schema = Joi.object().keys({
      Approver: Joi.string()
        .min(1)
        .required(),
      ApplicationNo: Joi.string()
        .min(1)
        .required(),
      Remarks: Joi.string()
        .min(1)
        .required(),
      NewDeadLine: Joi.date().required()
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
          let sp = "call DeclineDeadlineRequestExtension(?,?,?)";
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
DeadlineExtensionApproval.post(
  "/",
  auth.validateRole("Deadline Extension Approval"),
  function(req, res) {
    const schema = Joi.object().keys({
      Approver: Joi.string()
        .min(1)
        .required(),
      ApplicationNo: Joi.string()
        .min(1)
        .required(),
      Remarks: Joi.string()
        .min(1)
        .required(),
      NewDeadLine: Joi.date().required()
    });

    const result = Joi.validate(req.body, schema);
    if (!result.error) {
      let data = [
        req.body.Approver,
        req.body.ApplicationNo,
        req.body.Remarks,
        req.body.NewDeadLine
      ];

      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call ApproveDeadlineRequestExtension(?,?,?,?)";
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

module.exports = DeadlineExtensionApproval;
