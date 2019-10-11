var express = require("express");
var applications = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");
applications.get("/", auth.validateRole("Applications"), function(req, res) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call getapplications()";
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
applications.get("/:ID/:Category", auth.validateRole("Applications"), function(req, res) {
  const ID = req.params.ID;
  const Category = req.params.Category;
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      if (Category==="Applicant"){
      let sp = "call getmyapplications(?)";
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
    }else{
        let sp = "call GetApplicationsForEachPE(?)";
        connection.query(sp, [ID], function (error, results, fields) {
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
applications.get("/:ID/:Category/:Value", auth.validateRole("Applications"), function (req, res) {
  const ID = req.params.ID;
  con.getConnection(function (err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call TrackApplicationSequence(?)";
      connection.query(sp, [ID],function (error, results, fields) {
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
applications.post("/", auth.validateRole("Applications"), function(req, res) {
  const schema = Joi.object().keys({
    TenderID: Joi.number()
      .integer()
      .min(1),
    ApplicantID: Joi.number()
      .integer()
      .min(1),
    PEID: Joi.string()
      .min(1)
      .required(),
    ApplicationREf: Joi.string()
      .min(3)
      .required()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.TenderID,
      req.body.ApplicantID,
      req.body.PEID,
      req.body.ApplicationREf,
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
        let sp = "call SaveApplication(?,?,?,?,?)";
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
applications.put("/:ID", auth.validateRole("Applications"), function(req, res) {
  const schema = Joi.object().keys({
    TenderID: Joi.number()
      .integer()
      .min(1),
    ApplicantID: Joi.number()
      .integer()
      .min(1),
    PEID: Joi.string()
      .min(1)
      .required(),
    ApplicationREf: Joi.string()
      .min(3)
      .required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    const ID = req.params.ID;

    let data = [
      ID,
      req.body.TenderID,
      req.body.ApplicantID,
      req.body.PEID,
      req.body.ApplicationREf,
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
        let sp = "call UpdateApplication(?,?,?,?,?,?)";
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
applications.delete("/:ID", auth.validateRole("Applications"), function(
  req,
  res
) {
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
      let sp = "call DeleteApplication(?,?)";
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
module.exports = applications;
