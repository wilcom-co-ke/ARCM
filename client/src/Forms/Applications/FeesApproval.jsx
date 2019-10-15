import React, { Component } from "react";
import swal from "sweetalert";
import Table from "./../../Table";
import TableWrapper from "./../../TableWrapper";
import "react-toastify/dist/ReactToastify.css";
import Modal from 'react-awesome-modal';
class FeesApproval extends Component {
    constructor() {
        super();
        this.state = {
            Requests: [],
            FeesDetails: [] ,
            ApplicationFeesDetails:[],
            summary: false,
            openView: false,
            open: false,
            Remarks: "",
            IsAccept: false,
            IsDecline: false,
            NewDeadLine: "",
            FilingDate: "",
            PE: "",
            PEPOBox: "",
            PELocation: "",
            PETown: "",
            PEPostalCode: "",
            PEMobile: "",
            PEEmail: "",
            PEWebsite: "",
            ApplicationID: "",
            Reason: "",
            RequestedDate: "",
            Status: "",
            TenderNo: "",
            TenderName: "",
            TenderValue: "",
            StartDate: "",
            CalculatedAAmount:"",
            ApprovedAmount:"",
            FeeEntryType:"",
            CalculatedAAmountApplicationFee: "",
            ApprovedAmountApplicationFee: "",
            Narration:""

        };

        this.fetchApplicationtenderdetails = this.fetchApplicationtenderdetails.bind(this);
        this.fetchApplicantDetails = this.fetchApplicantDetails.bind(this);
        this.ShowAcceptModal = this.ShowAcceptModal.bind(this);
     
        this.fetchPendingRequests = this.fetchPendingRequests.bind(this)
    }
    formatNumber = num => {
        let newtot = Number(num).toFixed(2);
        return newtot.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
    };
    fetchFeesDetails = () => {
        this.setState({ FeesDetails: [] });
        fetch("/api/FeesApproval", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(FeesDetails => {
                if (FeesDetails.length > 0) {
                    this.setState({ FeesDetails: FeesDetails });

                } else {
                    swal("", FeesDetails.message, "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };
    fetchPendingRequests = () => {
        this.setState({ Requests: [] });
        fetch("/api/FeesApproval/1" , {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(Requests => {
                if (Requests.length > 0) {
                    this.setState({ Requests: Requests });

                } else {
                    swal("", Requests.message, "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };

    handleSubmit = event => {
        event.preventDefault();
        
        const data = {
            Approver: localStorage.getItem("UserName"),
            ApplicationID: this.state.ApplicationID,
            ApprovedAmount: this.state.ApprovedAmountApplicationFee,
            FeeEntryType: "Application fee",
            Narration: this.state.Narration
        };
        const data1 = {
            Approver: localStorage.getItem("UserName"),
            ApplicationID: this.state.ApplicationID,
            ApprovedAmount: this.state.ApprovedAmount,
            FeeEntryType: "10% Of Tender Value",
            Narration: this.state.Narration
        };

        

        this.Approve("/api/FeesApproval", data);
        this.Approve("/api/FeesApproval", data1);
     
        this.setState({ summary: false });
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
    SendMail = (Name, email, ID, subject, NewDeadline) => {
        const emaildata = {
            to: email,
            subject: subject,
            ID: ID,
            Name: Name,
            NewDeadline: NewDeadline,
            Remarks: this.state.Remarks
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
    Approve(url = ``, data = {}) {
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
                       
                            let AproverEmail = data.results[0].Email;
                           
                            let AproverMobile = data.results[0].Phone;
                            let Name = data.results[0].Name;
                            this.SendSMS(
                                AproverMobile,
                                "Fees payable for application you submited has been approved.You are required to make payments and submited payment details."
                            );
                            this.SendMail(
                                Name,
                                AproverEmail,
                                "Fee Payment notification",
                                "FEES PAYMENT NOTIFICATION",
                                ""
                            );
                        this.SendSMS(
                            this.state.Applicantname,
                            "Fees payable for application you submited has been approved.You are required to make payments and submited payment details."
                        );
                       
                        this.SendMail(
                            this.state.Applicantname,
                            this.state.ApplicantEmail,
                            "Fee Payment notification",
                            "FEES PAYMENT NOTIFICATION",
                            ""
                        );
                    


                        this.fetchPendingRequests();
                        swal("", "Application Approved", "success");

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
   

    GoBack = e => {
        e.preventDefault();
        this.setState({ summary: false });
    }
    ShowAcceptModal = (k,e )=> {
       
        var rows = [...this.state.ApplicationFeesDetails];
        const filtereddata = rows.filter(
            item => item.EntryType == "Application fee"
        );
        const filtereddata1 = rows.filter(
            item => item.EntryType == "10% Of Tender Value"
        );
        //salert(filtereddata1.length)
        if (filtereddata.length > 0){
            if (filtereddata1.length > 0) {
                let data = {
                    CalculatedAAmountApplicationFee: filtereddata[0].CalculatedAmount,
                    ApprovedAmountApplicationFee: filtereddata[0].CalculatedAmount,
                    CalculatedAAmount: filtereddata1[0].CalculatedAmount,
                    ApprovedAmount: filtereddata1[0].CalculatedAmount,
                    FeeEntryType: filtereddata1[0].EntryType,
                    FeeEntryTypeApplicationFee: filtereddata[0].EntryType,
                    open: true,
                    IsAccept: true
                }
                this.setState(data);
            }
        }
    
     
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
                            this.fetchPendingRequests();
                            this.fetchFeesDetails()
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
    fetchApplicantDetails = (Applicant) => {
        fetch("/api/applicants/" + Applicant, {
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

                } else {
                    swal("", ApplicantDetails.message, "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };
    fetchApplicationtenderdetails = (Application) => {
        fetch("/api/DeadlineExtensionApproval/tenderdetails/" + Application, {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(ApplicantDetails => {
                if (ApplicantDetails.length > 0) {

                    this.setState({ TenderNo: ApplicantDetails[0].TenderNo });
                    this.setState({ TenderName: ApplicantDetails[0].Name });
                    this.setState({ TenderValue: ApplicantDetails[0].TenderValue });
                    this.setState({ StartDate: ApplicantDetails[0].StartDate });
                } else {
                    swal("", ApplicantDetails.message, "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };
    handViewApplication = k => {
        this.fetchApplicantDetails(k.ApplicantID)
        this.fetchApplicationtenderdetails(k.ID)
        const data = {
            FilingDate: new Date(k.FilingDate).toLocaleDateString(),
            PE: k.Name,
            PEPOBox: k.POBox,
            PELocation: k.Location,
            PETown: k.Town,
            PEPostalCode: k.PostalCode,
            PEMobile: k.Mobile,
            PEEmail: k.Email,
            PEWebsite: k.Website,
            IsAccept: false,
            IsDecline: false,
            ApplicationID: k.ID,         
            Status: k.FeesStatus,        
        };
      
        var rows = [...this.state.FeesDetails];
        const filtereddata = rows.filter(
            item => item.ApplicationID == k.ID
        );
        this.setState({ ApplicationFeesDetails: filtereddata });
        this.setState({ summary: true });
        this.setState(data);

    }
    handleInputChange = event => {
        event.preventDefault();
        this.setState({ [event.target.name]: event.target.value });
    };

    closeModal = () => {
        this.setState({ open: false });
    }

    render() {


        const ColumnData = [
            {
                label: "ID",
                field: "ID",
            },
            {
                label: "Procuring Entity",
                field: "Name",
                sort: "asc"
            },
            {
                label: "FilingDate",
                field: "FilingDate",
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
        const rows = [...this.state.Requests];
        if (rows.length > 0) {
            rows.map((k, i) => {
                let Rowdata = {
                    ID: k.ID,
                    Name: k.Name,
                    FilingDate: new Date(k.FilingDate).toLocaleDateString(),
                    Status: k.FeesStatus,
                    action: (
                        <span>
                            <a
                                className="fa fa-edit"
                                style={{ color: "#007bff" }}
                                onClick={e => this.handViewApplication(k, e)}
                            >
                                {" "}
                                View </a>

                        </span>
                    )
                };
                Rowdata1.push(Rowdata);
            });
        }

        let headingstyle = {
            color: "#7094db"
        }

        let ShowAcceptModal = this.ShowAcceptModal;
        if (this.state.summary) {
            return (
                <div>

                    <Modal visible={this.state.open} width="880" height="430" effect="fadeInUp" onClickAway={() => this.closeModal()}>
                        <a style={{ float: "right", color: "red", margin: "10px" }} href="javascript:void(0);" onClick={() => this.closeModal()}><i class="fa fa-close"></i></a>
                        <div>
                            <h4 style={{ "text-align": "center" }}>Fees Approval </h4>
                            <div className="container-fluid">
                                <div className="col-sm-12">
                                    <div className="ibox-content">
                                        <form onSubmit={this.handleSubmit}>
                                            <h3 style={{ color: "#1c84c6" }}>1.{this.state.FeeEntryTypeApplicationFee}</h3>
                                                <div className=" row">
                                                <div className="col-sm">
                                                    <div className="form-group">
                                                        <label
                                                            htmlFor="exampleInputPassword1"
                                                            className="font-weight-bold"
                                                        >
                                                            Calculated Amount
                                                         </label>
                                                        <input
                                                            onChange={this.handleInputChange}
                                                            value={this.state.CalculatedAAmountApplicationFee}
                                                            type="number"
                                                            required
                                                            name="CalculatedAAmountApplicationFee"
                                                            className="form-control"
                                                            disabled

                                                        />
                                                    </div>
                                                </div>
                                                <div className="col-sm">
                                                    <div className="form-group">
                                                        <label
                                                            htmlFor="exampleInputPassword1"
                                                            className="font-weight-bold"
                                                        >
                                                            ApprovedAmount
                                                         </label>
                                                        <input
                                                            onChange={this.handleInputChange}
                                                            value={this.state.ApprovedAmountApplicationFee}
                                                            type="number"
                                                            required
                                                            name="ApprovedAmountApplicationFee"
                                                            className="form-control"

                                                        />
                                                    </div>
                                                </div>

                                            </div>
                                            <h3 style={{ color: "#1c84c6" }}>2.{this.state.FeeEntryType}</h3>
                                            <div className=" row">
                                                <div className="col-sm">
                                                    <div className="form-group">
                                                        <label
                                                            htmlFor="exampleInputPassword1"
                                                            className="font-weight-bold"
                                                        >
                                                            Calculated Amount
                                                         </label>
                                                        <input
                                                            onChange={this.handleInputChange}
                                                            value={this.state.CalculatedAAmount}
                                                            type="number"
                                                            required
                                                            name="CalculatedAAmount"
                                                            className="form-control"
                                                            disabled
                                                            
                                                        />
                                                    </div>
                                                </div>
                                                <div className="col-sm">
                                                    <div className="form-group">
                                                        <label
                                                            htmlFor="exampleInputPassword1"
                                                            className="font-weight-bold"
                                                        >
                                                            ApprovedAmount
                                                         </label>
                                                        <input
                                                            onChange={this.handleInputChange}
                                                            value={this.state.ApprovedAmount}
                                                            type="number"
                                                            required
                                                            name="ApprovedAmount"
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
                                                            Narration
                                                         </label>
                                                        <input
                                                            onChange={this.handleInputChange}
                                                            value={this.state.Narration}
                                                            type="text"
                                                            required
                                                            name="Narration"
                                                            className="form-control"

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
                                                            Approve
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

                    <div className="row wrapper border-bottom white-bg page-heading">
                        <div className="col-lg-8">
                            <ol className="breadcrumb">
                                <li className="breadcrumb-item">
                                    <h2 className="font-weight-bold">Fees Approval <span style={headingstyle}> {}</span></h2>
                                </li>

                            </ol>
                        </div>
                        <div className="col-lg-4">

                            {/* <button className="btn btn-primary" onClick={this.ShowAcceptModal} style={{ marginTop: 20 }}>Accept</button>
                            &nbsp;&nbsp;
                                <button className="btn btn-danger " onClick={this.ShowRejectModal} style={{ marginTop: 20 }}>Reject</button>
                            &nbsp;&nbsp; */}
                                <button
                                type="button"
                                style={{ marginTop: 20 }}
                                onClick={this.GoBack}
                                className="btn btn-primary"
                            >
                                Back
                                </button>

                        </div>

                    </div>
                    <p></p>
                    <div className="border-bottom white-bg p-4">

                        <div className="row">
                            <div className="col-sm-5">
                                <h3 style={headingstyle}>Request Submited By(Applicant)</h3>
                                <div className="col-lg-12 border border-success rounded">
                                    <table className="table table-borderless table-sm">
                                        <tr>
                                            <td className="font-weight-bold"> Name:</td>
                                            <td> {this.state.Applicantname}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> Email:</td>
                                            <td> {this.state.ApplicantEmail}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> Mobile:</td>
                                            <td> {this.state.ApplicantMobile}</td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> POBOX:</td>
                                            <td>
                                                   
                                                {this.state.ApplicantPOBox}-{this.state.ApplicantPostalCode}
                                            </td>
                                        </tr>{" "}
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
                            <div className="col-sm-5">
                                <h3 style={headingstyle}>Procuring Entity</h3>
                                <div className="col-lg-12 border border-success rounded">
                                    <table className="table table-borderless table-sm">
                                        <tr>
                                            <td className="font-weight-bold"> Name:</td>
                                            <td> {this.state.PE}</td>
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
                        <br />


                        <div className="row">
                            <div className="col-sm-10">
                                <h3 style={headingstyle}>Tender Details</h3>
                                <div className="col-lg-12 border border-success rounded">
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
                                                {" "}
                                                {this.formatNumber(this.state.TenderValue)}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td className="font-weight-bold"> Opening Date:</td>
                                            <td>{new Date(this.state.StartDate).toLocaleDateString()}</td>
                                        </tr>{" "}
                                    </table>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div className="row">
                            <div className="col-sm-10">
                                <h3 style={headingstyle}>Fees Details</h3>
                                <div className="col-lg-12 border border-success rounded">
                                    
                                    <table className="table table-sm ">
                                        <th>#</th>
                                        <th>fees description</th>
                                        <th>CalculatedAmount</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                        {this.state.ApplicationFeesDetails.map( (k, i)=> {
                                          
                                                return (
                                                    <tr>
                                                        <td>{+i + +1}</td>
                                                        <td>{k.EntryType}</td>
                                                        <td>{this.formatNumber(k.CalculatedAmount)}</td>
                                                        <td>{k.FeesStatus}</td>
                                                        <td style={{ color: "#7094db", cursor: "pointer"}} onClick ={ e => ShowAcceptModal(k,e)}>Approve</td>
                                                    </tr>
                                                );
                                         
                                        })}
                                       
                                       
                                        <tfoot>
                                            <tr>
                                                <th></th>
                                                <th scope="row">Total Amount</th>
                                                <th style={{color:"Red"}}>
                                                    {this.formatNumber(
                                                        this.state.TenderValue * 0.1 + 5000
                                                    )}
                                                </th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            )

        } else {
            return (
                <div>

                    <div className="row wrapper border-bottom white-bg page-heading">
                        <div className="col-lg-12">
                            <ol className="breadcrumb">
                                <li className="breadcrumb-item">
                                    <h2> REQUESTS AWAITING MY REVIEW</h2>
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

export default FeesApproval;
