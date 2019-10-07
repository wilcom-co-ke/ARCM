import React, { Component } from "react";
import swal from "sweetalert";
import Table from "./../../Table";
import TableWrapper from "./../../TableWrapper";
import Modal from "react-awesome-modal";
import ReactExport from "react-data-export";
var jsPDF = require("jspdf");
require("jspdf-autotable");
class committeetypes extends Component {
  constructor() {
    super();
    this.state = {
      committeetypes: [],
      Code: "",
      Description: "",
      privilages: [],
      open: false,
      loading: true,

      redirect: false,
      isUpdate: false
    };

    this.openModal = this.openModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.Resetsate = this.Resetsate.bind(this);
  }
  exportpdf = () => {
    var columns = [
      { title: "Code", dataKey: "Code" },
      { title: "Description", dataKey: "Description" }
    ];

    const rows = [...this.state.committeetypes];

    var doc = new jsPDF("p", "pt");
    doc.autoTable(columns, rows, {
      margin: { top: 60 },
      beforePageContent: function(data) {
        doc.text("ARCM COMMITTEE TYPES", 40, 50);
      }
    });
    doc.save("ARCM COMMITTEE TYPES.pdf");
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

  openModal() {
    this.setState({ open: true });
    this.Resetsate();
  }
  closeModal() {
    this.setState({ open: false });
  }
  handleInputChange = event => {
    event.preventDefault();
    this.setState({ [event.target.name]: event.target.value });
  };
  Resetsate() {
    const data = {
      Code: "",
      Description: "",
      isUpdate: false
    };
    this.setState(data);
  }

  fetchcommitteetypes = () => {
    fetch("/api/committeetypes", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(committeetypes => {
        if (committeetypes.length > 0) {
          this.setState({ committeetypes: committeetypes });
        } else {
          swal("", committeetypes.message, "error");
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
              this.fetchcommitteetypes();
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
  handleSubmit = event => {
    event.preventDefault();
    let newdesc =
      this.state.Description.charAt(0).toUpperCase() +
      this.state.Description.slice(1);

    const data = {
      Description: newdesc
    };

    if (this.state.isUpdate) {
      this.UpdateData("/api/committeetypes/" + this.state.Code, data);
    } else {
      this.postData("/api/committeetypes", data);
    }
  };
  handleEdit = d => {
    const data = {
      Code: d.Code,
      Description: d.Description
    };

    this.setState(data);
    this.setState({ open: true });
    this.setState({ isUpdate: true });
  };

  handleDelete = k => {
    swal({
      text: "Are you sure that you want to delete this record?",
      icon: "warning",
      dangerMode: true,
      buttons: true
    }).then(willDelete => {
      if (willDelete) {
        return fetch("/api/committeetypes/" + k, {
          method: "Delete",
          headers: {
            "Content-Type": "application/json",
            "x-access-token": localStorage.getItem("token")
          }
        })
          .then(response =>
            response.json().then(data => {
              if (data.success) {
                swal("", "Record has been deleted!", "success");
                this.Resetsate();
              } else {
                swal("", data.message, "error");
              }
              this.fetchcommitteetypes();
            })
          )
          .catch(err => {
            swal("", err.message, "error");
          });
      }
    });
  };
  UpdateData(url = ``, data = {}) {
    fetch(url, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      },
      body: JSON.stringify(data)
    })
      .then(response =>
        response.json().then(data => {
          this.fetchcommitteetypes();

          if (data.success) {
            swal("", "Record has been Updated!", "success");
            this.setState({ open: false });
            this.Resetsate();
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  }
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
          this.fetchcommitteetypes();

          if (data.success) {
            swal("", "Record has been saved!", "success");
            this.Resetsate();
            this.setState({ open: false });
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
    const ExcelFile = ReactExport.ExcelFile;
    const ExcelSheet = ReactExport.ExcelFile.ExcelSheet;
    const ExcelColumn = ReactExport.ExcelFile.ExcelColumn;

    const ColumnData = [
      {
        label: "Code",
        field: "Code",
        sort: "asc",
        width: 200
      },
      {
        label: "Description",
        field: "Description",
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

    const rows = [...this.state.committeetypes];

    if (rows.length > 0) {
      rows.forEach(k => {
        const Rowdata = {
          Code: k.Code,
          Description: k.Description,

          action: (
            <span>
              {this.validaterole("Committee Types", "Edit") ? (
                <a
                  className="fa fa-edit"
                  style={{ color: "#007bff" }}
                  onClick={e => this.handleEdit(k, e)}
                >
                  Edit |
                </a>
              ) : (
                <i>-</i>
              )}
              &nbsp;
              {this.validaterole("Committee Types", "Remove") ? (
                <a
                  className="fa fa-trash"
                  style={{ color: "#f44542" }}
                  onClick={e => this.handleDelete(k.Code, e)}
                >
                  Delete
                </a>
              ) : (
                <i>-</i>
              )}
            </span>
          )
        };
        Rowdata1.push(Rowdata);
      });
    }

    return (
      <div>
        <div>
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-9">
              <ol className="breadcrumb">
                <li className="breadcrumb-item">
                  <h2>Committee Types</h2>
                </li>
              </ol>
            </div>
            <div className="col-lg-3">
              <div className="row wrapper ">
                {this.validaterole("Committee Types", "AddNew") ? (
                  <button
                    type="button"
                    style={{ marginTop: 40 }}
                    onClick={this.openModal}
                    className="btn btn-primary float-left fa fa-plus"
                  >
                    New
                  </button>
                ) : null}
                &nbsp;
                {this.validaterole("Committee Types", "Export") ? (
                  <button
                    onClick={this.exportpdf}
                    type="button"
                    style={{ marginTop: 40 }}
                    className="btn btn-primary float-left fa fa-file-pdf-o fa-2x"
                  >
                    &nbsp;PDF
                  </button>
                ) : null}
                &nbsp;
                {this.validaterole("Committee Types", "Export") ? (
                  <ExcelFile
                    element={
                      <button
                        type="button"
                        style={{ marginTop: 40 }}
                        className="btn btn-primary float-left fa fa-file-excel-o fa-2x"
                      >
                        &nbsp; Excel
                      </button>
                    }
                  >
                    <ExcelSheet data={rows} name="committeetypes">
                      <ExcelColumn label="ID" value="ID" />
                      <ExcelColumn label="Code" value="Code" />
                      <ExcelColumn label="Description" value="Description" />
                    </ExcelSheet>
                  </ExcelFile>
                ) : null}
                &nbsp; &nbsp; &nbsp;
                <Modal
                  visible={this.state.open}
                  width="600"
                  height="250"
                  effect="fadeInUp"
                  onClickAway={() => this.closeModal()}
                >
                  <a
                    style={{ float: "right", color: "red", margin: "10px" }}
                    href="javascript:void(0);"
                    onClick={() => this.closeModal()}
                  >
                    <i class="fa fa-close"></i>
                  </a>
                  <div>
                    <h4 style={{ "text-align": "center", color: "#1c84c6" }}>
                      {" "}
                      Committee Type
                    </h4>
                    <div className="container-fluid">
                      <div className="col-sm-12">
                        <div className="ibox-content">
                          <form onSubmit={this.handleSubmit}>
                            <div className=" row">
                              <div className="col-sm">
                                <div className="form-group">
                                  <label
                                    htmlFor="exampleInputPassword1"
                                    className="font-weight-bold"
                                  >
                                    Description
                                  </label>
                                  <textarea
                                    onChange={this.handleInputChange}
                                    value={this.state.Description}
                                    type="text"
                                    required
                                    name="Description"
                                    className="form-control"
                                    id="exampleInputPassword1"
                                    placeholder="Description"
                                  />
                                </div>
                              </div>
                            </div>
                            <div className="col-sm-12 ">
                              <div className=" row">
                                <div className="col-sm-2" />
                                <div className="col-sm-8" />
                                <div className="col-sm-2">
                                  <button
                                    type="submit"
                                    className="btn btn-primary float-left"
                                  >
                                    Save
                                  </button>
                                </div>
                              </div>
                            </div>
                          </form>
                        </div>
                      </div>
                    </div>
                  </div>
                </Modal>
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

export default committeetypes;
