var express = require("express");
var GenerateDecision = express();
const fs = require("fs");
const path = require("path");
const puppeteer = require("puppeteer");
const handlebars = require("handlebars"),
  groupBy = require("handlebars-group-by");
groupBy(handlebars);

var mysql = require("mysql");
var config = require("../../DB");
var con = mysql.createPool(config);

GenerateDecision.post("/", function(req, res) {
  try {
    (async () => {
      var dataBinding = req.body;
      var templateHtml = fs.readFileSync(
        path.join(process.cwd(), "Routes", "Reporttemplates", "Decision.hbs"),
        "utf8"
      );

      // var template = handlebars.compile(templateHtml)(dataBinding);
      var finalHtml = handlebars.compile(templateHtml)(dataBinding);
      var storagepath = path.join(
        process.cwd(),
        "Reports",
        "Decisions",
        req.body.Applicationno + ".pdf"
      );
      var options = {
        format: "A4",
        headerTemplate: "<p></p>",
        footerTemplate: `<div style="width:100%; text-align: center;font-weight: 700!important;font-size:10px;"><hr/>Page <span class="pageNumber"></span> of <span class="totalPages"></span></div>`,
        displayHeaderFooter: true,
        margin: {
          top: "20px",
          bottom: "100px"
        },
        printBackground: true,
        path: storagepath
      };
      const browser = await puppeteer.launch();
      const page = await browser.newPage();
      await page.setContent(finalHtml);
      //  await page.emulate("screen");
      await page.pdf(options);
      await browser.close();
      res.json({
        success: true,
        message: "Generated"
      });
    })();
  } catch (err) {
    res.json({
      success: false,
      message: err
    });
  }
});

module.exports = GenerateDecision;
