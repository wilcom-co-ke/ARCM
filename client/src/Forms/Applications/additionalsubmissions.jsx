import React, { Component } from "react";
import swal from "sweetalert";
import Table from "./../../Table";
import TableWrapper from "./../../TableWrapper";
import "react-toastify/dist/ReactToastify.css";
import Popup from "reactjs-popup";
import popup from "./../../Styles/popup.css";
import CKEditor from "ckeditor4-react";
import { Progress } from "reactstrap";
import { ToastContainer, toast } from "react-toastify";
import axios from "axios";
import ReactHtmlParser from "react-html-parser";
let userdateils = localStorage.getItem("UserData");
let data = JSON.parse(userdateils);
var dateFormat = require("dateformat");
class additionalsubmissions extends Component {
    constructor() {
        super();
        this.state = {
            open: false,
            openRequest: false,
            ApplicantUserEmail: data.Email,
            ApplicantPhone: data.Phone,
            ApplicantUserName: data.Name,
            Applications: [],
            AdditionalSubmisions:[],
            TenderNo: "",
            ApplicationID:"",
            TenderID: "",
            TenderValue: "",
            ApplicationID: "",
            TenderName: "",
            PEID: "",
            StartDate: "",
            ClosingDate: "",
            ApplicationREf: "",
            ApplicantID: "",
            EntryType: "",
            RequestDescription: "",
            GroundDescription: "",
            summary: false,
            AdditionalDescription:"",
            ApplicantDetails: [],
            ApplicantCode: "",
            Applicantname: "",
            FilingDate: "",
            PEName: "",
            ApplicationNo: "",
            selectedFile: null,
            loaded: 0,
            ApplicantLocation: "",
            ApplicantMobile: "",
            ApplicantEmail: "",
            ApplicantPIN: "",
            ApplicantWebsite: "",
            PEPOBox: "",
            PEPostalCode: "",
            PETown: "",
            PEPostalCode: "",
            PEMobile: "",
            PEEmail: "",
            PEWebsite: "",
            TotalAmountdue: "",
            UploadedFilename:"",
            ApplicantPostalCode: "",
            ApplicantPOBox: "",
            ApplicantTown: "",
            WithdrawalReason: ""
        };
       
    }
    closeModal = () => {
        this.setState({ open: false });
    };

    fetchMyApplications = ApplicantID => {
        fetch("/api/applications/" + ApplicantID + "/Applicant", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(ApplicantDetails => {
                if (ApplicantDetails.length > 0) {
                    this.setState({ Applications: ApplicantDetails });
                } else {
                    swal("", ApplicantDetails.message, "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };
    fetchApplicantDetails = () => {
        fetch("/api/applicants/" + localStorage.getItem("UserName"), {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(ApplicantDetails => {

                if (ApplicantDetails.length > 0) {
                    this.setState({
                        ApplicantPostalCode: ApplicantDetails[0].PostalCode
                    });
                    this.setState({
                        ApplicantCode: ApplicantDetails[0].ApplicantCode
                    });

                    this.setState({ ApplicantPOBox: ApplicantDetails[0].POBox });
                    this.setState({ ApplicantTown: ApplicantDetails[0].Town });

                    this.setState({ ApplicantDetails: ApplicantDetails });
                    this.setState({ Applicantname: ApplicantDetails[0].Name });

                    this.setState({ ApplicantLocation: ApplicantDetails[0].Location });
                    this.setState({ ApplicantMobile: ApplicantDetails[0].Mobile });
                    this.setState({ ApplicantEmail: ApplicantDetails[0].Email });
                    this.setState({ ApplicantPIN: ApplicantDetails[0].PIN });
                    this.setState({ ApplicantWebsite: ApplicantDetails[0].Website });

                    this.setState({ ApplicantID: ApplicantDetails[0].ID });
                    this.fetchMyApplications(ApplicantDetails[0].ID);
                } else {
                    swal("", ApplicantDetails.message, "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };
    fetchAdditionalSubmisions = (ApplicationID) => {
        this.setState({
            AdditionalSubmisions: []
        });
        fetch("/api/additionalsubmissions/" + ApplicationID, {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(AdditionalSubmisions => {

                if (AdditionalSubmisions.length > 0) {
                    this.setState({
                        AdditionalSubmisions: AdditionalSubmisions
                    });
                   
                } else {
                    toast.error(AdditionalSubmisions.message);
                }
            })
            .catch(err => {
                toast.error(err.message);

            });
    };
    openWithdraw = e => {
        e.preventDefault();
        this.setState({ open: true });
    }

    GoBack = e => {
        e.preventDefault();
        this.setState({ summary: false });
    };    
    handleSubmit = event => {
        event.preventDefault();
        const data = {
            DocName: this.state.UploadedFilename,
            ApplicationID: this.state.ApplicationID,
            Description: this.state.AdditionalDescription,
            FilePath: process.env.REACT_APP_BASE_URL+"/Documents"
        };
        this.postData("/api/additionalsubmissions", data);
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
                     toast.success("Submited successfully")
                        this.fetchAdditionalSubmisions(this.state.ApplicationID);
                        this.setState({ open: false})
                    } else {
                        toast.error(data.message);                     
                    }
                })
            )
            .catch(err => {
                toast.error(err.message);
            });
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
                            this.fetchApplicantDetails();                         
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
    formatNumber = num => {
        let newtot = Number(num).toFixed(2);
        return newtot.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
    };
    handViewApplication = k => {
        const data = {
            ApplicationID: k.ID,
            PEPOBox: k.PEPOBox,
            PEPostalCode: k.PEPostalCode,
            PETown: k.PETown,
            PEPostalCode: k.PEPostalCode,
            PEMobile: k.PEMobile,
            PEEmail: k.PEEmail,
            PEWebsite: k.PEWebsite,
            TenderID: k.TenderID,            
            ApplicationNo: k.ApplicationNo,
            TenderNo: k.TenderNo,
            ApplicationREf: k.ApplicationREf,
            PEName: k.PEName,
            FilingDate: new Date(k.FilingDate).toLocaleDateString(),
            TenderName: k.TenderName,
            Status: k.Status,
            TenderType: k.TenderType,
            TenderSubCategory: k.TenderSubCategory,
            TenderTypeDesc: k.TenderTypeDesc,
            TenderCategory: k.TenderCategory,
            Timer: k.Timer,
            TenderValue: k.TenderValue,
            StartDate: dateFormat(
                new Date(k.StartDate).toLocaleDateString(),
                "isoDate"
            ),
            ClosingDate: dateFormat(
                new Date(k.ClosingDate).toLocaleDateString(),
                "isoDate"
            )
        };
        this.setState({ summary: true });
        this.setState(data);
        this.fetchAdditionalSubmisions(k.ID);
    };

    SendMail = (ApplicationNo, email, ID, subject1, Name) => {
        const emaildata = {
            to: email,
            subject: subject1,
            ApplicationNo: ApplicationNo,
            ID: ID,
            Name: Name
        };

        fetch("/api/NotifyApprover", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            },
            body: JSON.stringify(emaildata)
        })
            .then(response => response.json().then(data => { }))
            .catch(err => {
                //swal("Oops!", err.message, "error");
            });
    };
    SendSMS(MobileNumber, Msg) {
        let data = {
            MobileNumber: MobileNumber,
            Message: Msg
        };
        return fetch("/api/sendsms", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
            .then(response =>
                response.json().then(data => {
                    if (data.success) {
                    } else {
                        swal("", data.message, "error");
                    }
                })
            )
            .catch(err => {
                swal("", err.message, "error");
            });
    }
    onEditorChange = evt => {
        this.setState({
            AdditionalDescription: evt.editor.getData()
        });
    };   
    onClickHandler = event => {
        event.preventDefault();
        if (this.state.selectedFile) {
            const data = new FormData();

            for (var x = 0; x < this.state.selectedFile.length; x++) {
                data.append("file", this.state.selectedFile[x]);
            }
            axios
                .post("/api/upload/Document", data, {
                    // receive two parameter endpoint url ,form data
                    onUploadProgress: ProgressEvent => {
                        this.setState({
                            loaded: (ProgressEvent.loaded / ProgressEvent.total) * 100
                        });
                    }
                })
                .then(res => {
                    //this.saveDocuments(res.data);
                    this.setState({
                        UploadedFilename: res.data
                    });
                    toast.success("Upload Completed")
                    // localStorage.setItem("UserPhoto", res.data);
                })
                .catch(err => {
                    toast.error("upload fail");
                });
        } else {
            toast.warn("Please select a file to upload");
        }
    };
    maxSelectFile = event => {
        let files = event.target.files; // create file object
        if (files.length > 1) {
            const msg = "Only One file can be uploaded at a time";
            event.target.value = null; // discard selected file
            toast.warn(msg);
            return false;
        }
        return true;
    };
    onChangeHandler = event => {
        //for multiple files
        var files = event.target.files;
        if (this.maxSelectFile(event)) {
            this.setState({
                selectedFile: files,
                loaded: 0
            });
        }
    };
    ViewFile = (k, e) => {
        let filepath = k.FilePath + "/" + k.FileName;
        window.open(filepath);
        //this.setState({ openFileViewer: true });
    };
    render() {

        const ColumnData = [
            { label: "ApplicationNo", field: "ApplicationNo" },
            {
                label: "TenderName",
                field: "TenderName",
                sort: "asc"
            },
            {
                label: "PE",
                field: "PEName",
                sort: "asc"
            },
            {
                label: "FilingDate",
                field: "FilingDate",
                sort: "asc"
            },
            {
                label: "ApplicationREf",
                field: "ApplicationREf",
                sort: "asc"
            },
            {
                label: "Status",
                field: "Status",
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
        const rows = [...this.state.Applications];

        if (rows.length > 0) {
            rows.map((k, i) => {
                if (k.Status === "APPROVED") {
                    let Rowdata = {
                        ApplicationNo: (
                            <a onClick={e => this.handViewApplication(k, e)}>
                                {k.ApplicationNo}
                            </a>
                        ),
                        TenderName: (
                            <a onClick={e => this.handViewApplication(k, e)}>
                                {k.TenderName}
                            </a>
                        ),
                        PE: <a onClick={e => this.handViewApplication(k, e)}>{k.PEName}</a>,
                        FilingDate: (
                            <a onClick={e => this.handViewApplication(k, e)}>
                                {new Date(k.FilingDate).toLocaleDateString()}
                            </a>
                        ),
                        ApplicationREf: (
                            <a onClick={e => this.handViewApplication(k, e)}>
                                {k.ApplicationREf}
                            </a>
                        ),
                        Status: (
                            <span>
                                <b

                                    onClick={e => this.handViewApplication(k, e)}
                                >
                                    APPROVED
                </b>
                            </span>
                        ),

                        action: (
                            <span>
                                <a
                                    style={{ color: "#007bff" }}
                                    onClick={e => this.handViewApplication(k, e)}
                                >
                                    {" "}
                                    Add{" "}
                                </a>
                            </span>
                        )
                    };
                    Rowdata1.push(Rowdata);
                }
            });
        }
        let headingstyle = {
            color: "#7094db"
        };
        let ViewFile = this.ViewFile;
        if (this.state.summary) {
            return (
                <div>
                    <ToastContainer/>
                    <Popup
                        open={this.state.open}
                        closeOnDocumentClick
                        onClose={this.closeModal}
                    >
                        <div className={popup.modal}>
                            <a className="close" onClick={this.closeModal}>
                                &times;
                    </a>

                            <div className={popup.header} className="font-weight-bold">
                                {" "}
                                ADDITIONAL SUBMISSION{" "}
                            </div>
                            <div className={popup.content}>
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
                                                                Backgound Information
                                                                         </label>
                                                            <CKEditor
                                                            
                                                                onChange={this.onEditorChange}
                                                            />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm">
                                                        <label for="Document" className="font-weight-bold">
                                                            Document
                                                             </label>
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
                            </button>{" "}
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
                                                                    CONFIRM
                                                        </button>

                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </Popup>

                    <div className="row wrapper border-bottom white-bg page-heading">
                        <div className="col-lg-9">
                            <ol className="breadcrumb">
                                <li className="breadcrumb-item">
                                    <h2 className="font-weight-bold">
                                        Application NO:{" "}
                                        <span className="font-weight-bold text-success">
                                            {" "}
                                            {this.state.ApplicationNo}
                                        </span>
                                    </h2>
                                </li>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                       <li>
                                    <h2 className="font-weight-bold">
                                        STATUS:
                                        <span className="text-success">
                                            {this.state.Status}
                                        </span>

                                    </h2>
                                </li>
                            </ol>
                        </div>
                        <div className="col-lg-3">
                            <div className="row wrapper ">
                                <button
                                    type="button"
                                    style={{ marginTop: 40 }}
                                    onClick={this.openWithdraw}
                                    className="btn btn-primary float-right"
                                >
                                    Submit Aditional Submission </button>&nbsp;
                                    <button
                                    type="button"
                                    style={{ marginTop: 40 }}
                                    onClick={this.GoBack}
                                    className="btn btn-warning float-left"
                                >
                                    &nbsp; Back </button>
                            </div>
                        </div>
                    </div>
                    <p></p>
                    <div className="border-bottom white-bg p-4">
                        <div className="row">
                            <div className="col-sm-6">
                                <h3 style={headingstyle}> Applicant details</h3>
                                <div className="col-lg-10 border border-success rounded">
                                    <table className="table table-borderless table-sm">
                                        <tr>
                                            <td className="font-weight-bold"> NAME:</td>
                                            <td> {this.state.Applicantname}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> EMAIL:</td>
                                            <td> {this.state.ApplicantEmail}</td>
                                        </tr>

                                        <tr>
                                            <td className="font-weight-bold"> Mobile:</td>

                                            <td> {this.state.ApplicantMobile}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> POBOX:</td>
                                            <td>
                                                {" "}
                                                {this.state.ApplicantPOBox}-
                          {this.state.ApplicantPostalCode}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> Town:</td>
                                            <td> {this.state.ApplicantTown}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> Website:</td>
                                            <td> {this.state.ApplicantWebsite}</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div className="col-lg-6">
                                <h3 style={headingstyle}>Procuring Entity Details</h3>
                                <div className="col-lg-10 border border-success rounded">
                                    <table className="table table-borderless table-sm">
                                        <tr>
                                            <td className="font-weight-bold"> Name:</td>
                                            <td> {this.state.PEName}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> Email:</td>
                                            <td> {this.state.PEEmail}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> Mobile:</td>
                                            <td> {this.state.PEMobile}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> POBOX:</td>
                                            <td>
                                                {" "}
                                                {this.state.PEPOBox}-{this.state.PEPostalCode}
                                            </td>
                                        </tr>{" "}
                                        <tr>
                                            <td className="font-weight-bold"> Town:</td>
                                            <td> {this.state.PETown}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> Website:</td>
                                            <td> {this.state.PEWebsite}</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-lg-12 ">
                                <h3 style={headingstyle}>Tender Details</h3>
                                <div className="col-lg-11 border border-success rounded">
                                    <table className="table table-borderless table-sm">
                                        <tr>
                                            <td className="font-weight-bold"> TenderNo:</td>
                                            <td> {this.state.TenderNo}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> TenderName:</td>
                                            <td> {this.state.TenderName}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> Tender Value:</td>
                                            <td className="font-weight-bold">
                                                {this.formatNumber(this.state.TenderValue)}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> FilingDate:</td>
                                            <td> {this.state.FilingDate}</td>
                                        </tr> 
                                        <tr>
                                            <td className="font-weight-bold">
                                                {" "}
                                                Application Timing:
                                         </td>
                                            <td> {this.state.Timer}</td>
                                        </tr>{" "}
                                        <tr>
                                            <td className="font-weight-bold"> TenderType:</td>
                                            <td> {this.state.TenderTypeDesc}</td>
                                        </tr>
                                        {this.state.TenderType === "B" ? (
                                            <tr>
                                                <td className="font-weight-bold"> TenderCategory:</td>
                                                <td> {this.state.TenderCategory}</td>
                                            </tr>
                                        ) : null}{" "}
                                        {this.state.TenderType === "B" ? (
                                            <tr>
                                                <td className="font-weight-bold">
                                                    {" "}
                                                    TenderSubCategory:
                                                </td>
                                                <td> {this.state.TenderSubCategory}</td>
                                            </tr>
                                        ) : null}
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-lg-12 ">
                                <h3 style={headingstyle}>Additional Submissions</h3>
                                <div className="col-lg-11 border border-success rounded">
                                    <table className="table table-borderless table-sm">
                                        <th>ID</th>
                                        <th>Description</th>                                    
                                        <th>Date Uploaded</th>
                                        <th>Actions</th>
                                        {this.state.AdditionalSubmisions.map(function (k, i) {
                                            return (
                                                <tr>
                                                    <td>{i + 1}</td>
                                                    <td>   {ReactHtmlParser(k.Description)}</td>                                                   
                                                    <td>
                                                        {new Date(k.Create_at).toLocaleDateString()}
                                                    </td>
                                                    <td>
                                                  <a onClick={e => ViewFile(k, e)} className="text-success">
                                                            <i class="fa fa-eye" aria-hidden="true"></i>View Attachemnt
                                                      </a>
                                                    </td>
                                                </tr>
                                            );
                                        })}
                                    </table>
                                </div>
                            </div>
                        </div>
                        <br />

                    </div>
                </div>
            );
        } else {
            return (
                <div>
                    <div className="row wrapper border-bottom white-bg page-heading">
                        <div className="col-lg-12">
                            <ol className="breadcrumb">
                                <li className="breadcrumb-item">
                                    <h2>My Applications</h2>
                                </li>
                            </ol>
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

export default additionalsubmissions;
