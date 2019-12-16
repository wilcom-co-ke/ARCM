import React, { Component } from "react";

import swal from "sweetalert";
import { Link } from "react-router-dom";
import Select from "react-select";
import CKEditor from "ckeditor4-react";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
var jsPDF = require("jspdf");
require("jspdf-autotable");

class EditEmailtemplates extends Component {
  constructor() {
    super();
    this.state = {
      Module: "",
      Template: "",
      Subject: ""
    };
    this.fetchTemplate = this.fetchTemplate.bind(this);
    this.handleSelectChange = this.handleSelectChange.bind(this);
  }
  onEditorChange = evt => {
    this.setState({
      Template: evt.editor.getData()
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
  handleInputChange = event => {
    event.preventDefault();
    this.setState({ [event.target.name]: event.target.value });
  };

  handleSubmit = event => {
    event.preventDefault();
    const data = {
      Template: this.state.Template,
      Subject: this.state.Subject
    };

    this.postData("/api/EditEmailtemplates/" + this.state.Module, data);
  };
  fetchTemplate = Modulename => {
    this.setState({ Template: "", Subject: "" });
    fetch("/api/EditEmailtemplates/" + Modulename, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(Template => {
        this.setState({
          Template: Template.Template,
          Subject: Template.Subject
        });
      })
      .catch(err => {
        toast.error(err.message);
      });
  };
  handleSelectChange = (UserGroup, actionMeta) => {
    this.setState({ [actionMeta.name]: UserGroup.value });
    this.fetchTemplate(UserGroup.value);
  };
  postData(url = ``, data = {}) {
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      },
      body: JSON.stringify(data)
    })
      .then(response =>
        response.json().then(data => {
          if (data.success) {
            swal("", "Template has been updated!", "success");

            this.setState({ profile: true });
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  }
  render() {
    let divstyles = {
      margin: "0 auto",
      marginTop: "30px",

      width: "100%"
    };
    let divstyles1 = {
      borderRadius: "10px",
      background: "white",
      borderstyle: "solid",
      border: " 1px  grey",
      paddingTop: "15px",
      paddingLeft: "20px",
      paddingBottom: "20px"
    };
    let ModuleOptions = [
      {
        value: "CreatAccount",
        label: "Creat New Account"
      },
      {
        value: "PEAcknowledgement",
        label: "PE Acknowledgement"
      },
      {
        value: "EmailVerification",
        label: "Email Verification"
      },
      {
        value: "Interested_Party_Application_Approved",
        label: "Interested Party Application Approved"
      },
      {
        value: "Judicial_Review",
        label: "Judicial Review"
      },
      {
        value: "Application_Declined",
        label: "Application Declined"
      },
      {
        value: "New_User",
        label: "New User"
      },
      {
        value: "Preliminary_Objections_Fees_Approval",
        label: "Preliminary Objections Fees Approval"
      },
      {
        value: "Application_Approved_Applicant",
        label: "Application Approved (Applicant)"
      },
      {
        value: "ApplicationFees_Approved",
        label: "Application Fees Approved"
      },

      {
        value: "PE_Submited_Response_PE",
        label: "PE Submited Response(PE)"
      },
      {
        value: "PE_Submited_Response",
        label: "PE Submited Response(Others)"
      },
      {
        value: "PE_Submited_Response_CaseOfficer",
        label: "PE Submited Response(Case Officer)"
      },
      {
        value: "Hearing_Notice",
        label: "Hearing Notice"
      },
      {
        value: "Case_Adjournment_Caseofficer",
        label: "Case Adjournment(Caseofficer)"
      },
      {
        value: "Case_Adjournment_Rejected",
        label: "Case Adjournment Rejected"
      },
      {
        value: "Case_Adjournment_Approved",
        label: "Case Adjournment Approved"
      },
      {
        value: "Case_Adjournment_Applicant",
        label: "Case Adjournment Request(Applicant)"
      },
      {
        value: "Case_Adjournment_Approver",
        label: "Case Adjournment Request(Approver)"
      },
      {
        value: "Case_Withdrawal_Rejected",
        label: "Case Withdrawal Rejected"
      },
      {
        value: "Case_Withdrawal_Approved",
        label: "Case Withdrawal Approved"
      },
      {
        value: "Case_Withdrawal_Applicant",
        label: "Case Withdrawal(Applicant)"
      },
      {
        value: "Case_Withdrawal_Approver",
        label: "Case Withdrawal(Approver)"
      },
      {
        value: "Notify_PE",
        label: "Notify PE"
      },
      {
        value: "Officer_Reasinment",
        label: "Case Officer Reasinment"
      },
      {
        value: "PanelMember",
        label: "Panel Member"
      },
      {
        value: "Hearing_Schedule",
        label: "Hearing Schedule"
      },
      {
        value: "Decision_Report_Declined",
        label: "Decision Report Declined"
      },
      {
        value: "Decision_Report_Approval",
        label: "Decision Report Approval"
      },
      {
        value: "PanelApprover",
        label: "Panel Approval"
      },
      {
        value: "Deadline_Extension_Declined",
        label: "Deadline Extension Declined"
      },
      {
        value: "Deadline_Extension_Approved",
        label: "Deadline Extension Approved"
      },
      {
        value: "Deadline_Extension_Approval",
        label: "Deadline Extension Approval"
      },
      {
        value: "Application_Submited_Applicant",
        label: "Application Submited(Applicant)"
      },
      {
        value: "Application_Submited_Approver",
        label: "Application Approval"
      },
      {
        value: "Application_Fees_Approval",
        label: "Application Fees Approval"
      }
      

      
    ];
    return (
      <div>
        <ToastContainer />
        <div className="row wrapper border-bottom white-bg page-heading">
          <div className="col-lg-11">
            <ol className="breadcrumb">
              <li className="breadcrumb-item">
                <h2>EMAIL TEMPLATES</h2>
                {/* <button onClick={this.exportpdf}>PDF</button> */}
              </li>
            </ol>
          </div>
        </div>
        <div style={divstyles}>
          <strong></strong>
          <hr />
          <div style={divstyles1}>
            <div className="row ">
              <div className="col-md-6">
                <div className="row">
                  <div className="col-md-3">
                    <label
                      htmlFor="exampleInputPassword1"
                      className="font-weight-bold"
                    >
                      {" "}
                      Select Module
                    </label>
                  </div>
                  <div className="col-md-8">
                    <Select
                      name="Module"
                      value={this.state.Module}
                      value={ModuleOptions.filter(
                        option => option.value === this.state.Module
                      )}
                      onChange={this.handleSelectChange}
                      options={ModuleOptions}
                      required
                    />
                  </div>
                </div>
              </div>
              <div className="col-md-6">
                <div className="row">
                  <div className="col-md-2">
                    <label
                      htmlFor="exampleInputPassword1"
                      className="font-weight-bold"
                    >
                      {" "}
                      Subject
                    </label>
                  </div>
                  <div className="col-md-8">
                    <input
                      type="text"
                      name="Subject"
                      className="form-control"
                      required
                      value={this.state.Subject}
                      onChange={this.handleInputChange}
                    />
                  </div>
                </div>
              </div>
            </div>
            <br />
            <div class="row">
              <div class="col-sm-12">
                <CKEditor
                  data={this.state.Template}
                  onChange={this.onEditorChange}
                />
              </div>
            </div>
            <br />
            <div className="row">
              <div class="col-sm-10" />
              <div class="col-sm-2">
                <button
                  type="button"
                  onClick={this.handleSubmit}
                  className="btn btn-primary "
                >
                  Update
                </button>
                &nbsp; &nbsp;
                <Link to="/">
                  <button type="button" className="btn btn-danger">
                    Close
                  </button>
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default EditEmailtemplates;
