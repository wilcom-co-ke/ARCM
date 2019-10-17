import React, { Component } from "react";
import swal from "sweetalert";
import Select from "react-select";
import Table from "../../Table";
import TableWrapper from "../../TableWrapper";
import { Link } from "react-router-dom";
var dateFormat = require('dateformat');
var jsPDF = require("jspdf");
require("jspdf-autotable");
var _ = require("lodash");
class Panels extends Component {
    constructor() {
        super();
        this.state = {
            Panels: [],
            privilages: [],
            UserName: "",       
            PanelRole:"",           
            Users:[],
            Applications:[],
            ApplicantDetails:[],
            ApplicationNo:"",
            PEDetails:[],
            summary:false,
            PanelStatus:"",
            showAdd:false
           

        };     
         
        this.FormPanel = this.FormPanel.bind(this)
        this.handleSelectChange = this.handleSelectChange.bind(this)
        this.fetchPanels = this.fetchPanels.bind(this)
        this.AddUser = this.AddUser.bind(this)
        this.fetchRespondedApplications = this.fetchRespondedApplications.bind(this)
        
    }
    ToggleAdd=()=>{
        this.setState({ showAdd: !this.state.showAdd });
    }
    exportpdf = () => {
        var columns = [
            { title: "Name", dataKey: "Name" },
            { title: "Description", dataKey: "Description" }
        ];

        const data = [...this.state.Panels];

        var doc = new jsPDF("p", "pt");
        doc.autoTable(columns, data, {
            margin: { top: 60 },
            beforePageContent: function (data) {
                doc.text("ARCM Panels", 40, 50);
            }
        });
        doc.save("Panels.pdf");
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
    fetchUsers = () => {
        fetch("/api/users", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(Users => {
                if (Users.length > 0) {
                    const GroupedUsers = [_.groupBy(Users, "Category")];
                    this.setState({ Users: GroupedUsers[0].System_User });
                } else {
                    swal("", Users.message, "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };
    fetchRespondedApplications = () => {
        this.setState({ Applications: [] });
        fetch("/api/Panels/1/ApplicationNo", {
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
    fetchApplicantDetails = (ApplicationNo) => {
        this.setState({ ApplicantDetails: [] });
        fetch("/api/Panels/" + ApplicationNo+"/ApplicantDetails", {
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
        this.setState({ [actionMeta.name]: UserGroup.value });
        if(actionMeta.name ==="ApplicationNo"){
            this.fetchApplicantDetails(UserGroup.value)
            
            var rows = [...this.state.Applications];
                   
            const filtereddata = rows.filter(
                item => item.ApplicationNo == UserGroup.value
            );
            this.setState({ PEDetails: filtereddata });
            
        }
        
    };
    handleInputChange = event => {
        event.preventDefault();
        this.setState({ [event.target.name]: event.target.value });
    };
    saveMembers=()=>{
        swal("","Saved successfully","success")
    }
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
    SendMail = (Name, email, ID, subject, ApplicationNo) => {
        const emaildata = {
            to: email,
            subject: subject,
            ID: ID,
            Name: Name,
            ApplicationNo: ApplicationNo
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
    sendBulkNtification = (AproverEmail, AproverMobile, Name, ApplicationNo) => {
        // let AproverEmail = data.results[0].Email;
        // let AproverMobile = data.results[0].Phone;
        // let Name = data.results[0].Name;
        // let ApplicationNo = data.results[0].ApplicationNo;
        this.SendSMS(
            AproverMobile,
            "New Panel List for ApplicationNo:" + ApplicationNo + " has been submited and it's awaiting your review."
        );
        this.SendMail(
            Name,
            AproverEmail,
            "PanelApprover",
            "PANEL LIST APPROVAL",
            ApplicationNo
        );

    };
    subMitPanellist=()=>{
        
        fetch("/api/Panels/" + this.state.ApplicationNo, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(response =>
                response.json().then(data => {
                    if (data.success) {
                        swal("", "Submited successsfuly", "success");
                        data.results.map((item, key) =>
                            this.sendBulkNtification(item.AproverEmail, item.AproverMobile, item.Name, item.ApplicationNo)
                        );
                      
                        this.fetchRespondedApplications();
                        this.setState({ summary: false });

                    } else {
                        swal("", "Could not be added please try again", "error");
                    }
                })
            )
            .catch(err => {
                swal("", "Could not be added please try again", "error");
            });
    }
    AddUser=(event)=> {
        event.preventDefault();
            let datatosave = {
                ApplicationNo: this.state.ApplicationNo,
                Role: this.state.PanelRole,
                UserName: this.state.UserName,
            };
            fetch("/api/Panels", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "x-access-token": localStorage.getItem("token")
                },
                body: JSON.stringify(datatosave)
            })
                .then(response =>
                    response.json().then(data => {
                        if (data.success) {
                            swal("", "Added successsfuly", "success");
                            this.fetchPanels();
                          
                        } else {
                            swal("", "Could not be added please try again", "error");
                        }
                    })
                )
                .catch(err => {
                    swal("", "Could not be added please try again", "error");
                });
      
    }
    fetchPanels = () => {
        this.setState({ Panels: [] });
        fetch("/api/Panels/" + this.state.ApplicationNo + "/Panel", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(Panels => {
                if (Panels.length > 0) {
                    this.setState({ Panels: Panels });
                } else {
                    swal("", Panels.message, "error");
                }
            })
            .catch(err => {
                swal("", err.message, "error");
            });
    };
    fetchPanels1 = (ApplicationNo) => {
       
        fetch("/api/Panels/" + ApplicationNo +"/Panel", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "x-access-token": localStorage.getItem("token")
            }
        })
            .then(res => res.json())
            .then(Panels => {
                if (Panels.length > 0) {
                    this.setState({ Panels: Panels });
                } else {
                    swal("", Panels.message, "error");
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
                            this.ProtectRoute();
                            this.fetchUsers();
                            this.fetchRespondedApplications()
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
    

   
    
    switchMenu=e=>{
        this.setState({summary: false});
    }
    Removemember = (d, e) => {
        e.preventDefault();
        swal({
            text: "Are you sure that you want to remove "+d.UserName+" ?",
            icon: "warning",
            dangerMode: true,
            buttons: true
        }).then(willDelete => {
            if (willDelete) {
                return fetch("/api/Panels/" + d.UserName + "/" + this.state.ApplicationNo, {
                    method: "Delete",
                    headers: {
                        "Content-Type": "application/json",
                        "x-access-token": localStorage.getItem("token")
                    }
                })
                    .then(response =>
                        response.json().then(data => {
                            if (data.success) {
                             swal("","Removed successfully","success")
                                this.fetchPanels();
                            } else {
                                swal("", "Remove Failed", "error");
                                
                            }
                        })
                    )
                    .catch(err => {
                        swal("", "Remove Failed", "error");
                    });
            }
        });
    };
    FormPanel = k => {
        const data = {
            ApplicationNo: k.ApplicationNo,
            PanelStatus: k.PanelStatus,
          summary:true
        };

        this.setState(data);
        this.fetchApplicantDetails(k.ApplicationNo)
        var rows = [...this.state.Applications];

        const filtereddata = rows.filter(
            item => item.ApplicationNo == k.ApplicationNo
        );
        this.setState({ PEDetails: filtereddata });
        this.fetchPanels1(k.ApplicationNo)
    };
    render() {
       
       
        let FormStyle = {
            margin: "20px"
        };
      
        const Users = [...this.state.Users].map((k, i) => {
            return {
                value: k.Username,
                label: k.Name
            };
        });
        // let Applications = [...this.state.Applications].map((k,i)=>{
        //     return{
        //         value: k.ApplicationNo,
        //         label: k.ApplicationNo
        //     }
        // })
        let PanelRoles=[{
            value:"Member",
            label:"Member"
        },{
                value:"Chairperson",
                label:"Chairperson"
            }, {
                value: "Vice Chairperson",
                label: "Vice Chairperson"
            }]
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

        const rows = [...this.state.Applications];
        if (rows.length > 0) {
            rows.forEach(k => {
                const Rowdata = {
                    Name: k.ApplicationNo,
                    ProcuringEntity: k.PEName,
                    

                    action: (
                        <span>
                          
                                <a
                                  
                                    style={{ color: "#007bff" }}
                                    onClick={e => this.FormPanel(k, e)}
                                >
                                    Panel
                                 </a>
                            
                           
                         
                        </span>
                    )
                };
                Rowdata1.push(Rowdata);
            });
        }
        let Removemember = this.Removemember;
        if (this.state.summary) {
        return (
            <div>              
                    <div className="row wrapper border-bottom white-bg page-heading">
                        <div className="col-lg-10">
                            <ol className="breadcrumb">
                                <li className="breadcrumb-item">
                                <h2>Panel Formation For Application: <span style={headingstyle}>{this.state.ApplicationNo}</span> </h2>
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
                                            <div class="col-sm-2">
                                                <label
                                                    for="ApplicantID"
                                                    className="font-weight-bold "
                                                >
                                                    Application NO{" "}
                                                </label>
                                            </div>

                                            <div class="col-sm-4">
                                                <div className="form-group">
                                            <input
                                                type="text"
                                                name="ApplicationNo"
                                                disabled
                                             
                                                value={this.state.ApplicationNo}
                                                className="form-control"
                                            />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">                                  
                                    <div class="col-sm-6">
                                        <div class="col-sm-11 ">
                                                <div className="row">
                                                    <div className="col-sm-12">
                                                    <h3 style={headingstyle}>
                                                    Applicant 
                                                    </h3>
                                                    
                                                
                                                    </div>
                                                
                                                </div>
                                                <div className="row border border-success rounded">
                                            <table className="table table-borderless table-sm">
                                                {this.state.ApplicantDetails.map(
                                                    (r, i) => (
                                                        <div>
                                                            <tr>
                                                                <td className="font-weight-bold">Name:</td>
                                                                <td>{r.Name}</td>

                                                            </tr>
                                                            <tr>
                                                                <td className="font-weight-bold">Address:</td>
                                                                <td>{r.POBox + "-" + r.PostalCode + " " + r.Town}</td>

                                                            </tr>
                                                            <tr>
                                                                <td className="font-weight-bold">Email:</td>
                                                                <td>{r.Email}</td>
                                                            </tr>
                                                            <tr>

                                                                <td className="font-weight-bold">Telephone</td>
                                                                <td>{r.Mobile}</td>
                                                            </tr>
                                                        </div>
                                                    )
                                                )}
                                            </table>
                                                </div>
                                               
                                            </div>
                                            </div>
                                   
                                    <div class="col-sm-6 ">
                                        <div class="col-sm-11 ">
                                        <div className="row">
                                            <div className="col-sm-12">
                                               
                                                    
                                                   <h3 style={headingstyle}>
                                                            Procuring Entity 
                                                    </h3>
                                            </div>

                                        </div>
                                        <div className="row border border-success rounded">
                                            <table className="table table-borderless table-sm">
                                                {this.state.PEDetails.map(
                                                    (r, i) => (
                                                        <div>
                                                        <tr>
                                                                <td className="font-weight-bold">Name:</td>
                                                            <td>{r.PEName}</td>
                                                                                                                
                                                        </tr>
                                                        <tr>
                                                                <td className="font-weight-bold">Address:</td>
                                                            <td>{r.PEPOBOX + "-" + r.PEPostalCode + " " + r.PETown}</td>
                                                            
                                                        </tr>
                                                        <tr>
                                                                <td className="font-weight-bold">Email:</td>
                                                            <td>{r.PEEmail}</td>
                                                        </tr>
                                                        <tr>
                                                          
                                                                <td className="font-weight-bold">Telephone</td>
                                                            <td>{r.PETeleponde}</td>
                                                        </tr>
                                                        </div>
                                                    )
                                                )}
                                            </table>
                                        </div>
                                        </div>
                                    </div>
                                        </div>
                                      
                                      
                                        </form>
                              
                        </div>
                    </div>
                    <br/>
                    <div className="row">
                        <div className="col-lg-1"></div>
                        <div className="col-lg-10 border border-success rounded">
                            <form style={FormStyle} onSubmit={this.AddUser} >
                                <button className="btn btn-primary" type="button" onClick={this.ToggleAdd}>  {this.state.showAdd ? (<span>Close</span>):<span>Add</span>}</button>
                                {this.state.showAdd ? (
                                    <div className="row ">
                                        <div class="col-sm-2">
                                            <label
                                                for="TenderName"
                                                className="font-weight-bold"
                                            >
                                                UserName{" "}
                                            </label>
                                        </div>
                                        <div class="col-sm-4">
                                            <Select
                                                name="UserName"
                                                onChange={this.handleSelectChange}
                                                options={Users}
                                                required
                                            />
                                        </div>
                                        <div class="col-sm-1">
                                            <label for="Role" className="font-weight-bold">
                                                Role
                                            </label>
                                        </div>
                                        <div class="col-sm-4">
                                            <Select
                                                name="PanelRole"


                                                onChange={this.handleSelectChange}
                                                options={PanelRoles}
                                                required
                                            />
                                        </div>
                                        <div class="col-sm-1">
                                            <button
                                                type="submit"
                                                className="btn btn-primary float-right"
                                            >
                                                ADD
                                              </button>
                                        </div>
                                    </div>  
                                ) : null}
                              
                            
                               </form>
                            <div  className="row">
                                <table style={FormStyle} className="table table-sm">
                                    <th>#</th>
                                    <th>UserName</th>
                                    <th>Names</th>
                                    <th>Email</th>
                                    <th>Mobile No</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Action</th>


                                    {this.state.Panels.map(
                                        (r, i) => (

                                            <tr>
                                                <td>{i+1}.</td>
                                                <td>{r.UserName}</td>
                                                <td>{r.Name}</td>
                                                <td>{r.Email}</td>
                                                <td>{r.Phone}</td>
                                                <td>{r.Role}</td>
                                                <td>{r.Status}</td>
                                                <td>
                                                    <span>
                                                        <a
                                                            style={{ color: "#f44542" }}
                                                            onClick={e =>
                                                                Removemember(r, e)
                                                            }
                                                        >
                                                            &nbsp; Remove
                                            </a>
                                                    </span>
                                                </td>
                                            </tr>

                                        )
                                    )}
                                </table>
                            </div>
                            <div className="row">
                                <div class="col-sm-10"></div>
                                <div class="col-sm-2">
                                    <button
                                        type="button"
                                        className="btn btn-primary float-left "
                                        onClick={this.saveMembers}
                                    >
                                        SAVE
                                              </button>
                                            
                                    <button
                                        type="button"
                                        onClick={this.subMitPanellist}
                                        className="btn btn-success float-right "
                                    >
                                        SUBMIT
                                              </button>
                                </div>
                            </div>
<br/>
                        </div>
                    </div>
                </div>
              
            </div>
        );
     }else{
         return(
             <div>
                 <div>
                     <div className="row wrapper border-bottom white-bg page-heading">
                         <div className="col-lg-10">
                             <ol className="breadcrumb">
                                 <li className="breadcrumb-item">
                                     <h2>Panel Formation</h2>
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
         )
     }
    }
}

export default Panels;
