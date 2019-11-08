import React, { Component } from "react";
import swal from "sweetalert";
import Table from "./../../Table";
import TableWrapper from "./../../TableWrapper";
import { Progress } from "reactstrap";
import Select from "react-select";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import ReactExport from "react-data-export";
var dateFormat = require('dateformat');
var jsPDF = require("jspdf");
require("jspdf-autotable");
class applicants extends Component {
    constructor() {
        super();
        this.state = {
            PE: [],
            Counties: [],
           
            privilages: [],
            Towns:[],
            profile: true,
            Code: "",
            Name: "",
            Location: "",
            County: "",
            POBox: "",
            PostalCode: "",
            Town: "",
            Email: "",
            Website: "",
            Mobile: "",
            Telephone: "",
            RegistrationNo:"",
            Companyregistrationdate:"",
            PIN:"",
            Logo: "",
            isUpdate: false,
            selectedFile: null
        };

        this.Resetsate = this.Resetsate.bind(this);
        this.handleSelectChange = this.handleSelectChange.bind(this);
        this.handleInputChange = this.handleInputChange.bind(this);
    }
   
    exportpdf = () => {

        var columns = [
       

            { title: "Code", dataKey: "PEID" },
            { title: "Name", dataKey: "Name" },
            { title: "Location", dataKey: "Location" },
            { title: "Website", dataKey: "Website" },
            { title: "Email", dataKey: "Email" },
            { title: "Telephone", dataKey: "Telephone" },
            { title: "CountyCode", dataKey: "CountyCode" },
            { title: "County", dataKey: "County" },
            { title: "PostalCode", dataKey: "PostalCode" },
            { title: "POBox", dataKey: "POBox" },
            { title: "ContactEmail", dataKey: "ContactEmail" },
            { title: "ContactMobile", dataKey: "ContactMobile" },
            { title: "ContactName", dataKey: "ContactName" },
            { title: "ContactTelephone", dataKey: "ContactTelephone" }
        ];

        const rows = [...this.state.PE];

        var doc = new jsPDF("p", "pt", "a2", "portrait");
        doc.autoTable(columns, rows, {
            margin: { top: 60 },
            beforePageContent: function (data) {
                doc.text("ARCM APPLICANTS", 40, 50);
            }
        });
        doc.save("ARCM Applicants.pdf");
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
    
    handleswitchMenu = e => {
        e.preventDefault();
        if (this.state.profile === false) {
            this.setState({ profile: true });
        } else {
            this.setState({ profile: false });
        }
        this.Resetsate()
        //this.setnewstate();
    };
    handleSelectChange = (County, actionMeta) => {
        
            this.setState({ CountyCode: County.value });
            this.setState({ [actionMeta.name]: County.label });
      
    };
    fetchCounties = () => {
        fetch("/api/counties", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(Counties => {
                if (Counties.length > 0) {
                    this.setState({ Counties: Counties });
                } else {
                    swal("", Counties.message, "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };

    fetchTown = (Code) => {
     
        fetch("/api/Towns/" + Code, {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(Towns => {
                if (Towns.length > 0) {
                   
                    this.setState({ Town: Towns[0].Town });
                } else {
                   // swal("Oops!", "Invalid Postal Code", "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };


    handleInputChange = event => {
        // event.preventDefault();
        // this.setState({ [event.target.name]: event.target.value });
        const target = event.target;
        const value = target.type === "checkbox" ? target.checked : target.value;
        const name = target.name;
        
        if (name ==="PostalCode"){
            this.fetchTown(value)
        }
        this.setState({ [name]: value });
    };
    Resetsate() {
        const data = {
            Code: "",
            Name: "",
            Location: "",
            County: "",
            POBox: "",
            PostalCode: "",
            Town: "",
            Email: "",
            Website: "",
            Mobile: "",
            Telephone: "",
            RegistrationNo: "",
            Companyregistrationdate: "",
            PIN: "",
            CountyCode: "",          
            Logo: "",
            isUpdate: false
        };
        this.setState(data);
    }
    maxSelectFile = event => {
        let files = event.target.files; // create file object
        if (files.length > 1) {
            const msg = "Only One image can be uploaded at a time";
            event.target.value = null; // discard selected file
            toast.warn(msg);
            return false;
        }
        return true;
    };
    checkMimeType = event => {
        let files = event.target.files;
        let err = []; // create empty array
        const types = ["image/png", "image/jpeg", "image/gif"];
        for (var x = 0; x < files.length; x++) {
            if (types.every(type => files[x].type !== type)) {
                err[x] = files[x].type + " is not a supported format\n";
                // assign message to array
            }
        }
        for (var z = 0; z < err.length; z++) {
            // loop create toast massage
            event.target.value = null;
            toast.error(err[z]);
        }
        return true;
    };
    checkFileSize = event => {
        let files = event.target.files;
        let size = 2000000;
        let err = [];
        for (var x = 0; x < files.length; x++) {
            if (files[x].size > size) {
                err[x] = files[x].type + "is too large, please pick a smaller file\n";
            }
        }
        for (var z = 0; z < err.length; z++) {
            toast.error(err[z]);
            event.target.value = null;
        }
        return true;
    };
    onClickHandler = () => {
        if (this.state.selectedFile) {
            const data = new FormData();
            // var headers = {
            //   "Content-Type": "multipart/form-data",
            //   "x-access-token": localStorage.getItem("token")
            // };

            //for single files
            //data.append("file", this.state.selectedFile);
            //for multiple files
            for (var x = 0; x < this.state.selectedFile.length; x++) {
                data.append("file", this.state.selectedFile[x]);
            }
            axios
                .post("/api/upload", data, {
                    // receive two parameter endpoint url ,form data
                    onUploadProgress: ProgressEvent => {
                        this.setState({
                            loaded: (ProgressEvent.loaded / ProgressEvent.total) * 100
                        });
                    }
                })
                .then(res => {
                    this.setState({
                        Logo: res.data
                    });
                    // localStorage.setItem("UserPhoto", res.data);
                    toast.success("upload success");
                })
                .catch(err => {
                    toast.error("upload fail");
                });
        } else {
            toast.warn("Please select a photo to upload");
        }
    };
    onChangeHandler = event => {
        //for multiple files
        var files = event.target.files;
        if (
            this.maxSelectFile(event) &&
            this.checkFileSize(event) &&
            this.checkMimeType(event)
        ) {
            this.setState({
                selectedFile: files,
                loaded: 0
            });

            //for single file
            // this.setState({
            //   selectedFile: event.target.files[0],
            //   loaded: 0
            // });
        }
    };
    fetchApplicants = () => {
        fetch("/api/applicants", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(PE => {
               
                if (PE.length > 0) {
                    this.setState({ PE: PE });
                } else {
                    swal("", PE.message, "error");
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
                            this.fetchApplicants();
                            this.fetchCounties();
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
            Name: this.state.Name,
         
            Location: this.state.Location,
            POBox: this.state.POBox,
            PostalCode: this.state.PostalCode,
            Town: this.state.Town,
            Mobile: this.state.Mobile,
            Telephone: this.state.Telephone,
            Email: this.state.Email,
            Logo: this.state.Logo,
            Website: this.state.Website,
            RegistrationNo: this.state.RegistrationNo,
            Companyregistrationdate: this.state.Companyregistrationdate,
            PIN: this.state.PIN,
            County: this.state.CountyCode,
            Username: localStorage.getItem("UserName")
        };
      
            this.UpdateData("/api/applicants/" + this.state.Code, data);
       
    };
    handleEdit = pe => {  
      
        const data = {
            Code: pe.PEID,
            Name: pe.Name,
            Location: pe.Location,
            County: pe.County,
            POBox: pe.POBox,
            PostalCode: pe.PostalCode,
            Town: pe.Town,
            Email: pe.Email,
            Website: pe.Website,
            Mobile: pe.Mobile,
            Telephone: pe.Telephone,
            CName: pe.ContactName,
            CMobile: pe.ContactMobile,
            CTelephone: pe.ContactTelephone,
            CEmail: pe.ContactEmail,
            CountyCode: pe.CountyCode,
            RegistrationNo: pe.RegistrationNo,
            Companyregistrationdate: dateFormat(new Date(pe.RegistrationDate).toLocaleDateString(), "isoDate"), 
            PIN: pe.PIN,
            Logo: pe.Logo
        };

        this.setState(data);
        if (this.state.profile === false) {
            this.setState({ profile: true });
        } else {
            this.setState({ profile: false });
        }
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
                return fetch("/api/applicants/" + k, {
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
                            this.fetchApplicants();
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
                    this.fetchApplicants();

                    if (data.success) {
                        swal("", "Record has been Updated!", "success");
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
        const Counties = [...this.state.Counties].map((k, i) => {
            return {
                value: k.Code,
                label: k.Name
            };
        });
    
        const ColumnData = [
            {
                label: "Code",
                field: "Code",
                sort: "asc"
            },
            {
                label: "Name",
                field: "Name",
                sort: "asc"
            },
            {
                label: "Location",
                field: "Location",
                sort: "asc"
            },
           
            {
                label: "Email",
                field: "Email",
                sort: "asc"
            },
            {
                label: "Telephone",
                field: "Telephone",
                sort: "asc"
            },
            {
                label: "County",
                field: "County",
                sort: "asc"
            },

            {
                label: "action",
                field: "action",
                sort: "asc",
                width: 200
            }
        ];
        let Rowdata1 = [];
        const rows = [...this.state.PE];
        
        if (rows.length > 0) {
            rows.map((k, i) => {
                let Rowdata = {
                    Code: k.PEID,
                    Name: k.Name,
                    Location: k.Location,
               
                    Email: k.Email,
                    Telephone: k.Telephone,
                    County: k.County,

                    action: (
                        <span>
                            <a
                                className="fa fa-edit"
                                style={{ color: "#007bff" }}
                                onClick={e => this.handleEdit(k, e)}
                                >
                                {" "}
                                Edit
                            </a>
                            |{" "}
                            <a
                                className="fa fa-trash"
                                style={{ color: "#f44542" }}
                                onClick={e => this.handleDelete(k.PEID, e)}
                            >
                                {" "}
                                Delete
                             </a>
                        </span>
                    )
                };
                Rowdata1.push(Rowdata);
            });
        }
        let Signstyle = {
            height: 100,
            width: 150
        };
        let divconatinerstyle = {
            width: "95%",
            margin: "0 auto",
            backgroundColor: "white"
        };
        let childdiv = {
            margin: "30px"
        };

        if (this.state.profile) {
            return (
                <div>
                    <div>
                        <div className="row wrapper border-bottom white-bg page-heading">
                            <div className="col-lg-9">
                                <ol className="breadcrumb">
                                    <li className="breadcrumb-item">
                                        <h2>Applicants</h2>
                                    </li>
                                </ol>
                            </div>
                            <div className="col-lg-3">
                                <div className="row wrapper ">
                                   
                                    &nbsp;
                                {this.validaterole("Applicants", "Export") ? (
                                        <button
                                            onClick={this.exportpdf}
                                            type="button"
                                            style={{ marginTop: 40 }}
                                            className="btn btn-primary float-left fa fa-file-pdf-o fa-2x"
                                        >
                                            &nbsp;PDF
                                    </button>
                                    ) : null}
                                
        
        
                                   
                                    &nbsp;  {this.validaterole("Applicants", "Export") ? (
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
                                            <ExcelSheet data={rows} name="Applicants">                                           
                                           <ExcelColumn label="ID" value="PEID" />
                                            <ExcelColumn label="Name" value="Name" />
                                            <ExcelColumn label="Location" value="Location" />
                                            <ExcelColumn label="Website" value="Website" />
                                            <ExcelColumn label="Email" value="Email" />
                                            <ExcelColumn label="Telephone" value="Telephone" />
                                            <ExcelColumn label="CountyCode" value="CountyCode" />                                            
                                            <ExcelColumn label="County" value="County" />
                                            <ExcelColumn label="PostalCode" value="PostalCode" />
                                            <ExcelColumn label="POBox" value="POBox" />
                                            <ExcelColumn label="ContactEmail" value="ContactEmail" />
                                            <ExcelColumn label="ContactMobile" value="ContactMobile" />
                                            <ExcelColumn label="ContactName" value="ContactName" />
                                            <ExcelColumn label="ContactTelephone" value="ContactTelephone" />

     
                                        </ExcelSheet>
                                    </ExcelFile>
                                    ) : null}
                                    
                                 </div>
                            </div>
                        </div>
                    </div>

                    <TableWrapper>
                        <Table Rows={Rowdata1} columns={ColumnData} />
                    </TableWrapper>
                </div>
            );
        } else {
            return (
                <div>
                    <div className="row wrapper border-bottom white-bg page-heading">
                        <div className="col-lg-10">
                            <ol className="breadcrumb">
                                <li className="breadcrumb-item">
                                    <h2>Applicants</h2>
                                </li>
                            </ol>
                        </div>
                        <div className="col-lg-2">
                            <div className="row wrapper ">
                                <button
                                    type="button"
                                    style={{ marginTop: 40 }}
                                    onClick={this.handleswitchMenu}
                                    className="btn btn-primary float-left fa fa-undo"
                                >
                                    &nbsp; Back
                            </button>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div style={divconatinerstyle}>
                        <ToastContainer />
                        <div class="row">
                            <div class="col-sm-12">
                                <nav>
                                    <div class="nav nav-tabs " id="nav-tab" role="tablist">
                                        <a
                                            class="nav-item nav-link active font-weight-bold"
                                            id="nav-home-tab"
                                            data-toggle="tab"
                                            href="#nav-home"
                                            role="tab"
                                            aria-controls="nav-home"
                                            aria-selected="true"
                                        >
                                            Applicant Details
                                        </a>
                               
                                    </div>
                                </nav>
                                <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                                    <div
                                        class="tab-pane fade show active"
                                        id="nav-home"
                                        role="tabpanel"
                                        aria-labelledby="nav-home-tab"
                                        style={childdiv}
                                    >
                                        <form onSubmit={this.handleSubmit}>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Name" className="font-weight-bold">
                                                        Name
                                                        </label>
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="Name"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.Name}
                                                        required
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="Location" className="font-weight-bold">
                                                        County
                          </label>

                                                    <Select
                                                        name="County"
                                                        value={Counties.filter(
                                                            option => option.label === this.state.County
                                                        )}
                                                        onChange={this.handleSelectChange}
                                                        options={Counties}
                                                        required
                                                    />
                                                </div>
                                            
                                            </div> 
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Email" className="font-weight-bold">
                                                        Email  </label>

                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="Email"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.Email}
                                                        required
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="Location" className="font-weight-bold">
                                                        Location
                          </label>
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="Location"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.Location}
                                                        required
                                                    />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="PO BOXs" className="font-weight-bold">
                                                        PO BOX  </label>

                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="POBox"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.POBox}
                                                        required
                                                    />
                                                </div>
                                                <div class="col-sm-3">
                                                    <label for="PostalCode" className="font-weight-bold">
                                                        Postal Code
                          </label>
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="PostalCode"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.PostalCode}
                                                        required
                                                    />
                                                </div>
                                                <div class="col-sm-3">
                                                    <label for="Town" className="font-weight-bold">
                                                        Town
                          </label>
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="Town"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.Town}
                                                        required
                                                    />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Mobile" className="font-weight-bold">
                                                        Mobile </label>

                                                    <input
                                                        type="number"
                                                        class="form-control"
                                                        name="Mobile"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.Mobile}
                                                        required
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="Website" className="font-weight-bold">
                                                        Website  </label>
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="Website"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.Website}
                                                        required
                                                    />
                                                </div>
                                            </div>
                                            <div class="row">                                           
                                                <div class="col-sm-6">
                                                    <label for="Telephone" className="font-weight-bold">
                                                        Telephone      </label>
                                                    <input
                                                        type="number"
                                                        class="form-control"
                                                        name="Telephone"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.Telephone}
                                                        required
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="RegistrationNo" className="font-weight-bold">
                                                        RegistrationNo      </label>
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="RegistrationNo"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.RegistrationNo}
                                                        required
                                                    />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Companyregistrationdate" className="font-weight-bold">
                                                        Registration Date      </label>
                                                   

                                                    <input
                                                        type="date"
                                                        name="Companyregistrationdate"
                                                        required
                                                        defaultValue={this.state.Companyregistrationdate}
                                                        className="form-control"
                                                        onChange={this.handleInputChange}
                                                       
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="PIN" className="font-weight-bold">
                                                        PIN      </label>
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="PIN"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.PIN}
                                                        required
                                                    />
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Logo" className="font-weight-bold">
                                                        Logo  </label>
                                                    <input
                                                        type="file"
                                                        className="form-control"
                                                        name="file"
                                                        onChange={this.onChangeHandler}
                                                        multiple
                                                    />
                                                    <div class="form-group">
                                                        <Progress
                                                            max="100"
                                                            color="success"
                                                            value={this.state.loaded}
                                                        >
                                                            {Math.round(this.state.loaded, 2)}%
                                                     </Progress>
                                                    </div>
                                                    <button
                                                        type="button"
                                                        class="btn btn-success "
                                                        onClick={this.onClickHandler}
                                                    >
                                                        Upload
                                                    </button>
                                                </div>
                                                <div class="col-sm-6">
                                                    <br />
                                                    <div className="form-group">
                                                        <img
                                                            alt=""
                                                            className=""
                                                            src={"uploads/profilepics/" + this.state.Logo}
                                                            style={Signstyle}
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                            <div className=" row">
                                                <div className="col-sm-2" />
                                                <div className="col-sm-8" />
                                                <div className="col-sm-2">
                                                    <button
                                                        type="submit"
                                                        className="btn btn-primary float-right"

                                                    >
                                                        Save
                                            </button>
                                                </div>
                                            </div>
                                        </form>
                                      
                                    </div>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            );
        }
    }
}

export default applicants;
