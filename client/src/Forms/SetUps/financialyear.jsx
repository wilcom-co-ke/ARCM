import React, { Component } from "react";
import swal from "sweetalert";
import Table from "./../../Table";
import TableWrapper from "./../../TableWrapper";
import Modal from "react-awesome-modal";
import ReactExport from "react-data-export";
var dateFormat = require('dateformat');
var jsPDF = require("jspdf");
require("jspdf-autotable");
class financialyear extends Component {
    constructor() {
        super();
        this.state = {
            financialyear: [],       
            privilages: [],   
            Code: "",
            StartDate: "",
            EndDate:"",
            IsCurrentYear: false,
            open: false,
            loading: true,
            redirect: false,
            isUpdate: false
        };
        this.openModal = this.openModal.bind(this);
        this.closeModal = this.closeModal.bind(this);
        this.Resetsate = this.Resetsate.bind(this);
        //this.handleChange = this.handleChange.bind(this);
        this.computeenddate = this.computeenddate.bind(this)
        this.handleInputChange = this.handleInputChange.bind(this)
    }
    exportpdf = () => {
        var columns = [
           
            { title: "Code", dataKey: "Code" },
            { title: "StartDate", dataKey: "StartDate" },
        { title: "EndDate", dataKey: "EndDate" },
        { title: "IsCurrentYear", dataKey: "IsCurrentYear" }
        ];
        let Rowdata1 = [];
        const rows = [...this.state.financialyear];
        if (rows.length > 0) {
            rows.forEach(k => {
                const Rowdata = {
                   
                    Code: k.Code,
                    StartDate: new Date(k.StartDate).toLocaleDateString(),
                    EndDate: new Date(k.EndDate).toLocaleDateString(),
                    IsCurrentYear: k.IsCurrentYear
                };
                Rowdata1.push(Rowdata);
            });
        }

        

        var doc = new jsPDF("p", "pt");
        doc.autoTable(columns, Rowdata1, {
            margin: { top: 60 },
            beforePageContent: function (data) {
                doc.text("ARCM FINANCIAL YEARS", 40, 50);
            }
        });
        doc.save("ARCM FINANCIAL YEARS.pdf");
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
computeenddate(date){
    var dt = new Date(date);
    dt.setMonth(dt.getMonth() + 11);  
    var newday = new Date(dt.getFullYear(), dt.getMonth() + 1, 0).getDate();
    dt.setDate(newday);   
    var newenddate= dateFormat(new Date(dt).toLocaleDateString(), "isoDate")
   this.setState({ EndDate: newenddate });        
}
   
    openModal() {
        this.setState({ open: true });
        this.Resetsate();
    }
    closeModal() {
        this.setState({ open: false });
    }
    handleInputChange = event => {
       // event.preventDefault();
        // this.setState({ [event.target.name]: event.target.value });
        const target = event.target;
        const value = target.type === "checkbox" ? target.checked : target.value;
        const name = target.name;
       
        this.setState({ [name]: value });
        if (name =="StartDate"){           
            this.computeenddate(value);
        }
        
    };
    Resetsate() {
        const data = {
            Code: "",
            StartDate: "",
            EndDate: "",
            IsCurrentYear: false,
            isUpdate: false
        };
        this.setState(data);
    }

    fetchfinancialyear = () => {
        fetch("/api/financialyear", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(financialyear => {
                if (financialyear.length > 0) {
                   
                    this.setState({ financialyear: financialyear });
                } else {
                    swal("", financialyear.message, "error");
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
                            this.fetchfinancialyear();
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
        const data = {
            Code: this.state.Code,
            StartDate: this.state.StartDate,
            EndDate: this.state.EndDate,
            IsCurrentYear: this.state.IsCurrentYear
        };

        if (this.state.isUpdate) {
            this.UpdateData("/api/financialyear/" + this.state.Code, data);
        } else {
            this.postData("/api/financialyear", data);
        }
    };
    handleEdit = role => {
       
        const data = {
            Code: role.Code,
            StartDate: dateFormat(new Date(role.StartDate).toLocaleDateString(), "isoDate"),
            EndDate: dateFormat(new Date(role.EndDate).toLocaleDateString(), "isoDate") ,
            IsCurrentYear: !!+role.IsCurrentYear
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
                return fetch("/api/financialyear/" + k, {
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
                            this.fetchfinancialyear();
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
                    this.fetchfinancialyear();

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
                    this.fetchfinancialyear();

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
                label: "Code",
                field: "Code",
                sort: "asc",
                width: 200
            },
            {
                label: "StartDate",
                field: "StartDate",
                sort: "asc",
                width: 200
            },
            {
                label: "EndDate",
                field: "EndDate",
                sort: "asc",
                width: 200
            },
                {
                label: "IsCurrentYear",
                field: "IsCurrentYear",
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

        const rows = [...this.state.financialyear];

        if (rows.length > 0) {
            rows.forEach(k => {
              
                const Rowdata = {
                    Code: k.Code,                    
                    StartDate: new Date(k.StartDate).toLocaleDateString(),
                    EndDate: new Date(k.EndDate).toLocaleDateString(),
                    IsCurrentYear: k.IsCurrentYear,

                    action: (
                        <span>
                            {this.validaterole("Financial Year", "Edit") ? (
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
              {this.validaterole("Financial Year", "Remove") ? (
                                <a
                                    className="fa fa-trash"
                                    style={{ color: "#f44542" }}
                                    onClick={e => this.handleDelete(k.RoleID, e)}
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
                                    <h2>Financial Year</h2>
                                </li>
                            </ol>
                        </div>
                        <div className="col-lg-3">
                            <div className="row wrapper ">
                                {this.validaterole("Financial Year", "AddNew") ? (
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
                {this.validaterole("Financial Year", "Export") ? (
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
  {this.validaterole("Financial Year", "Export") ? (
                                    <ExcelFile
                                        element={
                                            <button
                                                type="button"
                                                style={{ marginTop: 40 }}
                                                className="btn btn-primary float-left fa fa-file-excel-o fa-2x"
                                            >
                                                &nbsp; Export
                    </button>
                                        }
                                    >
                                        <ExcelSheet data={Rowdata1} name="financialyear">
                                            <ExcelColumn label="Code" value="Code" />
                                            <ExcelColumn label="StartDate" value="StartDate" />
                                            <ExcelColumn label="EndDate" value="EndDate" />
                                            <ExcelColumn label="IsCurrentYear" value="IsCurrentYear" />
                                        </ExcelSheet>
                                    </ExcelFile>
                                ) : null}
                          
                                &nbsp; &nbsp;
               
                                &nbsp; &nbsp;
                                     <Modal
                                    visible={this.state.open}
                                    width="750"
                                    height="300"
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
                                            Financial Year
                    </h4>
                                        <div className="container-fluid">
                                            <div className="col-sm-12">
                                                <div className="ibox-content">
                                                    <form onSubmit={this.handleSubmit}>
                                                        <div className=" row">
                                                            <div className="col-sm">
                                                                <div className="form-group">
                                                                    <label htmlFor="exampleInputEmail1" className="font-weight-bold">
                                                                        Code{" "}
                                                                    </label>
                                                                    <input
                                                                        type="number"
                                                                        name="Code"
                                                                        required
                                                                        onChange={this.handleInputChange}
                                                                        value={this.state.Code}
                                                                        className="form-control"
                                                                        id="exampleInputPassword1"
                                                                        placeholder="Code"
                                                                    />
                                                                </div>
                                                            </div>
                                                            <div className="col-sm">
                                                                <label></label>
                                                                <div className="form-group">
                                                                    <br />
                                                                    <input
                                                                        className="checkbox"
                                                                        id="IsCurrentYear"
                                                                        type="checkbox"
                                                                        name="IsCurrentYear"
                                                                        defaultChecked={this.state.IsCurrentYear}
                                                                        onChange={this.handleInputChange}
                                                                    />
                                                                    &nbsp; <label htmlFor="CurrentYear" className="font-weight-bold">CurrentYear</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div className=" row">
                                                            <div className="col-sm">

                                                                <div className="form-group">
                                                                    <label htmlFor="Datereceived" className="font-weight-bold">Start Date</label>
                                                                    <input
                                                                        type="date"
                                                                        name="StartDate"
                                                                        required
                                                                        defaultValue={this.state.StartDate}
                                                                        className="form-control"
                                                                        onChange={this.handleInputChange}
                                                                        id="StartDate"
                                                                        aria-describedby="StartDate"
                                                                        placeholder="Select StartDate"
                                                                    />
                                                                </div>
                                                            </div>
                                                            <div className="col-sm">
                                                                <div className="form-group">
                                                                    <label htmlFor="EndDate" className="font-weight-bold">End Date</label>
                                                                    <input
                                                                        type="date"
                                                                        name="EndDate"
                                                                        required
                                                                        value={this.state.EndDate}
                                                                        className="form-control"
                                                                        onChange={this.handleInputChange}
                                                                        id="EndDate"
                                                                        disabled

                                                                    />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div className="col-sm-12 ">
                                                            <div className=" row">
                                                                <div className="col-sm-2">

                                                                </div>
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

export default financialyear;
