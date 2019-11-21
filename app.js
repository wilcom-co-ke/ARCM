var express = require("express");
var app = express();
var Users = require("./Routes/SystemAdmin/Users");
var usergroups = require("./Routes/SystemAdmin/usergroups");
var Signup = require("./Routes/SystemAdmin/Signup");
var Mailer = require("./Routes/SystemAdmin/Mailer");
var auth = require("./auth");
var ValidateTokenExpiry = require("./Routes/SystemAdmin/ValidateTokenExpiry");

var Roles = require("./Routes/SystemAdmin/Roles");
var Auditrails = require("./Routes/SystemAdmin/Auditrails");

var bodyParser = require("body-Parser");
var Uploadfiles = require("./Routes/SystemAdmin/Uploadfiles");
var updateprofile = require("./Routes/SystemAdmin/updateprofile");
var UserAccess = require("./Routes/SystemAdmin/UserAccess");
var GroupAccess = require("./Routes/SystemAdmin/GroupAccess");
var caseofficers = require("./Routes/SystemAdmin/caseofficers");
var configurations = require("./Routes/SystemAdmin/configurations");
var casedetails = require("./Routes/Applications/casedetails");
var CaseScheduling = require("./Routes/Applications/CaseScheduling");
//setups

var paymenttypes = require("./Routes/SetUps/paymenttypes");
var Banks = require("./Routes/SetUps/Banks");
var petypes = require("./Routes/SetUps/petypes");
var committeetypes = require("./Routes/SetUps/committeetypes");
var Branches = require("./Routes/SetUps/Branches");
var interestedparties = require("./Routes/SetUps/interestedparties");
var procurementmethods = require("./Routes/SetUps/procurementmethods");
var stdtenderdocs = require("./Routes/SetUps/stdtenderdocs");
var financialyear = require("./Routes/SetUps/financialyear");
var membertypes = require("./Routes/SetUps/membertypes");
var feesstructure = require("./Routes/SetUps/feesstructure");
var counties = require("./Routes/SetUps/counties");
var tendertypes = require("./Routes/SetUps/tendertypes");
var PE = require("./Routes/SetUps/PE");
var applicants = require("./Routes/SetUps/applicants");
var Towns = require("./Routes/SetUps/Towns");
var tenders = require("./Routes/Applications/tenders");
var tenderaddendums = require("./Routes/Applications/tenderaddendums");
var applications = require("./Routes/Applications/applications");
var grounds = require("./Routes/Applications/grounds");
var applicationdocuments = require("./Routes/Applications/applicationdocuments");
var EmailVerification = require("./Routes/SystemAdmin/EmailVerification");
var ResetPassword = require("./Routes/SystemAdmin/ResetPassword");
var sms = require("./Routes/SMS/sms");
var Approvers = require("./Routes/SystemAdmin/Approvers");
var Approvalmodules = require("./Routes/SystemAdmin/Approvalmodules");
var applicationfees = require("./Routes/Applications/applicationfees");
var Dashboard = require("./Routes/Applications/Dashboard");
var ApplicationsApprovals = require("./Routes/Applications/ApplicationsApprovals");
var NotifyApprover = require("./Routes/Applications/NotifyApprover");
var schedules = require("./Routes/SystemAdmin/schedules");
var PEUsers = require("./Routes/SystemAdmin/PEUsers");
var Venues = require("./Routes/SetUps/Venues");
var Panels = require("./Routes/Applications/Panels");
var PanelApproval = require("./Routes/Applications/PanelApproval");
var CaseWithdrawal = require("./Routes/Applications/CaseWithdrawal");
var adjournment = require("./Routes/Applications/adjournment");
var casesittingsregister = require("./Routes/Applications/casesittingsregister");
var HearingInProgress = require("./Routes/Applications/HearingInProgress");
var additionalsubmissions = require("./Routes/Applications/additionalsubmissions");
var CaseFollowUp = require("./Routes/Applications/CaseFollowUp");
var CaseReferrals = require("./Routes/Applications/CaseReferrals");
//mpesa
var Authentication = require("./Routes/Mpesa/Authentication");
var confirmation = require("./Routes/Mpesa/confirmation");
var validation_url = require("./Routes/Mpesa/validation_url");
var PEResponse = require("./Routes/Applications/PEResponse");
var DeadlineExtensionApproval = require("./Routes/Applications/DeadlineExtensionApproval");
var HearingNotices = require("./Routes/Reports/HearingNotices");
//reports
var GenerateRBForm = require("./Routes/generatePdf/GenerateRBForm");
var GenerateHearingNotice = require("./Routes/generatePdf/GenerateHearingNotice");
var GeneratePanelList = require("./Routes/generatePdf/GeneratePanelList");
var GenerateCaseSummary = require("./Routes/generatePdf/GenerateCaseSummary");
var GenerateAttendanceregister = require("./Routes/generatePdf/GenerateAttendanceregister");
var FeesApproval = require("./Routes/Applications/FeesApproval");

var ExecutiveReports = require("./Routes/Reports/ExecutiveReports");
var issuesfordetermination = require("./Routes/Applications/issuesfordetermination");
var findingsonissues = require("./Routes/Applications/findingsonissues");
var PartySubmision = require("./Routes/Applications/PartySubmision");
var decisiondocuments = require("./Routes/Applications/decisiondocuments");
var decisionorders = require("./Routes/Applications/decisionorders");
var Decision = require("./Routes/Applications/Decision");
var GenerateDecision = require("./Routes/generatePdf/GenerateDecision");
var caseanalysis = require("./Routes/Applications/caseanalysis");
var GenerateCaseAnalysis = require("./Routes/generatePdf/GenerateCaseAnalysis");
var JudicialReview = require("./Routes/Applications/judicialreview");
app.use(
  bodyParser.urlencoded({
    extended: false
  })
);

app.use(express.static("uploads"));
app.use(express.static("Reports"));
//app.use("/Reports", express.static(__dirname + "Reports"));
app.use(bodyParser.json());
app.use(function(req, res, next) {
  //Enabling CORS
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, contentType,Content-Type, Accept, Authorization"
  );
  next();
});

app.use("/api/ValidateTokenExpiry", ValidateTokenExpiry);
app.use("/AuthToken", auth.router);
app.use("/api/Signup", Signup);
app.use("/api/login", auth.router);
app.use("/api/upload", Uploadfiles);
app.use("/api/sendmail", Mailer.Mailer);
app.use("/api/EmailVerification", EmailVerification);
app.use("/api/Towns", Towns);
app.use("/api/counties", counties);
app.use("/api/applicants", applicants);
app.use("/api/sendsms", sms);
app.use("/api/ResetPassword", ResetPassword);
app.use("/api/schedules", schedules);

app.use("/api/PEUsers", PEUsers);
//mpesa
app.use("/api/MpesaAuthentication", Authentication);
app.use("/api/confirmation", confirmation);
app.use("/api/validation_url", validation_url);
app.use("/api/PE", PE);
app.use(auth.validateToken);

app.use("/api/CaseFollowUp", CaseFollowUp);
app.use("/api/CaseReferrals", CaseReferrals);
app.use("/api/Banks", Banks);
app.use("/api/paymenttypes", paymenttypes);

app.use("/api/issuesfordetermination", issuesfordetermination);
app.use("/api/findingsonissues", findingsonissues);
app.use("/api/PartySubmision", PartySubmision);
app.use("/api/decisiondocuments", decisiondocuments);
app.use("/api/decisionorders", decisionorders);
app.use("/api/Decision", Decision);
app.use("/api/Caseanalysis", caseanalysis);
app.use("/api/additionalsubmissions", additionalsubmissions);
app.use("/api/UpdateProfile", updateprofile);
app.use("/api/users", Users);
app.use("/api/caseofficers", caseofficers);
app.use("/api/usergroups", usergroups);
app.use("/api/roles", Roles);
app.use("/api/auditrails", Auditrails);
app.use("/api/UserAccess", UserAccess);
app.use("/api/GroupAccess", GroupAccess);
app.use("/api/configurations", configurations);
app.use("/api/Approvers", Approvers);
app.use("/api/Approvalmodules", Approvalmodules);
app.use("/api/casedetails", casedetails);
app.use("/api/petypes", petypes);
app.use("/api/committeetypes", committeetypes);
app.use("/api/procurementmethods", procurementmethods);
app.use("/api/stdtenderdocs", stdtenderdocs);
app.use("/api/financialyear", financialyear);
app.use("/api/membertypes", membertypes);
app.use("/api/feesstructure", feesstructure);
app.use("/api/Venues", Venues);
app.use("/api/tendertypes", tendertypes);
app.use("/api/PEResponse", PEResponse);
app.use("/api/Panels", Panels);
app.use("/api/PanelApproval", PanelApproval);
app.use("/api/Branches", Branches);
app.use("/api/interestedparties", interestedparties);
//applications
app.use("/api/tenders", tenders);
app.use("/api/FeesApproval", FeesApproval);
app.use("/api/tenderaddendums", tenderaddendums);
app.use("/api/applications", applications);
app.use("/api/grounds", grounds);
app.use("/api/applicationdocuments", applicationdocuments);
app.use("/api/applicationfees", applicationfees);
app.use("/api/ApplicationsApprovals", ApplicationsApprovals);
app.use("/api/Dashboard", Dashboard);
app.use("/api/NotifyApprover", NotifyApprover);
app.use("/api/DeadlineExtensionApproval", DeadlineExtensionApproval);
app.use("/api/CaseScheduling", CaseScheduling);
app.use("/api/CaseWithdrawal", CaseWithdrawal);
app.use("/api/adjournment", adjournment);
app.use("/api/casesittingsregister", casesittingsregister);
app.use("/api/HearingInProgress", HearingInProgress);
//reports
app.use("/api/GenerateHearingNotice", GenerateHearingNotice);
app.use("/api/HearingNotices", HearingNotices);
app.use("/api/GenerateRB1Form", GenerateRBForm);
app.use("/api/GeneratePanelList", GeneratePanelList);
app.use("/api/GenerateCaseSummary", GenerateCaseSummary);
app.use("/api/GenerateAttendanceregister", GenerateAttendanceregister);
app.use("/api/GenerateDecision", GenerateDecision);
app.use("/api/GenerateCaseAnalysis", GenerateCaseAnalysis);
app.use("/api/ExecutiveReports", ExecutiveReports);
app.use("/api/JudicialReview", JudicialReview);
app.use((req, res, next) => {
  const error = new Error("resource not found");
  error.status = 404;
  next(error);
});

app.use((error, req, res, next) => {
  res.status(error.status || 500);
  res.json({
    error: {
      message: error.message
    }
  });
});

module.exports = app;
