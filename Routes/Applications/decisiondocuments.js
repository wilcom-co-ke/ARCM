var express = require("express");
var decisiondocuments = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");

decisiondocuments.get("/:ID", auth.validateRole("Decision"), function(
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
      let sp = "call Getdecisiondocuments(?)";
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

decisiondocuments.post("/", auth.validateRole("Decision"), function(req, res) {
  const schema = Joi.object().keys({
    Name: Joi.string().required(),
    ApplicationNo: Joi.string().required(),
    Description: Joi.string().required(),
    path: Joi.string().required(),
    Confidential: Joi.boolean()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.Name,
      req.body.Description,
      req.body.path,
      res.locals.user,
      req.body.Confidential
    ];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call Savedecisiondocuments(?,?,?,?,?,?)";
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
decisiondocuments.post(
  "/:ApproveDecision",
  auth.validateRole("Decision"),
  function(req, res) {
    const schema = Joi.object().keys({
      Followup: Joi.boolean(),
      Referral: Joi.boolean(),
      Closed: Joi.boolean(),
      DecisionDate: Joi.date().required(),
      ApplicationSuccessful: Joi.boolean(),
      ApplicationNo: Joi.string().required(),

      Annulled: Joi.boolean(),
      GiveDirection: Joi.boolean(),
      Terminated: Joi.boolean(),
      ReTender: Joi.boolean(),
      CostsPE: Joi.boolean(),
      CostsApplicant: Joi.boolean(),
      CostsEachParty: Joi.boolean(),
      Substitution: Joi.boolean()
    });
    const result = Joi.validate(req.body, schema);
    if (!result.error) {
      let data = [
        req.body.ApplicationNo,
        res.locals.user,
        req.body.DecisionDate,
        req.body.Followup,
        req.body.Referral,
        req.body.Closed,
        req.body.ApplicationSuccessful,
        req.body.Annulled,
        req.body.GiveDirection,
        req.body.Terminated,
        req.body.ReTender,
        req.body.CostsPE,
        req.body.CostsApplicant,
        req.body.CostsEachParty,
        req.body.Substitution
      ];
      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp =
            "call Approvedecisiondocuments(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
          connection.query(sp, data, function(error, results, fields) {
            if (error) {
              res.json({
                success: false,
                message: error.message
              });
            } else {
              res.json({
                success: true,
                results: results[0],
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
  }
);

decisiondocuments.delete("/:ID", auth.validateRole("Decision"), function(
  req,
  res
) {
  let data = [req.params.ID, res.locals.user];

  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call Deletedecisiondocuments(?,?)";
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
decisiondocuments.put("/", auth.validateRole("Decision"), function(req, res) {
  const schema = Joi.object().keys({
    Declineremarks: Joi.string().required(),
    ApplicationNo: Joi.string().required()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.Declineremarks,
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
        let sp = "call Declinedecisiondocuments(?,?,?)";
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
decisiondocuments.post(
  "/:ID/:SubmitDecision",
  auth.validateRole("Decision"),
  function(req, res) {
    let data = [req.params.ID, res.locals.user];

    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call SubmitApplicationdecision(?,?)";
        connection.query(sp, data, function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json({
              success: true,
              results: results[0],
              message: "Submited Successfully"
            });
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
    });
  }
);
module.exports = decisiondocuments;
