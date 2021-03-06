import React, { Component } from "react";
import { Link } from "react-router-dom";
class SideBar extends Component {
  constructor() {
    super();
    this.state = {
      loading: true,
      redirect: true,
      privilages: [],
      showMenuCaseManagement: false,
      showMenuDecision: false,
      showMenuBoardmanagement: false,
      showMenuCaseHearing: false,
      showMenuJudicialReview: false,
      showMenuAdmin: true,
      showMenuParameteres: false,
      showMenuFeesSettings: false,
      showMenuReports: false,
      CompanyDetails: [],
      Logo: ""
    };
    this.ProtectRoute = this.ProtectRoute.bind(this);
    this.checkPrivilage = this.checkPrivilage.bind(this);
    this.showMenu = this.showMenu.bind(this);
  }
  showMenu = (Module, event) => {
    event.preventDefault();
    if (Module === "System Administration") {
      this.setState({ showMenuAdmin: !this.state.showMenuAdmin });
      if (this.state.showMenuCaseManagement) {
        this.setState({
          showMenuCaseManagement: !this.state.showMenuCaseManagement
        });
      }
      if (this.state.showMenuJudicialReview) {
        this.setState({
          showMenuJudicialReview: !this.state.showMenuJudicialReview
        });
      }
      if (this.state.showMenuParameteres) {
        this.setState({
          showMenuParameteres: !this.state.showMenuParameteres
        });
      }
      if (this.state.showMenuCaseHearing) {
        this.setState({ showMenuCaseHearing: !this.state.showMenuCaseHearing });
      }
      if (this.state.showMenuReports) {
        this.setState({
          showMenuReports: !this.state.showMenuReports
        });
      }
    } else if (Module === "Fees Settings") {
      this.setState({ showMenuFeesSettings: !this.state.showMenuFeesSettings });
    } else if (Module === "Case Management") {
      this.setState({
        showMenuCaseManagement: !this.state.showMenuCaseManagement
      });
      if (this.state.showMenuJudicialReview) {
        this.setState({
          showMenuJudicialReview: !this.state.showMenuJudicialReview
        });
      }
      if (this.state.showMenuCaseHearing) {
        this.setState({ showMenuCaseHearing: !this.state.showMenuCaseHearing });
      }
      if (this.state.showMenuParameteres) {
        this.setState({
          showMenuParameteres: !this.state.showMenuParameteres
        });
      }
      if (this.state.showMenuAdmin) {
        this.setState({
          showMenuAdmin: !this.state.showMenuAdmin
        });
      }
      if (this.state.showMenuReports) {
        this.setState({
          showMenuReports: !this.state.showMenuReports
        });
      }
    } else if (Module === "Case Hearing") {
      this.setState({ showMenuCaseHearing: !this.state.showMenuCaseHearing });
      if (this.state.showMenuJudicialReview) {
        this.setState({
          showMenuJudicialReview: !this.state.showMenuJudicialReview
        });
      }
      if (this.state.showMenuCaseManagement) {
        this.setState({
          showMenuCaseManagement: !this.state.showMenuCaseManagement
        });
      }
      if (this.state.showMenuParameteres) {
        this.setState({
          showMenuParameteres: !this.state.showMenuParameteres
        });
      }
      if (this.state.showMenuAdmin) {
        this.setState({
          showMenuAdmin: !this.state.showMenuAdmin
        });
      }
      if (this.state.showMenuReports) {
        this.setState({
          showMenuReports: !this.state.showMenuReports
        });
      }
    } else if (Module === "Decision") {
      this.setState({ showMenuDecision: !this.state.showMenuDecision });
    } else if (Module === "Board Management") {
      this.setState({
        showMenuBoardmanagement: !this.state.showMenuBoardmanagement
      });
    } else if (Module === "Reports") {
      this.setState({
        showMenuReports: !this.state.showMenuReports
      });
      if (this.state.showMenuJudicialReview) {
        this.setState({
          showMenuJudicialReview: !this.state.showMenuJudicialReview
        });
      }
      if (this.state.showMenuCaseManagement) {
        this.setState({
          showMenuCaseManagement: !this.state.showMenuCaseManagement
        });
      }
      if (this.state.showMenuParameteres) {
        this.setState({
          showMenuParameteres: !this.state.showMenuParameteres
        });
      }
      if (this.state.showMenuCaseHearing) {
        this.setState({ showMenuCaseHearing: !this.state.showMenuCaseHearing });
      }
      if (this.state.showMenuAdmin) {
        this.setState({ showMenuAdmin: !this.state.showMenuAdmin });
      }
    } else if (Module === "System parameteres") {
      this.setState({
        showMenuParameteres: !this.state.showMenuParameteres
      });
      if (this.state.showMenuJudicialReview) {
        this.setState({
          showMenuJudicialReview: !this.state.showMenuJudicialReview
        });
      }
      if (this.state.showMenuCaseManagement) {
        this.setState({
          showMenuCaseManagement: !this.state.showMenuCaseManagement
        });
      }
      if (this.state.showMenuAdmin) {
        this.setState({
          showMenuAdmin: !this.state.showMenuAdmin
        });
      }
      if (this.state.showMenuReports) {
        this.setState({
          showMenuReports: !this.state.showMenuReports
        });
      }
    } else if (Module === "Judicial Review") {
      this.setState({
        showMenuJudicialReview: !this.state.showMenuJudicialReview
      });

      if (this.state.showMenuCaseManagement) {
        this.setState({
          showMenuCaseManagement: !this.state.showMenuCaseManagement
        });
      }
      if (this.state.showMenuAdmin) {
        this.setState({
          showMenuAdmin: !this.state.showMenuAdmin
        });
      }
      if (this.state.showMenuReports) {
        this.setState({
          showMenuReports: !this.state.showMenuReports
        });
      }
      if (this.state.showMenuParameteres) {
        this.setState({
          showMenuParameteres: !this.state.showMenuParameteres
        });
      }
    }
  };

  ProtectRoute() {
    fetch("/api/UserAccess", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(data => {
        if (data.length > 0) {
          this.setState({ privilages: data });
        } else {
          localStorage.clear();
          return (window.location = "/#/Logout");
        }
      })
      .catch(err => {
        this.setState({ loading: false, redirect: true });
      });
    //end
  }

  checkPrivilage(key, value) {
    let array = [...this.state.privilages];
    for (var i = 0; i < array.length; i++) {
      if (array[i][key] === value) {
        return array[i];
      }
    }
    return null;
  }
  fetchCompanyDetails = () => {
    fetch("/api/configurations/" + 1, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(data => {
        if (data.length > 0) {
          this.setState({ CompanyDetails: data });
          this.setState({ Logo: data[0].Logo });
        } else {
          // swal("Oops!", data.message, "error");
        }
      })
      .catch(err => {
        // swal("Oops!", err.message, "error");
      });
  };
  componentDidMount() {
    let token = localStorage.getItem("token");

    if (token == null) {
      localStorage.clear();
      return (window.location = "/#/Logout");
    } else {
      fetch("/api/ValidateTokenExpiry", {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "x-access-token": localStorage.getItem("token")
        }
      })
        .then(response =>
          response.json().then(data => {
            if (data.success) {
              this.ProtectRoute();
              this.fetchCompanyDetails();
            } else {
              localStorage.clear();
              return (window.location = "/#/Logout");
            }
          })
        )
        .catch(err => {
          localStorage.clear();
          return (window.location = "/#/Logout");
        });
    }
  }
  validaterole = (rolename, action) => {
    let array = [...this.state.privilages];
    let AuditTrailsObj = array.find(obj => obj.RoleName === rolename);
    if (AuditTrailsObj) {
      if (action === "AddNew") {
        if (AuditTrailsObj.AddNew) {
          return true;
        } else {
          return false;
        }
      } else if (action === "View") {
        if (AuditTrailsObj.View) {
          return true;
        } else {
          return false;
        }
      } else if (action === "Edit") {
        if (AuditTrailsObj.Edit) {
          return true;
        } else {
          return false;
        }
      } else if (action === "Export") {
        if (AuditTrailsObj.Export) {
          return true;
        } else {
          return false;
        }
      } else if (action == "Remove") {
        if (AuditTrailsObj.Remove) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  };
  ViewFile = (k, e) => {
    let filepath =
      process.env.REACT_APP_BASE_URL + "/profilepics/ARCMS-UserGuide.pdf";
    window.open(filepath);
    //this.setState({ openFileViewer: true });
  };
  render() {
    let photostyle = {
      height: 140,
      width: 200,
      background: "#a7b1c2",
      margin: 10,
      "border-radius": 2
    };

    let MenuStyle = {
      color: "#E7E7E7",
      cursor: "pointer",
      padding: "14px 20px 14px 25px",
      display: "block",
      "font-weight": 600,
      "font-size": 14
      // "font-family": `"Helvetica Neue", Helvetica, Arial, sans - serif`
    };
    return (
      <nav className="navbar-default navbar-static-side" role="navigation">
        <div className="sidebar-collapse">
          <ul className="nav metismenu" id="side-menu">
            <li className="">
              <div className="dropdown profile-element">
                <img
                  src={
                    process.env.REACT_APP_BASE_URL +
                    "/profilepics/" +
                    this.state.Logo
                  }
                  style={photostyle}
                />
              </div>
            </li>
            <DashBoards validaterole={this.validaterole} />
            <SystemAdmin
              validaterole={this.validaterole}
              showMenu={this.showMenu}
              showmenuvalue={this.state.showMenuAdmin}
              MenuStyle={MenuStyle}
            />
            <Parameteres
              validaterole={this.validaterole}
              showMenu={this.showMenu}
              showmenuvalue={this.state.showMenuParameteres}
              MenuStyle={MenuStyle}
            />

            <CaseManagement
              validaterole={this.validaterole}
              showMenu={this.showMenu}
              showmenuvalue={this.state.showMenuCaseManagement}
              MenuStyle={MenuStyle}
            />
            <CaseHearing
              validaterole={this.validaterole}
              showMenu={this.showMenu}
              showmenuvalue={this.state.showMenuCaseHearing}
              MenuStyle={MenuStyle}
            />
            <JudicialReview
              validaterole={this.validaterole}
              showMenu={this.showMenu}
              showmenuvalue={this.state.showMenuJudicialReview}
              MenuStyle={MenuStyle}
            />

            {/* <Decision
              validaterole={this.validaterole}
              showMenu={this.showMenu}
              showmenuvalue={this.state.showMenuDecision}
              MenuStyle={MenuStyle}
            />
            <Boardmanagement
              validaterole={this.validaterole}
              showMenu={this.showMenu}
              showmenuvalue={this.state.showMenuBoardmanagement}
              MenuStyle={MenuStyle}
            /> */}
            <Reports
              validaterole={this.validaterole}
              showMenu={this.showMenu}
              showmenuvalue={this.state.showMenuReports}
              MenuStyle={MenuStyle}
            />
            <Help ViewFile={this.ViewFile} />
          </ul>
        </div>
      </nav>
    );
  }
}
const Reports = props => {
  if (props.validaterole("Reports", "View")) {
    return (
      <li className="">
        <li onClick={e => props.showMenu("Reports", e)} style={props.MenuStyle}>
          <i className="fa fa-cogs" />{" "}
          <span className="nav-label">Reports and Inquiries</span>
        </li>
        {props.showmenuvalue ? (
          <ul className="nav nav-second-level">
            {props.validaterole("Decisions", "View") ? (
              <li>
                <Link to="/Decision">
                  <i className="fa fa-tasks" />
                  Decisions
                </Link>
              </li>
            ) : null}

            {props.validaterole("Case Summary", "View") ? (
              <li>
                <Link to="/CaseSummary">
                  <i className="fa fa-user-plus" />
                  Case Summary
                </Link>
              </li>
            ) : null}
            {props.validaterole("Panel List", "View") ? (
              <li>
                <Link to="/PanelList">
                  <i className="fa fa-user-plus" />
                  Panels
                </Link>
              </li>
            ) : null}
            {props.validaterole("Hearing Notices", "View") ? (
              <li>
                <Link to="/HearingNotices">
                  <i className="fa fa-address-card" />
                  Hearing Notices
                </Link>
              </li>
            ) : null}
            {props.validaterole("RB1", "View") ? (
              <li>
                <Link to="/RB1">
                  <i className="fa fa-user-plus" />
                  RB1
                </Link>
              </li>
            ) : null}

            {props.validaterole("Attendance", "View") ? (
              <li>
                <Link to="/Attendance">
                  <i className="fa fa-address-card" />
                  Attendance
                </Link>
              </li>
            ) : null}
            {props.validaterole("PE Appearance Frequency", "View") ? (
              <li>
                <Link to="/PEAppearanceFrequencyPerCategory">
                  <i className="fa fa-address-card" />
                  PE Appearance Frequency
                </Link>
              </li>
            ) : null}
            {props.validaterole("Monthly Cases", "View") ? (
              <li>
                <Link to="/Monthlycases">
                  <i className="fa fa-address-card" />
                  Monthly Cases
                </Link>
              </li>
            ) : null}

            {props.validaterole("Requests handled", "View") ? (
              <li>
                <Link to="/requesthandled">
                  <i className="fa fa-address-card" />
                  Requests handled
                </Link>
              </li>
            ) : null}
            {props.validaterole("Fees Report", "View") ? (
              <li>
                <Link to="/FeesReport">
                  <i className="fa fa-address-card" />
                  Application Fees
                </Link>
              </li>
            ) : null}
            {props.validaterole("Fees Report", "View") ? (
              <li>
                <Link to="/PreliminaryFeesReport">
                  <i className="fa fa-address-card" />
                  Preliminary Objection Fees
                </Link>
              </li>
            ) : null}

            {props.validaterole("Applications Custom Report", "View") ? (
              <li>
                <Link to="/CustomReport">
                  <i className="fa fa-address-card" />
                  Applications Custom Report
                </Link>
              </li>
            ) : null}
          </ul>
        ) : null}
      </li>
    );
  } else {
    return <div />;
  }
};

const CaseHearing = props => {
  if (props.validaterole("Case Hearing", "View")) {
    return (
      <li className="">
        <li
          onClick={e => props.showMenu("Case Hearing", e)}
          style={props.MenuStyle}
        >
          <i className="fa fa-cogs" />{" "}
          <span className="nav-label">Case Hearing</span>
        </li>
        {props.showmenuvalue ? (
          <ul className="nav nav-second-level">
            {props.validaterole("Registration", "View") ? (
              <li>
                <Link to="/casesittingsregister">
                  <i className="fa fa-address-card-o" aria-hidden="true" />
                  Registration
                </Link>
              </li>
            ) : null}
            {props.validaterole("Registration", "View") ? (
              <li>
                <Link to="/CloseRegistrations">
                  <i className="fa fa-address-card-o" aria-hidden="true" />
                  Close Registrations
                </Link>
              </li>
            ) : null}

            {props.validaterole("Registration", "View") ? (
              <li>
                <Link to="/HearingInprogress">
                  <i className="fa fa-address-card-o" aria-hidden="true" />
                  Hearing In progress
                </Link>
              </li>
            ) : null}
            {props.validaterole("Case Proceedings", "View") ? (
              <li>
                <Link to="/CaseProceedings">
                  <i className="fa fa-address-card-o" aria-hidden="true" />
                  Case Proceedings
                </Link>
              </li>
            ) : null}

            {props.validaterole("Decision", "View") ? (
              <li>
                <Link to="/DecisionPreparations">
                  <i className="fa fa-tasks" />
                  Decision Preparations
                </Link>
              </li>
            ) : null}
            {/* {props.validaterole("Decision", "View") ? (
              <li>
                <Link to="/DecisionsUploads">
                  <i className="fa fa-tasks" />
                  Decisions Uploads
                </Link>
              </li>
            ) : null} */}
            {props.validaterole("Decision", "View") ? (
              <li>
                <Link to="/DecisionsApproval">
                  <i className="fa fa-tasks" />
                  Decisions Approval
                </Link>
              </li>
            ) : null}

            {props.validaterole("Case Scheduling", "View") ? (
              <li>
                <Link to="/CaseScheduling">
                  <i className="fa fa-tasks" />
                  Reading Scheduling
                </Link>
              </li>
            ) : null}
            {props.validaterole("Case FollowUp", "View") ? (
              <li>
                <Link to="/CaseFollowUp">
                  <i className="fa fa-tasks" />
                  Follow Up
                </Link>
              </li>
            ) : null}
            {props.validaterole("Case Referrals", "View") ? (
              <li>
                <Link to="/CaseReferrals">
                  <i className="fa fa-tasks" />
                  Case Referrals
                </Link>
              </li>
            ) : null}
          </ul>
        ) : null}
      </li>
    );
  } else {
    return <div />;
  }
};
const CaseManagement = props => {
  if (props.validaterole("Case Management", "View")) {
    return (
      <li className="">
        <li
          onClick={e => props.showMenu("Case Management", e)}
          style={props.MenuStyle}
        >
          <i className="fa fa-cogs" />{" "}
          <span className="nav-label">Case Management</span>
        </li>
        {props.showmenuvalue ? (
          <ul className="nav nav-second-level">
            {props.validaterole("Case officers", "View") ? (
              <li>
                <Link to="/MyCases">
                  <i className="fa fa-tasks" />
                  My Cases
                </Link>
              </li>
            ) : null}
            {props.validaterole("Fees Approval", "View") ? (
              <li>
                <Link to="/FeesApproval">
                  <i className="fa fa-tasks" />
                  Application Fees Confirmation
                </Link>
              </li>
            ) : null}
            {props.validaterole("Fees Approval", "View") ? (
              <li>
                <Link to="/PreliminaryObjectionFees">
                  <i className="fa fa-tasks" />
                  Preliminary Objection Fees
                </Link>
              </li>
            ) : null}

            {props.validaterole("Applications Approval", "View") ? (
              <li>
                <Link to="/ApplicationsApprovals">
                  <i className="fa fa-tasks" />
                  Applications Approval
                </Link>
              </li>
            ) : null}

            {props.validaterole("Case Management", "View") ? (
              <li>
                <Link to="/Response">
                  <i className="fa fa-tasks" />
                  PE Response
                </Link>
              </li>
            ) : null}
            {props.validaterole("Case Analysis", "View") ? (
              <li>
                <Link to="/CaseAnalysis">
                  <i className="fa fa-tasks" />
                  Case Analysis
                </Link>
              </li>
            ) : null}
            {props.validaterole("Deadline Extension Approval", "View") ? (
              <li>
                <Link to="/DeadlinerequestApproval">
                  <i className="fa fa-tasks" />
                  Deadline Extension
                </Link>
              </li>
            ) : null}
            {props.validaterole("Panel", "View") ? (
              <li>
                <Link to="/Panels">
                  <i className="fa fa-tasks" />
                  Panel Formation
                </Link>
              </li>
            ) : null}
            {props.validaterole("Panels Approval", "View") ? (
              <li>
                <Link to="/PanelApproval">
                  <i className="fa fa-tasks" />
                  Panel Approval
                </Link>
              </li>
            ) : null}

            {props.validaterole("Case Scheduling", "View") ? (
              <li>
                <Link to="/CaseScheduling">
                  <i className="fa fa-tasks" />
                  Case Scheduling
                </Link>
              </li>
            ) : null}

            {props.validaterole("Case Adjournment", "View") ? (
              <li>
                <Link to="/AdjournmentApproval">
                  <i className="fa fa-tasks" />
                  Adjournment Approval
                </Link>
              </li>
            ) : null}
            {props.validaterole("Case Withdrawal", "View") ? (
              <li>
                <Link to="/CaseWithdrawalApproval">
                  <i className="fa fa-tasks" />
                  Withdrawal of Appeal
                </Link>
              </li>
            ) : null}
            {props.validaterole("Applications", "View") ? (
              <li>
                <Link to="/AllApplications">
                  <i className="fa fa-tasks" />
                  All Applications
                </Link>
              </li>
            ) : null}
          </ul>
        ) : null}
      </li>
    );
  } else {
    return <div />;
  }
};
const JudicialReview = props => {
  if (props.validaterole("Judicial Review", "View")) {
    return (
      <li className="">
        <li
          onClick={e => props.showMenu("Judicial Review", e)}
          style={props.MenuStyle}
        >
          <i className="fa fa-cogs" />{" "}
          <span className="nav-label">Judicial Review</span>
        </li>
        {props.showmenuvalue ? (
          <ul className="nav nav-second-level">
            {props.validaterole("Applications", "View") ? (
              <li>
                <Link to="/AllApplications">
                  <i className="fa fa-tasks" />
                  Judicial registration
                </Link>
              </li>
            ) : null}
            {props.validaterole("Judicial Review", "View") ? (
              <li>
                <Link to="/JudicialReview">
                  <i className="fa fa-tasks" />
                  Judicial Review
                </Link>
              </li>
            ) : null}
          </ul>
        ) : null}
      </li>
    );
  } else {
    return <div />;
  }
};

const SystemAdmin = props => {
  if (props.validaterole("System Administration", "View")) {
    return (
      <li>
        <li
          className=""
          onClick={e => props.showMenu("System Administration", e)}
          style={props.MenuStyle}
        >
          <i className="fa fa-cogs" />{" "}
          <span className="nav-label">System Administration</span>
        </li>
        {props.showmenuvalue ? (
          <ul className="nav nav-second-level">
            {props.validaterole("System Configurations", "View") ? (
              <li>
                <Link to="/configurations">
                  <i className="fa fa-user-plus " />
                  Configurations
                </Link>
              </li>
            ) : null}
            {props.validaterole("System Users", "View") ? (
              <li>
                <Link to="/Users">
                  <i className="fa fa-user-plus " />
                  System users
                </Link>
              </li>
            ) : null}
            {/* {props.validaterole("Roles", "View") ? (
              <li>
                <Link to="/Roles">
                  <i className="fa fa-user-plus " />
                  Roles
                </Link>
              </li>
            ) : null} */}
            {props.validaterole("Security Groups", "View") ? (
              <li>
                <Link to="/Usergroups">
                  <i className="fa fa-user-plus " />
                  Security Groups
                </Link>
              </li>
            ) : null}
            {props.validaterole("Audit Trails", "View") ? (
              <li>
                <Link to="/Auditrails">
                  <i className="fa fa-user-plus " />
                  Auditrails
                </Link>
              </li>
            ) : null}
            {props.validaterole("Approvers", "View") ? (
              <li>
                <Link to="/Approvers">
                  <i className="fa fa-user-plus " />
                  Approval Hierachy
                </Link>
              </li>
            ) : null}
            {props.validaterole("Case officers", "View") ? (
              <li>
                <Link to="/caseofficers">
                  <i className="fa fa-user-plus " />
                  Case officers
                </Link>
              </li>
            ) : null}
            {props.validaterole("Case officers", "View") ? (
              <li>
                <Link to="/casedetails">
                  <i className="fa fa-user-plus " />
                  Officer ReAssignment
                </Link>
              </li>
            ) : null}
          </ul>
        ) : null}
      </li>
    );
  } else {
    return <div />;
  }
};
const Help = props => {
  return (
    <li
      className=""
      onClick={props.ViewFile}
      style={{ marginLeft: "25px", color: "white", cursor: "pointer" }}
    >
      <li>
        <i className="fa fa-cogs" />{" "}
        <span className="nav-label">User Manual</span>
      </li>
    </li>
  );
};
const DashBoards = props => {
  if (props.validaterole("DashBoards", "View")) {
    return (
      <li className="">
        <Link to="/Home">
          <i className="fa fa-dashboard" />{" "}
          <span className="nav-label">DashBoard</span>
        </Link>
      </li>
    );
  } else {
    return <div />;
  }
};
const Parameteres = props => {
  if (props.validaterole("System parameteres", "View")) {
    return (
      <li className="">
        <li
          onClick={e => props.showMenu("System parameteres", e)}
          style={props.MenuStyle}
        >
          <i className="fa fa-cogs" />{" "}
          <span className="nav-label">System Parameters</span>
        </li>
        {props.showmenuvalue ? (
          <ul className="nav nav-second-level">
            {props.validaterole("Departments", "View") ? (
              <li>
                <Link to="/Departments">
                  <i className="fa fa-user-plus " />
                  Departments
                </Link>
              </li>
            ) : null}

            {props.validaterole("Branches", "View") ? (
              <li>
                <Link to="/Branches">
                  <i className="fa fa-user-plus " />
                  Branches
                </Link>
              </li>
            ) : null}
            {props.validaterole("PeTypes", "View") ? (
              <li>
                <Link to="/PETypes">
                  <i className="fa fa-user-plus " />
                  PETypes
                </Link>
              </li>
            ) : null}
            {props.validaterole("SMS Details", "View") ? (
              <li>
                <Link to="/SMSdetails">
                  <i className="fa fa-user-plus " />
                  SMS Details
                </Link>
              </li>
            ) : null}
            {props.validaterole("SMTP Details", "View") ? (
              <li>
                <Link to="/smtpdetails">
                  <i className="fa fa-folder" />
                  SMTP Details
                </Link>
              </li>
            ) : null}
            {/* {props.validaterole("Committee Types", "View") ? (
              <li>
                <Link to="/CommitteesTypes">
                  <i className="fa fa-cogs" />
                  Committees Types
                </Link>
              </li>
            ) : null} */}
            {/* {props.validaterole("Financial Year", "View") ? (
              <li>
                <Link to="/financialyear">
                  <i className="fa fa-calendar" />
                  Financial year
                </Link>
              </li>
            ) : null} */}
            {props.validaterole("Banks", "View") ? (
              <li>
                <Link to="/Banks">
                  <i className="fa fa-calendar" />
                  Banks
                </Link>
              </li>
            ) : null}

            {/* {props.validaterole("Member types", "View") ? (
              <li>
                <Link to="/membertypes">
                  <i className="fa fa-users" />
                  Member Types
                </Link>
              </li>
            ) : null} */}
            {props.validaterole("Fees structure", "View") ? (
              <li>
                <Link to="/Charges">
                  <i className="fa fa-money" />
                  Charges
                </Link>
              </li>
            ) : null}
            {props.validaterole("Fees structure", "View") ? (
              <li>
                <Link to="/tendertypes">
                  <i className="fa fa-columns " />
                  Tender Types
                </Link>
              </li>
            ) : null}
            {/* {props.validaterole("Counties", "View") ? (
              <li>
                <Link to="/counties">
                  <i className="fa fa-money" />
                  Counties
                </Link>
              </li>
            ) : null} */}
            {props.validaterole("Procurement Entities", "View") ? (
              <li>
                <Link to="/PE">
                  <i className="fa fa-money" />
                  Procurement Entities
                </Link>
              </li>
            ) : null}
            {props.validaterole("Applicants", "View") ? (
              <li>
                <Link to="/applicants">
                  <i className="fa fa-money" />
                  Applicants
                </Link>
              </li>
            ) : null}
            {props.validaterole("Venues", "View") ? (
              <li>
                <Link to="/Venues">
                  <i className="fa fa-money" />
                  Venues
                </Link>
              </li>
            ) : null}
          </ul>
        ) : null}
      </li>
    );
  } else {
    return <div />;
  }
};
export default SideBar;
