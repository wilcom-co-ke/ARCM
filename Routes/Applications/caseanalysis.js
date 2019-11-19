var express = require("express");
var caseanalysis = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");
caseanalysis.get("/", auth.validateRole("Case Analysis"), function(req, res) {
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
caseanalysis.get("/:ID", auth.validateRole("Case Analysis"), function(
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
      let sp = "call GetcaseAnalysis(?)";
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
caseanalysis.get(
  "/:ID/:Documents",
  auth.validateRole("Case Analysis"),
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
        let sp = "call getcaseanalysisdocuments(?)";
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
);
caseanalysis.post("/", auth.validateRole("Case Analysis"), function(req, res) {
  const schema = Joi.object().keys({
    ApplicationNo: Joi.string().required(),
    Title: Joi.string().required(),
    Description: Joi.string().required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.Title,
      req.body.Description,
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
        let sp = "call SavecaseAnalysis(?,?,?,?)";
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
caseanalysis.post("/:Documents", auth.validateRole("Case Analysis"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    ApplicationNo: Joi.string().required(),
    Description: Joi.string().required(),
    DocName: Joi.string().required(),
    FilePath: Joi.string().required()
  });
  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.Description,
      req.body.DocName,
      req.body.FilePath,
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
        let sp = "call Savecaseanalysisdocuments(?,?,?,?,?)";
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

caseanalysis.delete(
  "/:ApplicationNo/:Title",
  auth.validateRole("Case Analysis"),
  function(req, res) {
    const ApplicationNo = req.params.ApplicationNo;
    const Title = req.params.Title;
    let data = [ApplicationNo, Title, res.locals.user];

    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call DeletecaseAnalysisSection(?,?,?)";
        connection.query(sp, data, function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json({
              success: true,
              message: "Deleted"
            });
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
    });
  }
);
caseanalysis.delete(
  "/:FileName",
  auth.validateRole("Case Analysis"),
  function(req, res) {
    const FileName = req.params.FileName;
    let data = [FileName, res.locals.user];

    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call Deletecaseanalysisdocuments(?,?)";
        connection.query(sp, data, function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json({
              success: true,
              message: "Deleted"
            });
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
    });
  }
);
module.exports = caseanalysis;
