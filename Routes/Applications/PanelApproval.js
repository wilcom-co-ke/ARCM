var express = require("express");
var PanelApproval = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
var auth = require("./../../auth");
PanelApproval.get("/", auth.validateRole("Panels Approval"), function(
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
      let sp = "call getAllPanels()";
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
PanelApproval.get("/:ID/:Value", auth.validateRole("Panels Approval"), function(
  req,
  res
) {
  const ID = req.params.ID;
  const Value = req.params.Value;
  if (Value === "Approvemember") {
    let approvaldata = [ID, Value, res.locals.user];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call ApprovePanelMember(?,?)";
        connection.query(sp, approvaldata, function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json({
              success: true,
              message: "Approved"
            });
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
    });
  }
  if (Value === "ApplicationNo") {
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call GetpanelsApproval(?)";
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
  if (Value === "Panel") {
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call GetPanelMembers(?)";
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
  if (Value === "ApplicantDetails") {
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call GetApplicantPerApplicationno(?)";
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
});
PanelApproval.get(
  "/:ID/:Value/:Another",
  auth.validateRole("Panels Approval"),
  function(req, res) {
    const ID = req.params.ID;
    const Value = req.params.Value;

    let approvaldata = [Value, ID, res.locals.user];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call ApprovePanelMember(?,?,?)";
        connection.query(sp, approvaldata, function(error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            res.json({
              success: true,
              message: "Approved"
            });
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
    });
  }
);

PanelApproval.post("/", auth.validateRole("Panels Approval"), function(
  req,
  res
) {
  const schema = Joi.object().keys({
    ApplicationNo: Joi.string()
      .min(1)
      .required(),
    Role: Joi.string()
      .min(3)
      .required(),
    UserName: Joi.string()
      .min(2)
      .required()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [
      req.body.ApplicationNo,
      req.body.Role,
      req.body.UserName,
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
        let sp = "call AddPanelMember(?,?,?,?)";
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
PanelApproval.put("/:ID", auth.validateRole("Panels Approval"), function(
  req,
  res
) {
  const ID = req.params.ID;
  let data = [res.locals.user, ID];

  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call SubmitApprovedPanelList(?,?)";
      connection.query(sp, data, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          res.json({
            success: true,
            message: "updated",
            results: results[0]
          });
        }
        connection.release();
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});
PanelApproval.delete(
  "/:ID/:Value",
  auth.validateRole("Panels Approval"),
  function(req, res) {
    const ApplicationNo = req.params.Value;
    const UserName = req.params.ID;
    let data = [ApplicationNo, UserName, res.locals.user];
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call RemovePanelMember(?,?,?)";
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
  }
);
module.exports = PanelApproval;
