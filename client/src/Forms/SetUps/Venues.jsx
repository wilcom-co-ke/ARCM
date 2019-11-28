import React, { Component } from "react";
import swal from "sweetalert";
import Table from "../../Table";
import TableWrapper from "../../TableWrapper";
import Modal from "react-awesome-modal";
import ReactExport from "react-data-export";
import Select from "react-select";
var jsPDF = require("jspdf");
require("jspdf-autotable");

class Venues extends Component {
    constructor() {
        super();
        this.state = {
            Venues: [],
            privilages: [],
            Name: "",
            Description: "",
            ID: "",
            open: false,
            isUpdate: false,
            RolesPoup: false,
            Roles: [],
            Branches:[],
            Branch:"",
            BranchName:""
               
         
        };
        this.handleSelectChange = this.handleSelectChange.bind(this);
        this.openModal = this.openModal.bind(this);
        this.closeModal = this.closeModal.bind(this);
        this.Resetsate = this.Resetsate.bind(this);
        this.handleEdit = this.handleEdit.bind(this);
        this.handleDelete = this.handleDelete.bind(this)
        this.fetchVenues = this.fetchVenues.bind(this)
    }
    exportpdf = () => {
        var columns = [
            { title: "Name", dataKey: "Name" },
            { title: "Description", dataKey: "Description" }
        ];

        const data = [...this.state.Venues];

        var doc = new jsPDF("p", "pt");
        doc.autoTable(columns, data, {
            margin: { top: 60 },
            beforePageContent: function (data) {
                doc.text("ARCM Venues", 40, 50);
            }
        });
        doc.save("Venues.pdf");
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
    handleSelectChange = (UserGroup, actionMeta) => {
        
        this.setState({ [actionMeta.name]: UserGroup.value });
        this.setState({ BranchName: UserGroup.label });
       
    };
    openModal() {
        this.setState({ open: true });
        this.Resetsate();
    }
    fetchBranches = () => {
        fetch("/api/Branches", {
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
            Description: "",
            UserGroupID: "",
            isUpdate: false,
            Branch: "",
            BranchName: ""
        };
        this.setState(data);
    }

    fetchVenues = () => {
        this.setState({ Venues: [] });
        fetch("/api/Venues", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(Venues => {
                if (Venues.length > 0) {
                    this.setState({ Venues: Venues });
                } else {
                    swal("", Venues.message, "error");
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
                            this.fetchVenues();
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
        let newdesc =
            this.state.Description.charAt(0).toUpperCase() +
            this.state.Description.slice(1);
        let newname =
            this.state.Name.charAt(0).toUpperCase() + this.state.Name.slice(1);
        const data = {
            Name: newname,
            Description: newdesc,
            Branch: this.state.Branch
        };

        if (this.state.isUpdate) {
            this.UpdateData("/api/Venues/" + this.state.ID, data);
        } else {
            this.postData("/api/Venues", data);
        }
    };
    handleEdit = Name => {
        const data = {
            BranchName: Name.Branch,
            Name: Name.Name,
            Description: Name.Description,
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
            buttons: true,
        }).then(willDelete => {
            if (willDelete) {
                return fetch("/api/Venues/" + k, {
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
                            this.fetchVenues();
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
                    this.fetchVenues();

                    if (data.success) {
                        swal("", "Record has been updated!", "success");
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
                    this.fetchVenues();

                    if (data.success) {
                        swal("", "Record has been saved!", "success");
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
    render() {
        const ExcelFile = ReactExport.ExcelFile;
        const ExcelSheet = ReactExport.ExcelFile.ExcelSheet;
        const ExcelColumn = ReactExport.ExcelFile.ExcelColumn;
        const ColumnData = [
            {
                label: "Name",
                field: "Name",
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
                label: "Branch",
                field: "Branch",
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

        const rows = [...this.state.Venues];
        if (rows.length > 0) {
            rows.forEach(k => {
                const Rowdata = {
                    Name: k.Name,
                    Description: k.Description,
                    Branch: k.Branch,
                    action: (
                        <span>
                            {this.validaterole("Venues", "Edit") ? (
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
                        {this.validaterole("Venues", "Remove") ? (
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

        const BranchesOptions = [...this.state.Branches].map((k, i) => {
           
            return {
                value: k.ID,
                label: k.Description
            };
        });

        return (
            <div>
                <div>
                    <div className="row wrapper border-bottom white-bg page-heading">
                        <div className="col-lg-9">
                            <ol className="breadcrumb">
                                <li className="breadcrumb-item">
                                    <h2>Venues</h2>
                                </li>
                            </ol>
                        </div>
                        <div className="col-lg-3">
                            <div className="row wrapper ">
                                {this.validaterole("Venues", "AddNew") ? (
                                    <button
                                        type="button"
                                        style={{ marginTop: 40 }}
                                        onClick={this.openModal}
                                        className="btn btn-primary float-left fa fa-plus"
                                    >
                                        &nbsp; New
                  </button>
                                ) : null}
                                &nbsp;
                    {this.validaterole("Venues", "Export") ? (
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
                {this.validaterole("Venues", "Export") ? (
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
                                        <ExcelSheet data={rows} name="Venues">
                                          
                                            <ExcelColumn label="Name" value="Name" />
                                            <ExcelColumn label="Description" value="Description" />
                                        </ExcelSheet>
                                    </ExcelFile>
                                ) : null}
                                &nbsp; &nbsp; &nbsp; &nbsp;
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
                                            Venues
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
                                                                        Branch
                                                                         </label>
                                                                    <Select
                                                                        name="Branch"
                                                                        value={BranchesOptions.filter(
                                                                            option =>
                                                                                option.label === this.state.BranchName
                                                                        )}
                                                                        onChange={this.handleSelectChange}
                                                                        options={BranchesOptions}
                                                                        required
                                                                    />
                                                                </div>
                                                            </div>
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
                                                        </div>
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

export default Venues;
