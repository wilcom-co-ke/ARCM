import React, { Component } from "react";
import swal from "sweetalert";
import Select from "react-select";
import Table from "../../Table";
import TableWrapper from "../../TableWrapper";
import { Link } from "react-router-dom";

import { ToastContainer, toast } from "react-toastify";
var dateFormat = require("dateformat");
var jsPDF = require("jspdf");
require("jspdf-autotable");
var _ = require("lodash");
class JudicialReview extends Component {
  constructor() {
    super();
    this.state = {
      casedetails: [],
      privilages: [],

      ApplicantDetails: [],
      ApplicationNo: "",
      PEDetails: [],
      summary: false,
      Unbooking: false,
      JudicialDocuments: [],
      JudicialDetails: []
    };
  }
  fetchJudicialDocuments = ApplicationNo => {
    this.setState({ JudicialDocuments: [] });

    fetch("/api/JudicialReview/" + ApplicationNo, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(JudicialDocuments => {
        if (JudicialDocuments.length > 0) {
          this.setState({ JudicialDocuments: JudicialDocuments });

          this.setState({ JudicialDocuments: JudicialDocuments });
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  fetchJudicialDetails = ApplicationNo => {
    this.setState({ JudicialDetails: [] });

    fetch("/api/JudicialReview/" + ApplicationNo + "/Details", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(JudicialDetails => {
        if (JudicialDetails.length > 0) {
          console.log(JudicialDetails);
          this.setState({ JudicialDetails: JudicialDetails });
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  fetchPEDetails = ApplicationNo => {
    this.setState({ PEDetails: [] });
    fetch("/api/PE/" + ApplicationNo + "/ApplicantDetails", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(PEDetails => {
        if (PEDetails.length > 0) {
          this.setState({ PEDetails: PEDetails });
        } else {
          swal("", PEDetails.message, "error");
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  fetchApplicantDetails = ApplicationNo => {
    this.setState({ ApplicantDetails: [] });
    fetch("/api/Panels/" + ApplicationNo + "/ApplicantDetails", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(ApplicantDetails => {
        if (ApplicantDetails.length > 0) {
          this.setState({ ApplicantDetails: ApplicantDetails });
        } else {
          swal("", ApplicantDetails.message, "error");
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  handleSelectChange = (UserGroup, actionMeta) => {
    if (actionMeta.name === "Branch") {
      this.fetchVenuesPerBranch(UserGroup.value, UserGroup.label);
    }
    if (actionMeta.name === "VenueID") {
      this.setState({ VenueID: UserGroup.value });
      this.setState({ RoomName: UserGroup.label });
    }
    this.setState({ [actionMeta.name]: UserGroup.value });
  };
  handleInputChange = event => {
    event.preventDefault();
    this.setState({ [event.target.name]: event.target.value });
  };

  fetchcasedetails = () => {
    this.setState({ casedetails: [] });
    fetch("/api/JudicialReview", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(casedetails => {
        if (casedetails.length > 0) {
          this.setState({ casedetails: casedetails });
        } else {
          toast.error(casedetails.message);
        }
      })
      .catch(err => {
        toast.error(err.message);
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
              this.fetchcasedetails();
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

  switchMenu = e => {
    this.setState({ summary: false });
  };
  ViewFile = (k, e) => {
    let filepath = k.Path + "/" + k.Name;
    window.open(filepath);
    //this.setState({ openFileViewer: true });
  };
  ScheduleCase = k => {
    const data = {
      ApplicationNo: k.ApplicationNo,
      summary: true,
      PEName: k.PEName,
      FilingDate: k.FilingDate,
      PEServedOn: k.PEServedOn
    };
    this.setState(data);
    this.fetchApplicantDetails(k.ApplicationNo);
    this.fetchJudicialDocuments(k.ApplicationNo);
    this.fetchJudicialDetails(k.ApplicationNo);
    this.fetchPEDetails(k.ApplicationNo);
  };

  render() {
    let FormStyle = {
      margin: "20px"
    };

    let headingstyle = {
      color: "#7094db"
    };

    const ColumnData = [
      {
        label: "Application No",
        field: "Name",
        sort: "asc",
        width: 200
      },
      {
        label: "Procuring Entity",
        field: "ProcuringEntity",
        sort: "asc",
        width: 200
      },

      {
        label: "action",
        field: "action",
        sort: "asc",
        width: 200
      }
    ];
    let Rowdata1 = [];

    const rows = [...this.state.casedetails];
    if (rows.length > 0) {
      rows.forEach(k => {
        const Rowdata = {
          Name: k.ApplicationNo,
          ProcuringEntity: k.PEName,

          action: (
            <span>
              <a
                style={{ color: "#007bff" }}
                onClick={e => this.ScheduleCase(k, e)}
              >
                View
              </a>
            </span>
          )
        };
        Rowdata1.push(Rowdata);
      });
    }

    let DivvenuesStyle = {
      width: "90%",
      margin: "0 auto"
    };

    let ViewFile = this.ViewFile;

    if (this.state.summary) {
      return (
        <div>
          <ToastContainer />
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-10">
              <ol className="breadcrumb">
                <li className="breadcrumb-item">
                  <h2>
                    Judicial Review For Application:{" "}
                    <span style={headingstyle}>{this.state.ApplicationNo}</span>{" "}
                  </h2>
                </li>
              </ol>
            </div>
            <div className="col-lg-2">
              <div className="row wrapper ">
                <button
                  type="button"
                  style={{ marginTop: 40 }}
                  onClick={this.openModal}
                  onClick={this.switchMenu}
                  className="btn btn-primary  "
                >
                  Back
                </button>
              </div>
            </div>
          </div>
          <div className="wrapper wrapper-content animated fadeInRight">
            <div className="row">
              <div className="col-lg-1"></div>
              <div className="col-lg-10  rounded bg-white">
                <br />
                <div class="row">
                  <div class="col-sm-6" style={{ "margin-left": "30" }}>
                    <h3 style={headingstyle}>Judicial Review</h3>
                  </div>
                </div>

                {this.state.JudicialDetails.map((k, i) => {
                  return (
                    <form style={FormStyle}>
                      <div class="row">
                        <div class="col-sm-2">
                          <label
                            for="ApplicantID"
                            className="font-weight-bold "
                          >
                            Case NO{" "}
                          </label>
                        </div>

                        <div class="col-sm-4">
                          <div className="form-group">
                            <input
                              type="text"
                              name="ApplicationNo"
                              disabled
                              value={k.CaseNO}
                              className="form-control"
                            />
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-sm-12">
                          <div class="col-sm-12 ">
                            <div className="row border border-success rounded ">
                              <table className="table table-borderless table-sm">
                                <div>
                                  <tr>
                                    <td className="font-weight-bold">Court:</td>
                                    <td>{k.Court}</td>
                                  </tr>
                                  <tr>
                                    <td className="font-weight-bold">Town:</td>
                                    <td>{k.Town}</td>
                                  </tr>

                                  <tr>
                                    <td className="font-weight-bold">
                                      Description:
                                    </td>
                                    <td>{k.Description}</td>
                                  </tr>
                                  <tr>
                                    <td className="font-weight-bold">
                                      Date Filed:
                                    </td>
                                    <td>
                                      {dateFormat(
                                        new Date(
                                          k.DateFilled
                                        ).toLocaleDateString(),
                                        "mediumDate"
                                      )}
                                    </td>
                                  </tr>
                                  <tr>
                                    <td className="font-weight-bold">
                                      Applicant
                                    </td>
                                    <td>{k.Applicant}</td>
                                  </tr>
                                  <tr>
                                    <td className="font-weight-bold">
                                      Date Recieved
                                    </td>
                                    <td>
                                      {dateFormat(
                                        new Date(
                                          k.DateRecieved
                                        ).toLocaleDateString(),
                                        "mediumDate"
                                      )}
                                    </td>
                                  </tr>
                                  <tr>
                                    <td className="font-weight-bold">
                                      Date of Court Rulling
                                    </td>
                                    <td>
                                      {dateFormat(
                                        new Date(
                                          k.DateofCourtRulling
                                        ).toLocaleDateString(),
                                        "mediumDate"
                                      )}
                                    </td>
                                  </tr>
                                  <tr>
                                    <td className="font-weight-bold">
                                      Date of Replying Affidavit
                                    </td>
                                    <td>
                                      {dateFormat(
                                        new Date(
                                          k.DateofReplyingAffidavit
                                        ).toLocaleDateString(),
                                        "mediumDate"
                                      )}
                                    </td>
                                  </tr>
                                  <tr>
                                    <td className="font-weight-bold">Ruling</td>
                                    <td>{k.Ruling}</td>
                                  </tr>
                                </div>
                              </table>
                            </div>
                          </div>
                        </div>
                      </div>
                    </form>
                  );
                })}
                <form style={FormStyle}>
                  <h3 style={headingstyle}>Documents</h3>
                  <div className="row">
                    <table className="table table-sm-7">
                      <th>#</th>
                      <th>Document Description</th>
                      <th>FileName</th>
                      <th>Actions</th>
                      <th>Date Submited</th>

                      {this.state.JudicialDocuments.map((k, i) => {
                        return (
                          <tr>
                            <td>{i + 1}</td>
                            <td>{k.Description}</td>
                            <td>{k.Name}</td>
                            <td>
                              {" "}
                              {dateFormat(
                                new Date(k.Created_At).toLocaleDateString(),
                                "mediumDate"
                              )}
                            </td>

                            <td>
                              <span>
                                <a
                                  style={{ color: "#007bff" }}
                                  onClick={e => ViewFile(k, e)}
                                >
                                  &nbsp; View
                                </a>
                              </span>
                            </td>
                          </tr>
                        );
                      })}
                    </table>
                  </div>
                  <br />
                  <div className="row">
                    <table className="table table-borderless table-sm"></table>
                  </div>
                </form>

                <div className="row">
                  <div style={DivvenuesStyle}></div>
                </div>

                <br />
              </div>
            </div>
            <br />
            <div className="row">
              <div className="col-lg-1"></div>
              <div className="col-lg-10  bg-white">
                <h3 style={headingstyle}>Application Details</h3>
                <form style={FormStyle} onSubmit={this.SaveTenders}>
                  <div class="row">
                    <div class="col-sm-6">
                      <div class="col-sm-11 ">
                        <div className="row">
                          <div className="col-sm-12">
                            <h3 style={headingstyle}>Applicant</h3>
                          </div>
                        </div>
                        <div className="row border border-success rounded">
                          <table className="table table-borderless table-sm">
                            {this.state.ApplicantDetails.map((r, i) => (
                              <div>
                                <tr>
                                  <td className="font-weight-bold">Name:</td>
                                  <td>{r.Name}</td>
                                </tr>
                                <tr>
                                  <td className="font-weight-bold">Address:</td>
                                  <td>
                                    {r.POBox +
                                      "-" +
                                      r.PostalCode +
                                      " " +
                                      r.Town}
                                  </td>
                                </tr>
                                <tr>
                                  <td className="font-weight-bold">Email:</td>
                                  <td>{r.Email}</td>
                                </tr>
                                <tr>
                                  <td className="font-weight-bold">
                                    Telephone
                                  </td>
                                  <td>{r.Mobile}</td>
                                </tr>
                              </div>
                            ))}
                          </table>
                        </div>
                      </div>
                    </div>

                    <div class="col-sm-6 ">
                      <div class="col-sm-11 ">
                        <div className="row">
                          <div className="col-sm-12">
                            <h3 style={headingstyle}>Procuring Entity</h3>
                          </div>
                        </div>
                        <div className="row border border-success rounded">
                          <table className="table table-borderless table-sm">
                            {this.state.PEDetails.map((r, i) => (
                              <div>
                                <tr>
                                  <td className="font-weight-bold">Name:</td>
                                  <td>{r.Name}</td>
                                </tr>
                                <tr>
                                  <td className="font-weight-bold">Address:</td>
                                  <td>
                                    {r.POBox +
                                      "-" +
                                      r.PostalCode +
                                      " " +
                                      r.Town}
                                  </td>
                                </tr>
                                <tr>
                                  <td className="font-weight-bold">Email:</td>
                                  <td>{r.Email}</td>
                                </tr>
                                <tr>
                                  <td className="font-weight-bold">
                                    Telephone
                                  </td>
                                  <td>{r.Telephone}</td>
                                </tr>
                              </div>
                            ))}
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </form>
              </div>
            </div>
            <br />
          </div>
        </div>
      );
    } else {
      return (
        <div>
          <ToastContainer />
          <div>
            <div className="row wrapper border-bottom white-bg page-heading">
              <div className="col-lg-10">
                <ol className="breadcrumb">
                  <li className="breadcrumb-item">
                    <h2>Judicial Review</h2>
                  </li>
                </ol>
              </div>
              <div className="col-lg-2">
                <div className="row wrapper ">
                  <Link to="/">
                    <button
                      type="button"
                      style={{ marginTop: 40 }}
                      onClick={this.openModal}
                      className="btn btn-warning  "
                    >
                      &nbsp; Close
                    </button>
                  </Link>
                </div>
              </div>
            </div>
          </div>

          <TableWrapper>
            <Table Rows={Rowdata1} columns={ColumnData} />
          </TableWrapper>
        </div>
      );
    }
  }
}

export default JudicialReview;
