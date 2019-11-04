var express = require("express");
var additionalsubmissions = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
additionalsubmissions.get("/:ID/:Value", function(req, res) {
  const ID = req.params.ID;
  const Value = req.params.Value;
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call Getadditionalsubmissions(?,?)";
      connection.query(sp, [ID, Value], function(error, results, fields) {
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
additionalsubmissions.get("/:ID/:Value/:Documents", function(req, res) {
  const ID = req.params.ID;
  const Value = req.params.Value;
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetadditionalsubmissionsDocuments(?,?)";
      connection.query(sp, [ID, Value], function(error, results, fields) {
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
additionalsubmissions.post("/", function(req, res) {
  const schema = Joi.object().keys({
    ApplicationID: Joi.number()
      .integer()
      .min(1),
    Description: Joi.string().required(),
    DocName: Joi.string().required(),
    FilePath: Joi.string().required(),
    Category: Joi.string().required()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationID,
      req.body.Description,
      req.body.DocName,
      req.body.FilePath,
      res.locals.user,
      req.body.Category
    ];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call Saveadditionalsubmissions(?,?,?,?,?,?)";
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
additionalsubmissions.post("/:ID", function(req, res) {
  const schema = Joi.object().keys({
    ApplicationID: Joi.number()
      .integer()
      .min(1),
    Description: Joi.string().required(),
    DocName: Joi.string().required(),
    FilePath: Joi.string().required(),
    Category: Joi.string().required(),
    Confidential: Joi.boolean()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationID,
      req.body.Description,
      req.body.DocName,
      req.body.FilePath,
      res.locals.user,
      req.body.Category,
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
        let sp = "call SaveadditionalsubmissionsDocuments(?,?,?,?,?,?,?)";
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
additionalsubmissions.delete("/:ID", function(req, res) {
  let data = [req.params.ID, res.locals.user];

  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call Deleteadditionalsubmissions(?,?)";
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
additionalsubmissions.delete("/:ID/:Attachment", function(req, res) {
  let data = [req.params.ID, res.locals.user];

  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call DeleteadditionalsubmissionsDocument(?,?)";
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
module.exports = additionalsubmissions;
