var express = require("express");
var NotifyApprover = express();
var mysql = require("mysql");
var config = require("./../../DB");
let nodeMailer = require("nodemailer");
var con = mysql.createPool(config);
const handlebars = require("handlebars");
const path = require("path");
const fs = require("fs");
NotifyApprover.post("/", function(req, res) {
  try {
    const ID = req.body.ID;     
    if (ID === "Notify Applicant Interested Application Approved") {
      const Template = "Interested_Party_Application_Approved.hbs";
      var dataBinding = req.body;
      var templateHtml = fs.readFileSync(
        path.join(
          process.cwd(),
          "Routes",
          "SystemAdmin",
          "EmailTemplates",
          Template
        ),
        "utf8"
      );
      var output = handlebars.compile(templateHtml)(dataBinding);

     
      con.getConnection(function (err, connection) {
        let sp = "call getSMTPDetails()";
        connection.query(sp, function (error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            let Host = results[0][0].Host;
            let Port = results[0][0].Port;
            let Sender = results[0][0].Sender;
            let Password = results[0][0].Password;

            let transporter = nodeMailer.createTransport({
              host: Host,
              port: Port,
              secure: true,
              auth: {
                // should be replaced with real sender's account
                user: Sender,
                pass: Password
              },
              tls: {
                rejectUnauthorized: false
              }
            });

            let mailOptions = {
              to: req.body.to,
              subject: req.body.subject,
              html: output
            };

            transporter.sendMail(mailOptions, (error, info) => {
              if (error) {
                res.json({
                  success: false,
                  message: "Not Sent"
                });
              } else {
                res.json({
                  success: true,
                  message: "Sent"
                });
              }
            });
          }
          connection.release();
        });
      });
    }
    if (ID === "Judicial Review") {
      const Template = "Judicial_Review.hbs";
      var dataBinding = req.body;
      var templateHtml = fs.readFileSync(
        path.join(
          process.cwd(),
          "Routes",
          "SystemAdmin",
          "EmailTemplates",
          Template
        ),
        "utf8"
      );
      var output = handlebars.compile(templateHtml)(dataBinding);      
      con.getConnection(function (err, connection) {
        let sp = "call getSMTPDetails()";
        connection.query(sp, function (error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            let Host = results[0][0].Host;
            let Port = results[0][0].Port;
            let Sender = results[0][0].Sender;
            let Password = results[0][0].Password;
            let transporter = nodeMailer.createTransport({
              host: Host,
              port: Port,
              secure: true,
              auth: {
                // should be replaced with real sender's account
                user: Sender,
                pass: Password
              },
              tls: {
                rejectUnauthorized: false
              }
            });

            let mailOptions = {
              to: req.body.to,
              subject: req.body.subject,
              html: output
            };

            transporter.sendMail(mailOptions, (error, info) => {
              if (error) {
                res.json({
                  success: false,
                  message: "Not Sent"
                });
              } else {
                res.json({
                  success: true,
                  message: "Sent"
                });
              }
            });
          }
          connection.release();
        });
      });
    }
  if (ID === "Application Declined") {
    const Template = "Application_Declined.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);    

  
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "email not sent"
              });
            } else {
              res.json({
                success: true,
                message: "sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "New User") {
    const Template = "New_User.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);      

    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "Preliminary Objections Fees Approval") {
    const Template = "Preliminary_Objections_Fees_Approval.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);  

   
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "Notify Applicant on Application Approved") {
    const Template = "Application_Approved_Applicant.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);  

  
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "Fee Payment notification") {
    const Template = "ApplicationFees_Approved.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);  
    
 
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "PEresponseOthers") {
    const Template = "PE_Submited_Response.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);  

  
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "PEresponsePE") {
    const Template = "PE_Submited_Response_PE.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);  

  
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "PEresponseCaseOfficer") {
    const Template = "PE_Submited_Response_CaseOfficer.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding); 

   
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "Send Hearing Notice") {
    const Template = "Hearing_Notice.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding); 

   
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output,
            attachments: {
              // use URL as an attachment
              filename: req.body.AttachmentName,
              path: req.body.Attachmentpath
            }
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "CaseAdjournmentCaseofficer") {
    const Template = "Case_Adjournment_Caseofficer.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding); 

   
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "CaseadjournRejected") {
    const Template = "Case_Adjournment_Rejected.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding); 

    
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "CaseAdjournmentAccepted") {
    const Template = "Case_Adjournment_Approved.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding); 

    
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "case adjourn Applicant") {
    const Template = "Case_Adjournment_Applicant.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding); 

    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "case adjourn Approver") {
    const Template = "Case_Adjournment_Approver.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding); 

   
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "CaseWithdrawalRejected") {
    const Template = "Case_Withdrawal_Rejected.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding); 

   
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "CaseWithdrawalAccepted") {
    const Template = "Case_Withdrawal_Approved.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding); 

    
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "casewithdrawal Applicant") {
    const Template = "Case_Withdrawal_Applicant.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);

  
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "casewithdrawal") {
    const Template = "Case_Withdrawal_Approver.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);

 
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "Notify PE") {
    const Template = "Notify_PE.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);

    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "OfficerReasinment") {
    const Template = "Officer_Reasinment.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);

     con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }

  if (ID === "PanelMember") {
    const Template = "PanelMember.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "HEARING SCHEDULING") {
    const Template = "Hearing_Schedule.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);

 
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
    if (ID === "DECISION REPORT DECLINED") {
      const Template = "Decision_Report_Declined.hbs";
      var dataBinding = req.body;
      var templateHtml = fs.readFileSync(
        path.join(
          process.cwd(),
          "Routes",
          "SystemAdmin",
          "EmailTemplates",
          Template
        ),
        "utf8"
      );
      var output = handlebars.compile(templateHtml)(dataBinding);

      
      con.getConnection(function (err, connection) {
        let sp = "call getSMTPDetails()";
        connection.query(sp, function (error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            let Host = results[0][0].Host;
            let Port = results[0][0].Port;
            let Sender = results[0][0].Sender;
            let Password = results[0][0].Password;

            let transporter = nodeMailer.createTransport({
              host: Host,
              port: Port,
              secure: true,
              auth: {
                // should be replaced with real sender's account
                user: Sender,
                pass: Password
              },
              tls: {
                rejectUnauthorized: false
              }
            });

            let mailOptions = {
              to: req.body.to,
              subject: req.body.subject,
              html: output
            };

            transporter.sendMail(mailOptions, (error, info) => {
              if (error) {
                res.json({
                  success: false,
                  message: "Not Sent"
                });
              } else {
                res.json({
                  success: true,
                  message: "Sent"
                });
              }
            });
          }
          connection.release();
        });
      });
    }
  if (ID === "DECISION REPORT") {
    const Template = "Decision_Report_Approval.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);

  
      con.getConnection(function (err, connection) {
        let sp = "call getSMTPDetails()";
        connection.query(sp, function (error, results, fields) {
          if (error) {
            res.json({
              success: false,
              message: error.message
            });
          } else {
            let Host = results[0][0].Host;
            let Port = results[0][0].Port;
            let Sender = results[0][0].Sender;
            let Password = results[0][0].Password;

            let transporter = nodeMailer.createTransport({
              host: Host,
              port: Port,
              secure: true,
              auth: {
                // should be replaced with real sender's account
                user: Sender,
                pass: Password
              },
              tls: {
                rejectUnauthorized: false
              }
            });

            let mailOptions = {
              to: req.body.to,
              subject: req.body.subject,
              html: output
            };

            transporter.sendMail(mailOptions, (error, info) => {
              if (error) {
                res.json({
                  success: false,
                  message: "Not Sent"
                });
              } else {
                res.json({
                  success: true,
                  message: "Sent"
                });
              }
            });
          }
          connection.release();
        });
      });
    }
  if (ID === "PanelApprover") {
    const Template = "PanelApprover.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);

    
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "DeadlineExtensionDeclined") {
    const Template = "Deadline_Extension_Declined.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);
   
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "DeadlineExtensionApproved") {
    const Template = "Deadline_Extension_Approved.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);
 
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "DeadlineExtension") {
    const Template = "Deadline_Extension_Approval.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);

    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID === "Applicant") {
    const Template = "Application_Submited_Applicant.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);
 
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: outputs
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }

  if (ID == "Approver") {
    const Template = "Application_Submited_Approver.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);

    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  if (ID == "FeesApprover") {
    const Template = "Application_Fees_Approval.hbs";
    var dataBinding = req.body;
    var templateHtml = fs.readFileSync(
      path.join(
        process.cwd(),
        "Routes",
        "SystemAdmin",
        "EmailTemplates",
        Template
      ),
      "utf8"
    );
    var output = handlebars.compile(templateHtml)(dataBinding);
    con.getConnection(function(err, connection) {
      let sp = "call getSMTPDetails()";
      connection.query(sp, function(error, results, fields) {
        if (error) {
          res.json({
            success: false,
            message: error.message
          });
        } else {
          let Host = results[0][0].Host;
          let Port = results[0][0].Port;
          let Sender = results[0][0].Sender;
          let Password = results[0][0].Password;

          let transporter = nodeMailer.createTransport({
            host: Host,
            port: Port,
            secure: true,
            auth: {
              // should be replaced with real sender's account
              user: Sender,
              pass: Password
            },
            tls: {
              rejectUnauthorized: false
            }
          });

          let mailOptions = {
            to: req.body.to,
            subject: req.body.subject,
            html: output
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              res.json({
                success: false,
                message: "Not Sent"
              });
            } else {
              res.json({
                success: true,
                message: "Sent"
              });
            }
          });
        }
        connection.release();
      });
    });
  }
  } catch (e) {
    res.json({
      success: false,
      message: "Error occured while sending Email"
    });
  } 
});
NotifyApprover.get("/:ID", function(req, res) {
  const ID = req.params.ID;

  con.getConnection(function(err, connection) {
    if (err) {
      res.json({
        success: false,
        message: err.message
      });
    } // not connected!
    else {
      let sp = "call GetApproverDetails(?)";
      connection.query(sp, [ID], function(error, results, fields) {
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
          //res.json(results[0]);
        }
        connection.release();
        // Don't use the connection here, it has been returned to the pool.
      });
    }
  });
});

module.exports = NotifyApprover;
