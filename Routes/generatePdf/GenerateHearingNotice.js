var express = require("express");
var GenerateHearingNotice = express();
const pdf = require("html-pdf");
const pdfTemplate = require("./../Reporttemplates/HearingNotice");
var mysql = require("mysql");
var config = require("../../DB");
const path = require("path");
var con = mysql.createPool(config);

GenerateHearingNotice.get("/:ID", function(req, res) {
  let fileName = `HearingNotices/${req.params.ID}.pdf`;
  res.download(fileName);
});
GenerateHearingNotice.post("/", function(req, res) {
  var storagepath = path.join(
    process.cwd(),
    "Reports",
    "HearingNotices",
    req.body.ApplicationNo + ".pdf"
  );
  pdf.create(pdfTemplate(req.body), {}).toFile(storagepath, err => {
    if (err) {
      res.send(Promise.reject());
    }

    //save notice
    let fileName = req.body.ApplicationNo + ".pdf";
    let data = [
      req.body.ApplicationNo,
      "HearingNotices/",
      fileName,
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
        let sp = "call SaveHearingNotice(?,?,?,?)";
        connection.query(sp, data, function(error, results, fields) {
          if (error) {
            // res.json({
            //   success: false,
            //   message: error.message
            // });
          } else {
            res.json({
              success: true,
              message: "Generated"
            });
          }
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      }
    });

    //res.send(Promise.resolve());
  });
});

module.exports = GenerateHearingNotice;
