import React, { Component } from "react";
import swal from "sweetalert";
import Table from "../../Table";
import TableWrapper from "../../TableWrapper";
import { Link } from "react-router-dom";

import { ToastContainer, toast } from "react-toastify";
import Modal from "react-awesome-modal";

var _ = require("lodash");
class DecisionsApproval extends Component {
  constructor() {
    super();
    this.state = {
      Documents: [],
      Applications: [],
      TenderName: "",
      ApplicantDetails: [],
      privilages: [],
      Vedios: [],
      Audios: [],
      ApplicationNo: "",
      PEDetails: [],
      summary: false,
      open: false,

      Description: "",
      openViewer: false,
      FileURL: ""
    };
  }
  openModal() {
    this.setState({ open: true });
  }

  closeModal() {
    this.setState({ open: false });
  }
  handleInputChange = event => {
    event.preventDefault();
    this.setState({ [event.target.name]: event.target.value });
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

  handleInputChange = event => {
    event.preventDefault();
    this.setState({ [event.target.name]: event.target.value });
  };
  fetchDocuments = ApplicationNo => {
    this.setState({ Documents: [] });
    fetch("/api/decisiondocuments/" + ApplicationNo, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(PEDetails => {
        if (PEDetails.length > 0) {
          this.setState({ Documents: PEDetails });
        } else {
          toast.error(PEDetails.message);
        }
      })
      .catch(err => {
        toast.error(err.message);
      });
  };
  fetchApplications = () => {
    this.setState({ casedetails: [] });
    fetch("/api/Decision/SubmitedDecisions/1/1", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(Applications => {
        if (Applications.length > 0) {
          this.setState({ Applications: Applications });
        } else {
          swal("", Applications.message, "error");
        }
      })
      .catch(err => {
        swal("", err.message, "error");
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
              this.fetchApplications();
              this.ProtectRoute();
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

  closeViewerModal = () => {
    this.setState({ openViewer: false });
  };
  HandlePrevieView = d => {
    let filepath = d.Path + "/" + d.Name;
    this.setState({ openViewer: true, FileURL: filepath });
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
        this.setState({ privilages: data });
      })
      .catch(err => {
        //this.setState({ loading: false, redirect: true });
      });
    //end
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
  HandleView = k => {
    const data = {
      ApplicationNo: k.ApplicationNo,
      summary: true,

      TenderName: k.TenderName
    };
    this.setState(data);
    this.fetchDocuments(k.ApplicationNo);
    this.fetchApplicantDetails(k.ApplicationNo);
    this.fetchPEDetails(k.ApplicationNo);
    this.fetchDocuments(k.ApplicationNo);
  };
  handelApproveDocument = d => {
    swal({
      text: "Are you sure that you want to approve this attachment?",
      icon: "warning",
      dangerMode: true,
      buttons: true
    }).then(willDelete => {
      if (willDelete) {
        return fetch("/api/decisiondocuments/" + d.Name, {
          method: "Post",
          headers: {
            "Content-Type": "application/json",
            "x-access-token": localStorage.getItem("token")
          }
        })
          .then(response =>
            response.json().then(data => {
              if (data.success) {
                toast.success("Approved");
                this.fetchDocuments(this.state.ApplicationNo);
                // var rows = [...this.state.Documents];
                // const filtereddata = rows.filter(item => item.Name !== d.Name);
                // this.setState({ Documents: filtereddata });
              } else {
                toast.error("Approve Failed");
              }
            })
          )
          .catch(err => {
            toast.error("Approve Failed");
          });
      }
    });
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
        label: "ApplicationNo",
        field: "ApplicationNo",
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
        label: "Tender Details",
        field: "TenderName",
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

    const rows = [...this.state.Applications];
    if (rows.length > 0) {
      rows.forEach(k => {
        const Rowdata = {
          ApplicationNo: k.ApplicationNo,
          ProcuringEntity: k.PEName,
          TenderName: k.TenderName,

          action: (
            <span>
              <a
                style={{ color: "#007bff" }}
                onClick={e => this.HandleView(k, e)}
              >
                View Documents
              </a>
            </span>
          )
        };
        Rowdata1.push(Rowdata);
      });
    }

    if (this.state.summary) {
      let childdiv = {
        margin: "30px"
      };

      return (
        <div>
          <Modal
            visible={this.state.openViewer}
            width="80%"
            height="600"
            effect="fadeInUp"
          >
            <div>
              <a
                style={{ float: "right", color: "red", margin: "10px" }}
                href="javascript:void(0);"
                onClick={() => this.closeViewerModal()}
              >
                Close
              </a>

              <object
                width="100%"
                height="570"
                data={this.state.FileURL}
                type="application/pdf"
              >
                {" "}
              </object>
            </div>
          </Modal>
          <ToastContainer />
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-10">
              <ol className="breadcrumb">
                <li className="breadcrumb-item">
                  <h2>
                    Application No:{" "}
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
              <div className="col-lg-10 border border-success rounded bg-white">
                <form style={FormStyle} onSubmit={this.SaveTenders}>
                  <div class="row">
                    <div class="col-sm-12">
                      <input
                        type="text"
                        disabled
                        value={this.state.TenderName}
                        className="form-control"
                      />
                    </div>
                  </div>
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
            <div className="row">
              <div className="col-lg-1"></div>
              <div className="col-lg-10 border border-success rounded">
                <div class="row">
                  <table class="table table-sm">
                    <thead className="thead-light">
                      <tr>
                        <th scope="col">NO</th>
                        <th scope="col">Document Description</th>
                        <th scope="col">Document Status</th>
                        <th scope="col">Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      {this.state.Documents.map((r, i) => (
                        <tr>
                          <td>{i + 1}</td>
                          <td>{r.Description}</td>
                          <td>{r.Status}</td>
                          <td>
                            {" "}
                            <span>
                              <a
                                style={{ color: "#007bff" }}
                                onClick={e => this.HandlePrevieView(r, e)}
                              >
                                View
                              </a>
                              |
                              <a
                                style={{ color: "Green" }}
                                onClick={e => this.handelApproveDocument(r, e)}
                              >
                                &nbsp; Approve
                              </a>
                            </span>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      );
    } else {
      return (
        <div>
          <div>
            <div className="row wrapper border-bottom white-bg page-heading">
              <div className="col-lg-10">
                <ol className="breadcrumb">
                  <li className="breadcrumb-item">
                    <h2>Decisions Approval</h2>
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

export default DecisionsApproval;
