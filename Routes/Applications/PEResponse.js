var express = require("express");
var PEResponse = express();
var mysql = require("mysql");
var config = require("./../../DB");
var Joi = require("joi");
var con = mysql.createPool(config);
PEResponse.get("/", function(req, res) {
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call getAllPEResponse()";
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
PEResponse.get("/:ID", function(req, res) {
  const ID = req.params.ID;
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call getMyResponse(?)";
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
PEResponse.get("/:ID/:Value", function(req, res) {
  const ID = req.params.ID;
  const Value = req.params.Value;
  if (ID === "GetPEResponseDetailsPerApplication") {
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call GetPEResponseDetailsPerApplication(?)";
        connection.query(sp, [Value], function(error, results, fields) {
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
  if (ID === "Documents") {
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call GetPEResponseDocuments(?)";
        connection.query(sp, [Value], function(error, results, fields) {
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
  if (ID === "Details") {
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call GetPEResponseDetails(?)";
        connection.query(sp, [Value], function(error, results, fields) {
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
PEResponse.post("/", function(req, res) {
  const schema = Joi.object().keys({
    ApplicationNo: Joi.string()
      .min(1)
      .required(),

    ResponseType: Joi.string()
      .min(1)
      .required(),
    UserID: Joi.string()
      .min(1)
      .required()
  });

  const result = Joi.validate(req.body, schema);
  if (!result.error) {
    let data = [req.body.ApplicationNo, req.body.ResponseType, req.body.UserID];

    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let sp = "call SavePEResponse(?,?,?)";
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
              ResponseID: results[0]
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
PEResponse.post("/:ID", function(req, res) {
  const ID = req.params.ID;
  if (ID === "DeadlineExtension") {
    const schema = Joi.object().keys({
      UserID: Joi.string()
        .min(1)
        .required(),
      ApplicationNo: Joi.string()
        .min(1)
        .required(),
      Reason: Joi.string()
        .min(1)
        .required(),
      Newdate: Joi.date().required()
    });

    const result = Joi.validate(req.body, schema);
    if (!result.error) {
      let data = [
        req.body.ApplicationNo,
        req.body.Reason,
        req.body.Newdate,
        req.body.UserID
      ];

      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call SaveRequestforDeadlineExtension(?,?,?,?)";
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

  if (ID === "Details") {
    const schema = Joi.object().keys({
      PERsponseID: Joi.number()
        .integer()
        .min(1)
        .required(),
      UserID: Joi.string().required(),
      GrounNo: Joi.string().required(),
      Groundtype: Joi.string().required(),
      Response: Joi.string().required(),
      BackgroundInformation: Joi.string().required()
    });

    const result = Joi.validate(req.body, schema);
    if (!result.error) {
      let data = [
        req.body.PERsponseID,
        req.body.GrounNo,
        req.body.Groundtype,
        req.body.Response,
        req.body.UserID,
        req.body.BackgroundInformation
      ];

      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call SavePEResponseDetails(?,?,?,?,?,?)";
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
  }
  if (ID === "Documents") {
    const schema = Joi.object().keys({
      PERsponseID: Joi.number()
        .integer()
        .min(1)
        .required(),
      Name: Joi.string()
        .min(1)
        .required(),
      Description: Joi.string()
        .min(1)
        .required(),
      Path: Joi.string()
        .min(1)
        .required()
    });

    const result = Joi.validate(req.body, schema);
    if (!result.error) {
      let data = [
        req.body.PERsponseID,
        req.body.Name,
        req.body.Description,
        req.body.Path
      ];

      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call SavePEresponseDocuments(?,?,?,?)";
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
  }
});
PEResponse.put("/:ID/:Value", function(req, res) {
  const ID = req.params.ID;
  const Value = req.params.Value;
  if (ID === "SubmitResponse") {
    const schema = Joi.object().keys({
      PEResponseID: Joi.number()
        .integer()
        .min(1)
        .required(),
      UserID: Joi.string()
        .min(1)
        .required(),
      ApplicationNo: Joi.string()
        .min(1)
        .required()
    });

    const result = Joi.validate(req.body, schema);
    if (!result.error) {
      let data = [
        req.body.PEResponseID,
        req.body.ApplicationNo,
        req.body.UserID
      ];

      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call SubmitPeResponse(?,?,?)";
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
    } else {
      res.json({
        success: false,
        message: result.error.details[0].message
      });
    }
  }
  if (ID === "Updatedetails") {
    const schema = Joi.object().keys({
      PEResponseID: Joi.number()
        .integer()
        .min(1)
        .required(),
      UserID: Joi.string()
        .min(1)
        .required(),
      GroundNo: Joi.string()
        .min(1)
        .required(),
      GroundType: Joi.string()
        .min(1)
        .required(),
      Response: Joi.string()
        .min(1)
        .required()
    });

    const result = Joi.validate(req.body, schema);
    if (!result.error) {
      let data = [
        req.body.GroundNo,
        req.body.GroundType,
        req.body.Response,
        req.body.UserID,
        req.body.PEResponseID
      ];

      con.getConnection(function(err, connection) {
        if (err) {
          res.json({
            success: false,
            message: err.message
          });
        } // not connected!
        else {
          let sp = "call UpdatePEResponseDetails(?,?,?,?,?)";
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
  }
  if (ID === "DeleteDocument") {
    con.getConnection(function(err, connection) {
      if (err) {
        res.json({
          success: false,
          message: err.message
        });
      } // not connected!
      else {
        let ddata = [Value, res.locals.user];
        let sp = "call DeletePEResponseDocument(?,?)";
        connection.query(sp, ddata, function(error, results, fields) {
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
  }
});
PEResponse.put("/:ID", function(req, res) {
  const ID = req.params.ID;
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call UpdatePEResponseStatus(?)";
      connection.query(sp, ID, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          res.json({
            success: true,
            message: "updated",
            data: results[0]
          });
        }
        connection.release();
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});
PEResponse.delete("/:ID", function(req, res) {
  const GroundNO = req.params.ID;
  let data = [GroundNO, res.locals.user];
  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call DeletePEResponsedetails(?,?)";
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
module.exports = PEResponse;
