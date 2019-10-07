import React, { Component } from "react";
import swal from "sweetalert";
import Table from "./../../Table";
import TableWrapper from "./../../TableWrapper";
import Modal from "react-awesome-modal";
import ReactExport from "react-data-export";
var jsPDF = require("jspdf");
require("jspdf-autotable");
class feesstructure extends Component {
    constructor() {
        super();
        this.state = {
            feesstructure: [],
            privilages: [],
            Code: "",
            Description: "",
            MinAmount: "",
            MaxAmount:"",
            Rate1:"",
            Rate2:"",
            MinFee:"",
            MaxFee:"",
            FixedFee: false,
            open: false,
            loading: true,
            redirect: false,
            isUpdate: false
        };

        this.openModal = this.openModal.bind(this);
        this.closeModal = this.closeModal.bind(this);
        this.Resetsate = this.Resetsate.bind(this);
        this.handleChange = this.handleChange.bind(this);
    }
    exportpdf = () => {
        var columns = [
         
            { title: "Code", dataKey: "Code" },
            { title: "Description", dataKey: "Description" },
        { title: "MinAmount", dataKey: "MinAmount" },
        { title: "MaxAmount", dataKey: "MaxAmount" },
        { title: "Rate1", dataKey: "Rate1" },
        { title: "Rate2", dataKey: "Rate2" },
        { title: "MinFee", dataKey: "MinFee" },
        { title: "MaxFee", dataKey: "MaxFee" },
        { title: "FixedFee", dataKey: "FixedFee" }
        ];

        const rows = [...this.state.feesstructure];

        var doc = new jsPDF("p", "pt");
        doc.autoTable(columns, rows, {
            margin: { top: 60 },
            beforePageContent: function (data) {
                doc.text("ARCM CHARGES", 40, 50);
            }
        });
        doc.save("ARCM CHARGES.pdf");
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
    handleChange(date) {
        this.setState({
            startDate: date
        });
    }
    openModal() {
        this.setState({ open: true });
        this.Resetsate();
    }
    closeModal() {
        this.setState({ open: false });
    }
    handleInputChange = event => {
        event.preventDefault();
        // this.setState({ [event.target.name]: event.target.value });
        const target = event.target;
        const value = target.type === "checkbox" ? target.checked : target.value;
        const name = target.name;
        this.setState({ [name]: value });
    };
    Resetsate() {
        const data = {
            Code: "",
            Description: "",
            MinAmount: "",
            MaxAmount: "",
            Rate1: "",
            Rate2: "",
            MinFee: "",
            MaxFee:"",
            FixedFee: false,
            isUpdate: false
        };
        this.setState(data);
    }

    fetchfeesstructure = () => {
        fetch("/api/feesstructure", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(feesstructure => {
                if (feesstructure.length > 0) {

                    this.setState({ feesstructure: feesstructure });
                } else {
                    swal("", feesstructure.message, "error");
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
                            this.fetchfeesstructure();
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
            Description: newdesc,
            MinAmount: this.state.MinAmount,
            MaxAmount: this.state.MaxAmount,
            Rate1: this.state.Rate1,
            Rate2: this.state.Rate2,
            MinFee: this.state.MinFee,
            MaxFee: this.state.MaxFee,
            FixedFee: this.state.FixedFee
        };

        if (this.state.isUpdate) {
            this.UpdateData("/api/feesstructure/" + this.state.Code, data);
        } else {
            this.postData("/api/feesstructure", data);
        }
    };
    handleEdit = role => {

        const data = {
            Code: role.Code,
            Description: role.Description,
            MinAmount: role.MinAmount,
            MaxAmount: role.MaxAmount,
            Rate1: role.Rate1,
            Rate2: role.Rate2,
            MinFee: role.MinFee,
            MaxFee: role.MaxFee,
            FixedFee: role.FixedFee
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
                return fetch("/api/feesstructure/" + k, {
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
                            this.fetchfeesstructure();
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
                    this.fetchfeesstructure();

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
                    this.fetchfeesstructure();

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
                label: "Description",
                field: "Description",
                sort: "asc",
                width: 200
            },
            {
                label: "MinAmount",
                field: "MinAmount",
                sort: "asc",
                width: 200
            },
            {
                label: "MaxAmount",
                field: "MaxAmount",
                sort: "asc",
                width: 200
            }, {
                label: "Rate1",
                field: "Rate1",
                sort: "asc",
                width: 200
            }, {
                label: "Rate2",
                field: "Rate2",
                sort: "asc",
                width: 200
            }, {
                label: "MinFee",
                field: "MinFee",
                sort: "asc",
                width: 200
            }, {
                label: "MaxFee",
                field: "MaxFee",
                sort: "asc",
                width: 200
            }, {
                label: "FixedFee",
                field: "FixedFee",
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

        const rows = [...this.state.feesstructure];

        if (rows.length > 0) {
            rows.forEach(k => {
                // var dt = new Date(k.StartDate);
                // //var dt = new Date();
                // console.log(dt.toLocaleDateString())
                const Rowdata = {
                    Code: k.Code,
                    Description: k.Description,
                    MinAmount: k.MinAmount,
                    MaxAmount: k.MaxAmount,
                    Rate1: k.Rate1,                  
                    Rate2: k.Rate2,
                    MinFee: k.MinFee,
                    MaxFee: k.MaxFee,
                    FixedFee: k.FixedFee,

                    action: (
                        <span>
                            {this.validaterole("Fees structure", "Edit") ? (
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
              {this.validaterole("Fees structure", "Remove") ? (
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
                                    <h2>Charges</h2>
                                </li>
                            </ol>
                        </div>
                        <div className="col-lg-3">
                            <div className="row wrapper ">
                                {this.validaterole("Fees structure", "AddNew") ? (
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
                {this.validaterole("Fees structure", "Export") ? (
                                    <button
                                        onClick={this.exportpdf}
                                        type="button"
                                        style={{ marginTop: 40 }}
                                        className="btn btn-primary float-left fa fa-file-pdf-o fa-2x"
                                    >
                                        &nbsp;PDF
                  </button>
                                ) : null}
                &nbsp; &nbsp;
  {this.validaterole("Fees structure", "Export") ? (
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
                                          

                                        <ExcelSheet data={rows} name="feesstructure">
                                            <ExcelColumn label="Code" value="Code" />
                                            <ExcelColumn label="Description" value="Description" />
                                            <ExcelColumn label="MinAmount" value="MinAmount" />
                                            <ExcelColumn label="MaxAmount" value="MaxAmount" />
                                            <ExcelColumn label="Rate1" value="Rate1" />
                                            <ExcelColumn label="Rate2" value="Rate2" />
                                            <ExcelColumn label="MinFee" value="MinFee" />
                                            <ExcelColumn label="MaxFee" value="MaxFee" />
                                            <ExcelColumn label="FixedFee" value="FixedFee" />
                                        </ExcelSheet>
                                    </ExcelFile>
                                ) : null}
                            
                                &nbsp; &nbsp;
            
                                &nbsp; &nbsp;
                                  <Modal
                                    visible={this.state.open}
                                    width="900"
                                    height="450"
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
                                            Charges
                    </h4>
                                        <div className="container-fluid">
                                            <div className="col-sm-12">
                                                <div className="ibox-content">
                                                    <form onSubmit={this.handleSubmit}>
                                                        <div className=" row">
                                                            <div className="col-sm">

                                                                <div className="form-group">
                                                                    <label htmlFor="Datereceived" className="font-weight-bold">Description</label>
                                                                    <input
                                                                        type="text"
                                                                        name="Description"
                                                                        required
                                                                        onChange={this.handleInputChange}
                                                                        value={this.state.Description}
                                                                        className="form-control"
                                                                        id="exampleInputPassword1"

                                                                    />
                                                                </div>
                                                            </div>
                                                            <div className="col-sm">
                                                                <label></label>
                                                                <div className="form-group">
                                                                    <br />
                                                                    <input
                                                                        className="checkbox"
                                                                        id="FixedFee"
                                                                        type="checkbox"
                                                                        name="FixedFee"
                                                                        defaultChecked={this.state.FixedFee}

                                                                    // onChange={handleCheckBoxChange(e)}
                                                                    />
                                                                    <label htmlFor="FixedFee" className="font-weight-bold">&nbsp;FixedFee</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div className=" row">
                                                            <div className="col-sm">

                                                                <div className="form-group">
                                                                    <label htmlFor="EndDate" className="font-weight-bold">MinAmount</label>
                                                                    <input
                                                                        type="number"
                                                                        name="MinAmount"
                                                                        required
                                                                        onChange={this.handleInputChange}
                                                                        value={this.state.MinAmount}
                                                                        className="form-control"
                                                                        id="exampleInputPassword1"

                                                                    />
                                                                </div>
                                                            </div>
                                                            <div className="col-sm">
                                                                <div className="form-group">
                                                                    <label htmlFor="EndDate" className="font-weight-bold">MaxAmount</label>
                                                                    <input
                                                                        type="number"
                                                                        name="MaxAmount"
                                                                        required
                                                                        onChange={this.handleInputChange}
                                                                        value={this.state.MaxAmount}
                                                                        className="form-control"
                                                                        id="exampleInputPassword1"

                                                                    />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div className=" row">
                                                            <div className="col-sm">
                                                                <div className="form-group">
                                                                    <label htmlFor="Rate1" className="font-weight-bold">Rate1 (%)</label>
                                                                    <input
                                                                        type="number"
                                                                        name="Rate1"
                                                                        required
                                                                        onChange={this.handleInputChange}
                                                                        value={this.state.Rate1}
                                                                        className="form-control"


                                                                    />
                                                                </div>
                                                            </div>
                                                            <div className="col-sm">
                                                                <div className="form-group">
                                                                    <label htmlFor="Rate2" className="font-weight-bold">Rate2 (%)</label>
                                                                    <input
                                                                        type="number"
                                                                        name="Rate2"
                                                                        required
                                                                        onChange={this.handleInputChange}
                                                                        value={this.state.Rate2}
                                                                        className="form-control"


                                                                    />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div className=" row">
                                                            <div className="col-sm">
                                                                <div className="form-group">
                                                                    <label htmlFor="MinFee" className="font-weight-bold">MinFee</label>
                                                                    <input
                                                                        type="number"
                                                                        name="MinFee"
                                                                        required
                                                                        onChange={this.handleInputChange}
                                                                        value={this.state.MinFee}
                                                                        className="form-control"


                                                                    />
                                                                </div>
                                                            </div>
                                                            <div className="col-sm">
                                                                <div className="form-group">
                                                                    <label htmlFor="MaxFee" className="font-weight-bold">MaxFee</label>
                                                                    <input
                                                                        type="number"
                                                                        name="MaxFee"
                                                                        required
                                                                        onChange={this.handleInputChange}
                                                                        value={this.state.MaxFee}
                                                                        className="form-control"


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

export default feesstructure;
