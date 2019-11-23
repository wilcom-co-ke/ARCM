var express = require("express");
var Decision = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");
Decision.get("/", auth.validateRole("Decision"), function(req, res) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetApplicationsforDecision(?)";
      connection.query(sp, [res.locals.user], function(error, results, fields) {
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
Decision.get("/:ID", auth.validateRole("Decision"), function(req, res) {
  const ID = req.params.ID;
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetApplicationDecisionsBackgroundinformation(?)";
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
Decision.get("/:ID/:Attendance", auth.validateRole("Decision"), function(
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
      let sp = "call ComprehensiveAttendanceRegister(?)";
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
Decision.get(
  "/:ID/:Applications/:Cloased",
  auth.validateRole("Decision"),
  function(req, res) {
    const ID = req.params.ID;
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        if (ID == "SubmitedDecisions") {
          let sp = "call GetAllSubmitedDecisions()";
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
        } else {
          let sp = "call GetClosedApplicationsForDecisionUploads()";
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
      }
    });
  }
);
Decision.post("/", auth.validateRole("Decision"), function(req, res) {
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
        let sp = "call SubmitCaseDecision(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
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
});
Decision.post("/:ID", auth.validateRole("Decision"), function(req, res) {
  const schema = Joi.object().keys({
    ApplicationNo: Joi.string().required(),
    Backgroundinformation: Joi.string().required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.Backgroundinformation,
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
        if (req.params.ID == "RequestforReview") {
          let sp = "call SaveRequestforReview(?,?,?)";
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
        } else {
          let sp = "call Savedecisions(?,?,?)";
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
      }
    });
  } else {
    res.json({
      success: false,
      message: result.error.details[0].message
    });
  }
});
Decision.post("/:ID/:DecisionSummary", auth.validateRole("Decision"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    ApplicationNo: Joi.string().required(),
    Backgroundinformation: Joi.string().required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.Backgroundinformation,
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
        let sp = "call SaveDecisionSummary(?,?,?)";
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
module.exports = Decision;
