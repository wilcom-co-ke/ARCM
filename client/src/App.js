import React from "react";
import SideBar from "./SideBar";
import Header from "./Header";
//import { Redirect } from "react-router-dom";
import { Route, Switch } from "react-router-dom";
//import { BrowserRouter, Route, Switch } from "react-router-dom";
//system admin
import Auditrails from "./Forms/SystemAdmin/Auditrails";
import configurations from "./Forms/SystemAdmin/configurations";
import UserGroups from "./Forms/SystemAdmin/UserGroups";
import Roles from "./Forms/SystemAdmin/Roles";
import Users from "./Forms/SystemAdmin/Users";
// import Approvers from "./Forms/SystemAdmin/Approvers";
import NewApprovers from "./Forms/SystemAdmin/NewApprovers";
import caseofficers from "./Forms/SystemAdmin/caseofficers";
import casedetails from "./Forms/Applications/casedetails";
import CaseScheduling from "./Forms/Applications/CaseScheduling";
import CaseAnalysis from "./Forms/Applications/CaseAnalysis";
//general
import Login from "./Login";
import DashBoard from "./DashBoard";
import Footer from "./Footer";
import Notfound from "./Notfound";
import Profile from "./Profile";
import createacc from "./createacc";
import ForgotPassword from "./ForgotPassword";
import decode from "jwt-decode";
import EmailVerification from "./EmailVerification";
import Mymenu from "./Mymenu";
//setups
import procurementmethods from "./Forms/SetUps/procurementmethods";
import petypes from "./Forms/SetUps/petypes";
import committeetypes from "./Forms/SetUps/committeetypes";
import Branches from "./Forms/SetUps/Branches";

import stdtenderdocs from "./Forms/SetUps/stdtenderdocs";
import financialyear from "./Forms/SetUps/financialyear";
import membertypes from "./Forms/SetUps/membertypes";
import feesstructure from "./Forms/SetUps/feesstructure";
import tendertypes from "./Forms/SetUps/tendertypes";
import counties from "./Forms/SetUps/counties";
import PE from "./Forms/SetUps/PE";
import applicants from "./Forms/SetUps/applicants";
import { HashRouter } from "react-router-dom";
import Venues from "./Forms/SetUps/Venues";
import Panels from "./Forms/Applications/Panels";
import PanelApproval from "./Forms/Applications/PanelApproval";
import HearingInprogress from "./Forms/Applications/HearingInprogress";
import CaseProceedings from "./Forms/Applications/CaseProceedings";
//applications
import PEadditionalsubmissions from "./Forms/Applications/PEadditionalsubmissions";
import additionalsubmissions from "./Forms/Applications/additionalsubmissions";
import FeesApproval from "./Forms/Applications/FeesApproval";
import Applications from "./Forms/Applications/Applications";
import CaseWithdrawalApproval from "./Forms/Applications/CaseWithdrawalApproval";
import AdjournmentApproval from "./Forms/Applications/AdjournmentApproval";
import casesittingsregister from "./Forms/Applications/casesittingsregister";
import CaseWithdrawal from "./Forms/Applications/CaseWithdrawal";
import adjournment from "./Forms/Applications/adjournment";
import ApplicationsApprovals from "./Forms/Applications/ApplicationsApprovals";
import AllApplications from "./Forms/Applications/AllApplications";
import MyCases from "./Forms/Applications/MyCases";
import payment from "./Forms/Applications/payment";
import ApplicantProfile from "./Forms/General/ApplicantProfile";
import ResetPassword from "./ResetPassword";
import PEApplications from "./Forms/Applications/PEApplications";
import PEResponse from "./Forms/Applications/PEResponse";
import MyResponse from "./Forms/Applications/MyResponse";
import DeadlinerequestApproval from "./Forms/Applications/DeadlinerequestApproval";
import Response from "./Forms/Applications/Response";
import HearingNotices from "./Forms/Applications/HearingNotices";
import PanelList from "./Forms/Reports/PanelList";
import RB1 from "./Forms/Reports/RB1";
import Attendance from "./Forms/Reports/Attendance";
import CaseSummary from "./Forms/Reports/CaseSummary";
import Logout from "./Logout";
import CloseRegistrations from "./Forms/Applications/CloseRegistrations";
import PreliminaryObjection from "./Forms/Applications/PreliminaryObjection";
import DecisionPreparations from "./Forms/Applications/DecisionPreparations";
import Decision from "./Forms/Applications/Decision";
import CaseReferrals from "./Forms/Applications/CaseReferrals";
import CaseFollowUp from "./Forms/Applications/CaseFollowUp";
import Monthlycases from "./Forms/Reports/Monthlycases";
import PEAppearanceFrequency from "./Forms/Reports/PEAppearanceFrequency";
import PEAppearanceFrequencyPerCategory from "./Forms/Reports/PEAppearanceFrequencyPerCategory";
import requesthandled from "./Forms/Reports/requesthandled";
import DecisionsUploads from "./Forms/Applications/DecisionsUploads";
import DecisionsApproval from "./Forms/Applications/DecisionsApproval";
import JudicialReview from "./Forms/Applications/JudicialReview";
import FeesReport from "./Forms/Reports/FeesReport";
import CustomReport from "./Forms/Reports/CustomReport";
import PreliminaryFeesReport from "./Forms/Reports/PreliminaryFeesReport";
import Banks from "./Forms/SetUps/Banks";
import SMSdetails from "./Forms/SetUps/SMSdetails";
import smtpdetails from "./Forms/SetUps/smtpdetails";

// const checkAuth = () => {
//   let token = localStorage.getItem("token");
//   if (!token) {
//     localStorage.clear();
//     return false;
//   }
//   try {
//     const { exp } = decode(token);
//     if (exp < new Date().getTime() / 1000) {
//       localStorage.clear();
//       return false;
//     }
//   } catch (error) {
//     localStorage.clear();
//     return false;
//   }
//   return true;
// };
// const AuthRoute = ({ component: Component, ...rest }) => (
//   <Route
//     render={props =>
//       checkAuth() ? <Component {...props} /> : (window.location = "#/Logout")
//     }
//   />
// );

function App() {
  let token = localStorage.getItem("token");
  let UserCategory = localStorage.getItem("UserCategory");
  if (token) {
    if (UserCategory === "System_User") {
      return (
        <div id="wrapper">
          <HashRouter>
            <SideBar />
            <Header>
              <Switch>
                <Route path="/Logout" exact component={Logout} />;
                <Route exact path="/" component={DashBoard} />
                <Route exact path="/Users" component={Users} />
                <Route exact path="/Approvers" component={NewApprovers} />
                <Route exact path="/Roles" component={Roles} />
                <Route exct path="/Usergroups" component={UserGroups} />
                <Route exact path="/Auditrails" component={Auditrails} />
                <Route exact path="/CaseReferrals" component={CaseReferrals} />
                <Route exact path="/CaseFollowUp" component={CaseFollowUp} />
                <Route exact path="/Monthlycases" component={Monthlycases} />
                <Route exact path="/FeesReport" component={FeesReport} />
                <Route
                  exact
                  path="/PreliminaryFeesReport"
                  component={PreliminaryFeesReport}
                />
                <Route
                  exact
                  path="/DecisionsUploads"
                  component={DecisionsUploads}
                />
                <Route
                  exact
                  path="/DecisionsApproval"
                  component={DecisionsApproval}
                />
                <Route exact path="/CaseAnalysis" component={CaseAnalysis} />
                <Route
                  exact
                  path="/JudicialReview"
                  component={JudicialReview}
                />
                <Route
                  exact
                  path="/requesthandled"
                  component={requesthandled}
                />
                <Route
                  exact
                  path="/PEAppearanceFrequency"
                  component={PEAppearanceFrequency}
                />
                <Route
                  exact
                  path="/PEAppearanceFrequencyPerCategory"
                  component={PEAppearanceFrequencyPerCategory}
                />
                <Route
                  exact
                  path="/DecisionPreparations"
                  component={DecisionPreparations}
                />
                <Route exact path="/Decision" component={Decision} />
                {/* <Route exact path="/Approvers" component={Approvers} /> */}
                <Route exact path="/casedetails" component={casedetails} />
                <Route exact path="/Branches" component={Branches} />
                <Route exact path="/PanelList" component={PanelList} />
                <Route exact path="/RB1" component={RB1} />
                <Route exact path="/Attendance" component={Attendance} />
                <Route exact path="/FeesApproval" component={FeesApproval} />
                <Route exact path="/CustomReport" component={CustomReport} />
                <Route
                  exact
                  path="/PreliminaryObjectionFees"
                  component={PreliminaryObjection}
                />
                <Route
                  exact
                  path="/HearingInprogress"
                  component={HearingInprogress}
                />
                <Route exact path="/CaseSummary" component={CaseSummary} />
                <Route
                  exact
                  path="/HearingNotices"
                  component={HearingNotices}
                />
                <Route
                  exact
                  path="/casesittingsregister"
                  component={casesittingsregister}
                />
                <Route
                  exact
                  path="/configurations"
                  component={configurations}
                />
                <Route exact path="/home" component={DashBoard} />
                <Route exact path="/Profile" component={Profile} />
                <Route exact path="/ResetPassword" component={ResetPassword} />
                <Route
                  exact
                  path="/CaseProceedings"
                  component={CaseProceedings}
                />
                <Route exact path="/PETypes" component={petypes} />
                <Route exact path="/STDDocs" component={stdtenderdocs} />
                <Route exact path="/membertypes" component={membertypes} />
                <Route exact path="/Charges" component={feesstructure} />
                <Route exact path="/tendertypes" component={tendertypes} />
                <Route exact path="/counties" component={counties} />
                <Route exact path="/PE" component={PE} />
                <Route exact path="/applicants" component={applicants} />
                <Route exact path="/Response" component={Response} />
                <Route exact path="/Venues" component={Venues} />
                <Route exact path="/Panels" component={Panels} />
                <Route exact path="/MyCases" component={MyCases} />
                <Route exact path="/Banks" component={Banks} />
                <Route exact path="/SMSdetails" component={SMSdetails} />
                <Route exact path="/smtpdetails" component={smtpdetails} />
                <Route
                  exact
                  path="/CloseRegistrations"
                  component={CloseRegistrations}
                />
                <Route
                  exact
                  path="/CaseScheduling"
                  component={CaseScheduling}
                />
                <Route
                  exact
                  path="/CaseWithdrawalApproval"
                  component={CaseWithdrawalApproval}
                />
                <Route
                  exact
                  path="/AdjournmentApproval"
                  component={AdjournmentApproval}
                />
                <Route exact path="/PanelApproval" component={PanelApproval} />
                <Route exact path="/caseofficers" component={caseofficers} />
                <Route
                  exact
                  path="/DeadlinerequestApproval"
                  component={DeadlinerequestApproval}
                />
                <Route
                  exact
                  path="/AllApplications"
                  component={AllApplications}
                />
                <Route
                  exact
                  path="/ApplicationsApprovals"
                  component={ApplicationsApprovals}
                />
                <Route exact path="/Applications" component={Applications} />
                <Route exact path="/financialyear" component={financialyear} />
                <Route
                  exact
                  path="/procurementmethods"
                  component={procurementmethods}
                />
                <Route
                  exact
                  path="/CommitteesTypes"
                  component={committeetypes}
                />
                <Route component={Notfound} />
              </Switch>
              <Footer />
            </Header>
          </HashRouter>
        </div>
      );
    } else {
      if (UserCategory === "Applicant") {
        return (
          <div id="wrapper">
            <HashRouter>
              <Mymenu />
              <Header>
                <Switch>
                  <Route path="/Logout" exact component={Logout} />;
                  <Route exact path="/" component={DashBoard} />
                  <Route exact path="/Profile" component={Profile} />
                  <Route exact path="/Decision" component={Decision} />
                  <Route
                    exact
                    path="/ResetPassword"
                    component={ResetPassword}
                  />
                  <Route
                    exact
                    path="/ApplicantProfile"
                    component={ApplicantProfile}
                  />
                  <Route
                    exact
                    path="/additionalsubmissions"
                    component={additionalsubmissions}
                  />
                  <Route exact path="/Applications" component={Applications} />
                  <Route
                    exact
                    path="/CaseWithdrawal"
                    component={CaseWithdrawal}
                  />
                  <Route exact path="/adjournment" component={adjournment} />
                  <Route exact path="/payment" component={payment} />
                  <Route component={Notfound} />
                </Switch>
                <Footer />
              </Header>
            </HashRouter>
          </div>
        );
      } else {
        return (
          <div id="wrapper">
            <HashRouter>
              <Mymenu />
              <Header>
                <Switch>
                  <Route path="/Logout" exact component={Logout} />;
                  <Route exact path="/" component={DashBoard} />
                  <Route exact path="/Profile" component={Profile} />
                  <Route exact path="/PEResponse" component={PEResponse} />
                  <Route exact path="/MyResponse" component={MyResponse} />
                  <Route exact path="/Decision" component={Decision} />
                  <Route
                    exact
                    path="/PEApplications"
                    component={PEApplications}
                  />
                  <Route
                    exact
                    path="/PEadditionalsubmissions"
                    component={PEadditionalsubmissions}
                  />
                  <Route
                    exact
                    path="/ResetPassword"
                    component={ResetPassword}
                  />
                  <Route
                    exact
                    path="/ApplicantProfile"
                    component={ApplicantProfile}
                  />
                  <Route exact path="/Applications" component={Applications} />
                  <Route exact path="/payment" component={payment} />
                  <Route component={Notfound} />
                </Switch>
                <Footer />
              </Header>
            </HashRouter>
          </div>
        );
      }
    }
  } else {
    return (
      <div id="wrapper">
        <HashRouter>
          <Switch>
            <Route path="/Logout" exact component={Logout} />;
            <Route path="/" exact component={Login} />
            <Route path="/Login" exact component={Login} />
            <Route path="/createacc" exact component={createacc} />
            <Route path="/ForgotPassword" exact component={ForgotPassword} />
            <Route
              path="/EmailVerification"
              exact
              strict
              component={EmailVerification}
            />
            <Route component={Notfound} />
          </Switch>
        </HashRouter>
      </div>
    );
  }
}

export default App;
