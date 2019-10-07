import React, { Component } from "react";
import swal from "sweetalert";
import { Progress } from "reactstrap";
import Select from "react-select";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { Link } from "react-router-dom";
class createacc extends Component {
    constructor() {
        super();
        this.state = {
            PE: [],
            Counties: [],
            privilages: [],
            Towns: [],         
            PIN:"",
            RegistrationNo:"",
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
            Logo: "",
            isUpdate: false,
            selectedFile: null,
            redirect: false,
            LoginName:"",
            LoginUsername:"",
            LoginEmail:"",
            LoginPhone:"",
            LoginPassword:"",
            LoginCategory:"",
            IDnumber:"",
            Gender:"",
            DOB:"",
            Companyregistrationdate:"",
            Procuringentity:""
            
        };
              this.handleInputChange = this.handleInputChange.bind(this);
    }
    fetchPE = () => {
        fetch("/api/PE", {
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
    setRedirect = () => {
        this.setState({
            redirect: true
        });
    };
    showApplicatntDiv() {        
        document.getElementById("nav-home-tab").click();
    }
    handleSelectChange = (County, actionMeta) => {
        this.setState({ [actionMeta.name]: County.value });

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
                    swal("Oops!", Counties.message, "error");
                }
            })
            .catch(err => {
                swal("Oops!", err.message, "error");
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
                swal("Oops!", err.message, "error");
            });
    };

    handleInputChange = event => {
        // event.preventDefault();
        // this.setState({ [event.target.name]: event.target.value });
        const target = event.target;
        const value = target.type === "checkbox" ? target.checked : target.value;
        const name = target.name;

        if (name === "PostalCode") {
            this.fetchTown(value)
        }
        this.setState({ [name]: value });
    };
   
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
    componentDidMount() {
        this.fetchCounties();
        this.fetchPE()
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
            County: this.state.County,
            UserName: this.state.LoginUsername,
            Companyregistrationdate: this.state.Companyregistrationdate,
            PIN: this.state.PIN,
            RegistrationNo: this.state.RegistrationNo
        };     
               
        if (this.state.LoginCategory ==="Applicant"){
            this.postData("/api/applicants", data);  
        }  else{
            if (this.state.Procuringentity){
                let data1 = {
                    Procuringentity: this.state.Procuringentity,
                    UserName: this.state.LoginUsername
                }

                this.postPEUsers("/api/PEUsers", data1); 
            }else{

                swal("", "Select Institution", "error");
            }
            
        }
    };
    postPEUsers(url = ``, data = {}) {
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
                        swal("Saved!", "Registration has been Successful! please check you email to get your verification code", "success");
                        setTimeout(function () {

                        }, 7000);
                        this.setRedirect();

                    } else {
                        swal("", data.message, "error");
                    }
                })
            )
            .catch(err => {
                swal("Oops!", err.message, "error");
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
                        swal("Saved!", "Registration has been Successful! please check you email to get your verification code", "success");
                        setTimeout(function () {
                           
                        }, 7000);
                           this.setRedirect();
                       
                    } else {
                        swal("Saved!", data.message, "error");
                    }
                })
            )
            .catch(err => {
                swal("Oops!", err.message, "error");
            });
    }
    handleLoginSubmit = event => {
        event.preventDefault();
             const data = {
            Name: this.state.LoginName,
            Username: this.state.LoginUsername,
            Email: this.state.LoginEmail,
            Phone: this.state.LoginPhone,
            Password: this.state.LoginPassword,
            Category: this.state.LoginCategory,
           IDnumber: this.state.IDnumber,
           Gender: this.state.Gender,
           DOB: this.state.DOB,
        };
        if (this.state.LoginPassword == this.state.ConfirmPassword) {
            this.postloginData("/api/Signup", data);
        } else {
            this.setState({ msg: "Password and Confirm password do not match" });
        }
    };
   
    postloginData(url = ``, data = {}) {
        fetch(url, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
            .then(response =>
                response.json().then(data => {
                    if (data.success) {
                        localStorage.setItem("Unverifiedusername", this.state.LoginUsername);                       
                        this.showApplicatntDiv();
                        this.SendMail(data.activationCode);
                      
                    } else {
                        swal("Saved!", data.message, "error");
                    }
                })
            )
            .catch(err => {
                swal("Oops!", err.message, "error");
            });
    }
    SendMail(activationCode) {
        const emaildata = {
            to: this.state.LoginEmail,
            subject: "EMAIL ACTIVATION",
            name: this.state.Name,
            activationCode: activationCode,
           category:"Registration"
        };
        fetch("/api/sendMail/CreatAccount", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(emaildata)
        })
            .then(response =>
                response.json().then(data => {
                    if (data.success) {
                    } else {
                        //swal("Saved!", data.message, "error");
                    }
                })
            )
            .catch(err => {
                //swal("Oops!", err.message, "error");
            });
    }
    render() {

        const Counties = [...this.state.Counties].map((k, i) => {
            return {
                value: k.Code,
                label: k.Name
            };
        });
        let GenderCategories=[
            {value:"Male",
            label:"Male"},        
            {value: "Female",
            label: "Female"}      
        ]
        let Signstyle = {
            height: 100,
            width: 150
        };
        let divconatinerstyle = {
            "margin-top":"30px",
            "padding-top":"50px",
            width: "95%",
            margin: "0 auto",
            // 
        };
        let childdiv = {
            margin: "30px"
        };
        let pstyle = {
            color: "red"
        };
        let Categories = [
            { value: "Applicant", label: "Applicant" },
            {
                value: "PE",
                label: "Procuring Entity"
            }
        ];
        let rowstyle={
            backgroundColor: "white"
        }
        const PE = [...this.state.PE].map((k, i) => {
            return {
                value: k.PEID,
                label: k.Name
            };
        });
        if (this.state.redirect) {
            return (window.location = "#/EmailVerification");
        }
            return (
                <div className="container">
                
                    <div style={divconatinerstyle}>
                        <ToastContainer />
                        <div style={rowstyle} className="row">
                            <div class="col-sm-12">
                                <nav>
                                    <div class="nav nav-tabs " id="nav-tab" role="tablist">
                                        <a
                                            class="nav-item nav-link active font-weight-bold"
                                            id="nav-login-tab"
                                            data-toggle="tab"
                                            href="#nav-login"
                                            role="tab"
                                            aria-controls="nav-login"
                                            aria-selected="true"
                                        >User Details</a>
                                        <a
                                            class="nav-item nav-link  font-weight-bold"
                                            id="nav-home-tab"
                                            data-toggle="tab"
                                            href="#nav-home"
                                            role="tab"
                                            aria-controls="nav-home"
                                            aria-selected="true"
                                        >Organization Details</a>
                           
                                    </div>
                                </nav>
                                <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                                    <div class="tab-pane fade show active"
                                        id="nav-login"
                                        role="tabpanel"
                                        aria-labelledby="nav-login-tab">
                                        <form  onSubmit={this.handleLoginSubmit}>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Name" className="font-weight-bold">
                                                        FullName                  </label>
                                                    <input
                                                        type="text"
                                                        className="form-control"
                                                        name="LoginName"
                                                        id="LoginName"
                                                        required
                                                        onChange={this.handleInputChange}
                                                        value={this.state.LoginName}
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="Username" className="font-weight-bold">
                                                        Username                  </label>
                                                    <input
                                                        type="text"
                                                        className="form-control"
                                                        name="LoginUsername"
                                                        id="LoginUsername"
                                                        required
                                                        onChange={this.handleInputChange}
                                                        value={this.state.LoginUsername}
                                                        
                                                    />
                                                </div>
                                                </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Name" className="font-weight-bold">
                                                        Email                  </label>
                                                    <input
                                                        type="email"
                                                        className="form-control"
                                                        name="LoginEmail"
                                                        id="LoginEmail"
                                                        required
                                                        onChange={this.handleInputChange}
                                                        value={this.state.LoginEmail}
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="Name" className="font-weight-bold">
                                                        Category                  </label>
                                                    <Select
                                                        name="LoginCategory"
                                                        //value={this.state.LoginCategory}
                                                        onChange={this.handleSelectChange}
                                                        options={Categories}
                                                        required
                                                    />
                                                </div>
                                             
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Username" className="font-weight-bold">
                                                        ID Number                  </label>
                                                    <input
                                                        type="number"
                                                        className="form-control"
                                                        name="IDnumber"
                                                        id="IDnumber"
                                                        required
                                                        onChange={this.handleInputChange}
                                                        value={this.state.IDnumber}
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="Username" className="font-weight-bold">
                                                        DOB                  </label>
                                                    <input
                                                        type="date"
                                                        name="DOB"
                                                        required
                                                        
                                                        className="form-control"
                                                        onChange={this.handleInputChange}
                                                        id="DOB"
                                                      
                                                    />
                                                </div>
                                             
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Username" className="font-weight-bold">
                                                        Phone                  </label>
                                                    <input
                                                        type="number"
                                                        className="form-control"
                                                        name="LoginPhone"
                                                        id="LoginPhone"
                                                        required
                                                        onChange={this.handleInputChange}
                                                        value={this.state.LoginPhone}
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="Username" className="font-weight-bold">
                                                        Gender                  </label>
                                                    <Select

                                                        name="Gender"
                                                        //value={this.state.LoginCategory}
                                                        onChange={this.handleSelectChange}
                                                        options={GenderCategories}
                                                        required
                                                    />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Name" className="font-weight-bold">
                                                        Confirm password                  </label>
                                                    <input
                                                        type="password"
                                                        className="form-control"
                                                        name="ConfirmPassword"
                                                        id="ConfirmPassword"
                                                        required
                                                        onChange={this.handleInputChange}
                                                        value={this.state.ConfirmPassword}
                                                    />
                                                </div>
                                                <div class="col-sm-6">
                                                    <label for="Username" className="font-weight-bold">
                                                        Password                  </label>
                                                    <input
                                                        type="password"
                                                        className="form-control"
                                                        name="LoginPassword"
                                                        id="LoginPassword"
                                                        required
                                                        onChange={this.handleInputChange}
                                                        value={this.state.LoginPassword}
                                                    />
                                                </div>

                                             
                                               
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6"></div>
                                                <div class="col-sm-6">
                                                    <br />
                                                    <button
                                                        className="btn btn-lg btn-primary  text-uppercase float-right"
                                                        type="submit"
                                                    >  Next</button>
                                                </div>
                                            </div>
                                          
                                        </form>
                                        <p></p>
                                        <div className="row">
                                            <div className="card-footer col-sm-12">
                                                <div className="d-flex justify-content-center links">
                                                   Already have an account?{" "}
                                                    <Link to="/login">Login</Link>
                                                </div>
                                               
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="tab-pane fade "
                                        id="nav-home"
                                        role="tabpanel"
                                        aria-labelledby="nav-home-tab"
                                        style={childdiv}
                                    >
                                        {this.state.LoginCategory === "Applicant" ? (
                                            
                                        <form onSubmit={this.handleSubmit}>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Name" className="font-weight-bold">
                                                        Name                  </label>
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
                                                        County</label>

                                                    <Select
                                                        name="County"
                                                        //value={this.state.County}
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
                                                        PO BOX        </label>

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
                                                <div class="col-sm-3">
                                                    <label for="Mobile" className="font-weight-bold">
                                                        Mobile  </label>
                                                    <input
                                                        type="number"
                                                        class="form-control"
                                                        name="Mobile"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.Mobile}
                                                        required
                                                    />
                                                </div>
                                                <div class="col-sm-3">
                                                    <label for="Telephone" className="font-weight-bold">
                                                        Telephone </label>
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
                                                    <label for="Website" className="font-weight-bold">
                                                        Website </label>
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
                                                <div class="col-sm-3">
                                                    <label for="Telephone" className="font-weight-bold">
                                                        Registration No </label>
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="RegistrationNo"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.RegistrationNo}
                                                        required
                                                    />
                                                </div>
                                                <div class="col-sm-3">
                                                    <label for="Telephone" className="font-weight-bold">
                                                        PIN </label>
                                                    <input
                                                        type="text"
                                                        class="form-control"
                                                        name="PIN"
                                                        onChange={this.handleInputChange}
                                                        value={this.state.PIN}
                                                        required
                                                    />
                                                </div>
                                               
                                                <div class="col-sm-6">
                                                    <label for="Companyregistrationdate" className="font-weight-bold">
                                                        Registration Date                  </label>
                                                    <input
                                                        type="date"
                                                        name="Companyregistrationdate"
                                                        required
                                                        className="form-control"
                                                        onChange={this.handleInputChange}
                                                        id="Companyregistrationdate"

                                                    />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label for="Logo" className="font-weight-bold">
                                                        Logo       </label>
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
                                           
                                        ) : <form onSubmit={this.handleSubmit}>
                                                <div class="row">
                                                   
                                                    <div class="col-sm-6">
                                                        <label for="Username" className="font-weight-bold">
                                                            Select Institution </label>
                                                        <Select

                                                            name="Procuringentity"
                                                            
                                                            onChange={this.handleSelectChange}
                                                            options={PE}
                                                            required
                                                        />
                                                    </div>
                                                </div>
                                                <br/>
                                                <div className=" row">
                                                    <div className="col-sm-1">
                                                        <button
                                                            type="submit"
                                                            className="btn btn-primary float-right"
                                                        >
                                                            Save
                                                </button>
                                                    </div>
                                                    <div className="col-sm-3" />
                                                    <div className="col-sm-8" />
                                                   
                                                </div>
                                        </form>}
                                        <p></p>
                                        <div className="row">
                                            <div className="card-footer col-sm-12">
                                                <div className="d-flex justify-content-center links">
                                                    Already have an account?{" "}
                                                    <Link to="/login">Login</Link>
                                                </div>

                                            </div>
                                        </div>
                                       
                                    </div>
                                 
                                </div>
                            </div>
                        </div>
                      
                    </div>
                </div>
            );
        
    }
}

export default createacc;
