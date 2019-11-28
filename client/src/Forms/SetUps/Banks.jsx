import React, { Component } from "react";
import swal from "sweetalert";
import Table from "../../Table";
import TableWrapper from "../../TableWrapper";
import Modal from "react-awesome-modal";

var jsPDF = require("jspdf");
require("jspdf-autotable");

class Banks extends Component {
  constructor() {
    super();
    this.state = {
      Venues: [],
      privilages: [],
      Name: "",
      Branch: "",
      Description: "",
      ID: "",
      open: false,
      isUpdate: false,
      RolesPoup: false,
      Roles: [],
      Branches: [],
      AcountNo: "",
      PayBill: ""
    };

    this.openModal = this.openModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.Resetsate = this.Resetsate.bind(this);
    this.handleEdit = this.handleEdit.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  }

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
  fetchBranches = () => {
    fetch("/api/Banks", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(Branches => {
        if (Branches.length > 0) {
          this.setState({ Branches: Branches });
        } else {
          swal("", Branches.message, "error");
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };

  closeModal() {
    this.setState({ open: false });
  }
  handleInputChange = event => {
    event.preventDefault();
    this.setState({ [event.target.name]: event.target.value });
  };
  Resetsate() {
    const data = {
      Name: "",
      PayBill: "",
      isUpdate: false,
      Branch: "",
      AcountNo: ""
    };
    this.setState(data);
  }

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
              this.fetchBranches();
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

    const data = {
      Name: this.state.Name,
      PayBill: this.state.PayBill,
      AcountNo: this.state.AcountNo,
      Branch: this.state.Branch
    };

    if (this.state.isUpdate) {
      this.UpdateData("/api/Banks/" + this.state.ID, data);
    } else {
      this.postData("/api/Banks", data);
    }
  };
  handleEdit = Name => {
    const data = {
      AcountNo: Name.AcountNo,
      Name: Name.Name,
      PayBill: Name.PayBill,
      Branch: Name.Branch,
      ID: Name.ID
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
        return fetch("/api/Banks/" + k, {
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
                this.fetchBranches();
              } else {
                swal("", data.message, "error");
              }
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
          if (data.success) {
            swal("", "Record has been updated!", "success");
            this.setState({ open: false });
            this.Resetsate();
            this.fetchBranches();
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
          if (data.success) {
            swal("", "Record has been saved!", "success");
            this.setState({ open: false });
            this.Resetsate();
            this.fetchBranches();
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
    const ColumnData = [
      {
        label: "Name",
        field: "Name",
        sort: "asc",
        width: 200
      },
      {
        label: "Branch",
        field: "Branch",
        sort: "asc",
        width: 200
      },
      {
        label: "AcountNo",
        field: "AcountNo",
        sort: "asc",
        width: 200
      },
      {
        label: "PayBill",
        field: "PayBill",
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
    //console.log(this.state.Branches);
    const rows = [...this.state.Branches];
    if (rows.length > 0) {
      rows.forEach(k => {
        const Rowdata = {
          Name: k.Name,
          Branch: k.Branch,
          AcountNo: k.AcountNo,
          PayBill: k.PayBill,
          action: (
            <span>
              {this.validaterole("Banks", "Edit") ? (
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
              {this.validaterole("Banks", "Remove") ? (
                <a
                  className="fa fa-trash"
                  style={{ color: "#f44542" }}
                  onClick={e => this.handleDelete(k.ID, e)}
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
                  <h2>Banks</h2>
                </li>
              </ol>
            </div>
            <div className="col-lg-3">
              <div className="row wrapper ">
                {this.validaterole("Banks", "AddNew") ? (
                  <button
                    type="button"
                    style={{ marginTop: 40 }}
                    onClick={this.openModal}
                    className="btn btn-primary float-left fa fa-plus"
                  >
                    &nbsp; New
                  </button>
                ) : null}
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <Modal
                  visible={this.state.open}
                  width="700"
                  height="330"
                  effect="fadeInUp"
                  
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
                      Banks
                    </h4>
                    <div className="container-fluid">
                      <div className="col-sm-12">
                        <div className="ibox-content">
                          <form onSubmit={this.handleSubmit}>
                            <div className=" row">
                              <div className="col-sm">
                                <div className="form-group">
                                  <label
                                    htmlFor="exampleInputEmail1"
                                    className="font-weight-bold"
                                  >
                                    Name
                                  </label>
                                  <input
                                    type="text"
                                    name="Name"
                                    required
                                    onChange={this.handleInputChange}
                                    value={this.state.Name}
                                    className="form-control"
                                  />
                                </div>
                              </div>
                              <div className="col-sm">
                                <div className="form-group">
                                  <label
                                    htmlFor="exampleInputEmail1"
                                    className="font-weight-bold"
                                  >
                                    Branch
                                  </label>
                                  <input
                                    type="text"
                                    name="Branch"
                                    required
                                    onChange={this.handleInputChange}
                                    value={this.state.Branch}
                                    className="form-control"
                                  />
                                </div>
                              </div>
                            </div>
                            <div className=" row">
                              <div className="col-sm">
                                <div className="form-group">
                                  <label
                                    htmlFor="exampleInputEmail1"
                                    className="font-weight-bold"
                                  >
                                    AcountNo
                                  </label>
                                  <input
                                    type="text"
                                    name="AcountNo"
                                    required
                                    onChange={this.handleInputChange}
                                    value={this.state.AcountNo}
                                    className="form-control"
                                  />
                                </div>
                              </div>
                              <div className="col-sm">
                                <div className="form-group">
                                  <label
                                    htmlFor="exampleInputEmail1"
                                    className="font-weight-bold"
                                  >
                                    PayBill
                                  </label>
                                  <input
                                    type="text"
                                    name="PayBill"
                                    required
                                    onChange={this.handleInputChange}
                                    value={this.state.PayBill}
                                    className="form-control"
                                  />
                                </div>
                              </div>
                            </div>
                            <div className="col-sm-12 ">
                              <div className=" row">
                                <div className="col-sm-11" />

                                <div className="col-sm-1">
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

export default Banks;
