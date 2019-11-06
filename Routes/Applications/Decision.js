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
      let sp = "call GetApplicationsforDecision()";
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
// Decision.get("/:Value/:ID", auth.validateRole("Decision"), function(req, res) {
//   const ID = req.params.ID;
//   const Value = req.params.Value;
//   if (Value === "GroundsOnly") {
//     con.getConnection(function(err, connection) {
//       if (err) {
//         res.json({
//           success: false,
//           message: err.message
//         });
//       } // not connected!
//       else {
//         let sp = "call GetApplicationGroundsOnly(?)";
//         connection.query(sp, [ID], function(error, results, fields) {
//           if (error) {
//             res.json({
//               success: false,
//               message: error.message
//             });
//           } else {
//             res.json(results[0]);
//           }
//           connection.release();
//           // Don't use the connection here, it has been returned to the pool.
//         });
//       }
//     });
//   }

//   if (Value === "PrayersOnly") {
//     con.getConnection(function(err, connection) {
//       if (err) {
//         res.json({
//           success: false,
//           message: err.message
//         });
//       } // not connected!
//       else {
//         let sp = "call GetApplicationRequestsOnly(?)";
//         connection.query(sp, [ID], function(error, results, fields) {
//           if (error) {
//             res.json({
//               success: false,
//               message: error.message
//             });
//           } else {
//             res.json(results[0]);
//           }
//           connection.release();
//           // Don't use the connection here, it has been returned to the pool.
//         });
//       }
//     });
//   }
// });

Decision.post("/", auth.validateRole("Decision"), function(req, res) {
  const schema = Joi.object().keys({
    Followup: Joi.boolean(),
    Referral: Joi.boolean(),
    Closed: Joi.boolean(),
    DecisionDate: Joi.date().required(),

    ApplicationNo: Joi.string().required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      res.locals.user,
      req.body.DecisionDate,
      req.body.Followup,
      req.body.Referral,

      req.body.Closed
    ];

    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call SubmitCaseDecision(?,?,?,?,?,?)";
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
    });
  } else {
    res.json({
      success: false,
      message: result.error.details[0].message
    });
  }
});

module.exports = Decision;
