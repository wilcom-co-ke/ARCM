import React, { Component } from "react";
import swal from "sweetalert";
import "react-toastify/dist/ReactToastify.css";
import { Link } from "react-router-dom";
import Select from "react-select";
import CKEditor from "ckeditor4-react";
import axios from "axios";
import { Progress } from "reactstrap";
import { ToastContainer, toast } from "react-toastify";
import ReactHtmlParser from "react-html-parser";

class PEResponse extends Component {
  constructor(props) {
    super(props);
    this.state = {
      ApplicationGrounds: [],
      ResponseDocuments: [],
      ApplicationNo: this.props.location.ApplicationNo,
      ApplicationID: this.props.location.ApplicationID,
      NewDeadLine: "",
      Reason: "",
      GroundResponse: "",
      GroundNo: "",
      selectedFile: "",
      loaded: 0,
      ResponseID: "",
      grounddesc: "",
      showAction: true,
      Action: "",
      InitialSubmision: true
    };
    this.onEditorChange = this.onEditorChange.bind(this);
    this.SavePEResponse = this.SavePEResponse.bind(this);
    this.handleSelectChange = this.handleSelectChange.bind(this);
    this.onDeadlineEditorChange = this.onDeadlineEditorChange.bind(this);
  }
  fetchResponseDocuments = () => {
    fetch("/api/PEResponse/Documents/" + this.state.ResponseID, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(ResponseDocuments => {
        if (ResponseDocuments.length > 0) {
          this.setState({ ResponseDocuments: ResponseDocuments });
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  fetchApplicationGrounds = () => {
    fetch("/api/grounds/GroundsOnly/" + this.state.ApplicationNo, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(ApplicationGrounds => {
        if (ApplicationGrounds.length > 0) {
          this.setState({ ApplicationGrounds: ApplicationGrounds });
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  openAttachmentsTab() {
    document.getElementById("nav-profile-tab").click();
  }
  onDeadlineEditorChange(evt) {
    this.setState({
      Reason: evt.editor.getData()
    });
  }
  onEditorChange(evt) {
    this.setState({
      GroundResponse: evt.editor.getData()
    });
  }
  handleSelectChange = (UserGroup, actionMeta) => {
    this.setState({ [actionMeta.name]: UserGroup.value });
    if (actionMeta.name === "GroundNo") {
      const filtereddata = this.state.ApplicationGrounds.filter(
        item => item.GroundNO == UserGroup.value
      );

      if (filtereddata.length > 0) {
        this.setState({ grounddesc: filtereddata[0].Description });
      } else {
        this.setState({ grounddesc: "No description given." });
      }
    }
    this.setState({ showAction: false });
  };
  SaveNoObjectionResponse = event => {
    event.preventDefault();
    const data = {
      ApplicationNo: this.state.ApplicationNo,
      ResponseType: this.state.Action,
      UserID: localStorage.getItem("UserName")
    };
    if (this.state.InitialSubmision) {
      this.SavePEResponse("/api/PEResponse/", data);
    } else {
      this.SavePEResponseDetails(this.state.ResponseID);
    }
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
      .then(response => response.json().then(data => {}))
      .catch(err => {
        //swal("Oops!", err.message, "error");
      });
  };
  handleSubmitDeadlinerequest = event => {
    event.preventDefault();
    const data = {
      Newdate: this.state.NewDeadLine,
      ApplicationNo: this.state.ApplicationNo,
      Reason: this.state.Reason,
      UserID: localStorage.getItem("UserName")
    };
    fetch("/api/PEResponse/DeadlineExtension", {
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
            swal("", "Request Submited", "success");
            let AproverEmail = data.results[0].Email;
            let AproverMobile = data.results[0].Phone;
            let Name = data.results[0].Name;
            this.SendSMS(
              AproverMobile,
              "New deadline extension request has been submited and it's awaiting your review."
            );
            this.SendMail(
              Name,
              AproverEmail,
              "DeadlineExtension",
              "REQUEST FOR DEADLINE EXTENSION",
              "ApplicationNo"
            );
            window.location = "#/PEApplications";
          } else {
            swal("", data.message, "error");
          }
        })
      )
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
    this.setState({ [name]: value });
  };
  SavePEResponseDetails(ResponseID) {
    const data = {
      PERsponseID: ResponseID,
      GrounNo: this.state.GroundNo,
      Groundtype: "Grounds for Appeal",
      Response: this.state.GroundResponse,
      UserID: localStorage.getItem("UserName")
    };
    fetch("/api/PEResponse/Details", {
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
            swal("", "Your Response has been added!", "success");
            this.setState({ GroundResponse:" "})
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("Oops!", err.message, "error");
      });
  }
  SavePEResponse(url = ``, data = {}) {
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
            if (data.ResponseID[0].msg === "Already Responded") {
              swal(
                "",
                "You have already submited a response for this application.You can view it on Response menu.",
                "error"
              );
            } else {
              this.setState({ ResponseID: data.ResponseID[0].ID });
              this.setState({ InitialSubmision: false });

              this.SavePEResponseDetails(data.ResponseID[0].ID);
            }
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("Oops!", err.message, "error");
      });
  }
  fetchApplicationfees = Applicationno => {
    fetch("/api/applicationfees/" + Applicationno, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(Applicationfees => {
        if (Applicationfees.length > 0) {
          this.setState({ Applicationfees: [] });
          this.setState({ Applicationfees: Applicationfees });
          this.setState({ TotalAmountdue: Applicationfees[0].total });
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
              this.fetchApplicationGrounds();
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
  checkMimeType = event => {
    let files = event.target.files;
    let err = []; // create empty array
    const types = ["application/pdf"];
    for (var x = 0; x < files.length; x++) {
      if (types.every(type => files[x].type !== type)) {
        err[x] =
          files[x].type +
          " is not a supported format.Pfd files only are allowed\n";
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
    let size = 200000000;
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
  SavePEResponseDocuments(Documentname) {
    const data = {
      PERsponseID: this.state.ResponseID,
      Name: Documentname,
      Description: this.state.DocumentDesc,
      Path: "Documents"
    };
    fetch("/api/PEResponse/Documents", {
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
            this.fetchResponseDocuments();
            swal("", "Document uploaded!", "success");
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("Oops!", err.message, "error");
      });
  }
  handleDocumentSubmit = event => {
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
          this.SavePEResponseDocuments(res.data);
          // this.setState({
          //     Logo: res.data
          // });
          // localStorage.setItem("UserPhoto", res.data);
        })
        .catch(err => {
          toast.error("upload fail");
        });
    } else {
      toast.warn("Please select a file to upload");
    }
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
  CompleteSubmision = event => {
    event.preventDefault();
    const data = {
      PEResponseID: this.state.ResponseID,
      ApplicationNo: this.state.ApplicationNo,
      UserID: localStorage.getItem("UserName")
    };
    fetch("/api/PEResponse/SubmitResponse/1", {
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
            let NewList = [data.results];

            if (NewList.length > 0) {
              NewList[0].map((item, key) => {
                if (item.Role === "Case officer") {
                  let smstext =
                    "Dear " +
                    item.Name +
                    ".PE has submited a response for Application" +
                    this.state.ApplicationNo +
                    ".You are required to form a panel and submit it for review.";
                  this.SendSMS(item.Mobile, smstext);
                  this.SendMail(
                    item.Name,
                    item.Email,
                    "PEresponseCaseOfficer",
                    "PE RESPONSE",
                    this.state.ApplicationNo
                  );
                } else if (item.Role === "PE") {
                  let smstext =
                    "Dear " +
                    item.Name +
                    ".Your response for Application" +
                    this.state.ApplicationNo +
                    "has been received.You will be notified when hearing date will be set.";
                  this.SendSMS(item.Mobile, smstext);
                  this.SendMail(
                    item.Name,
                    item.Email,
                    "PEresponsePE",
                    "PE RESPONSE",
                    this.state.ApplicationNo
                  );
                } else {
                  let smstext =
                    "Dear " +
                    item.Name +
                    ".A response for Application" +
                    this.state.ApplicationNo +
                    "has been sent by the Procuring Entity.";
                  this.SendSMS(item.Mobile, smstext);
                  this.SendMail(
                    item.Name,
                    item.Email,
                    "PEresponseOthers",
                    "PE RESPONSE",
                    this.state.ApplicationNo
                  );
                }
              });
            }
            swal("", "Your Response has been submited!", "success");
            // send email and sms to ppra
            //and redirect to response
            window.location = "#/MyResponse";
          } else {
            swal("", "Your response could not be submited!", "error");
          }
        })
      )
      .catch(err => {
        swal("Oops!", err.message, "error");
      });
  };
  render() {
    let headingstyle = {
      color: "#7094db"
    };
    let divstyle = {
      margin: "50",

      "padding-left": 40,
      "padding-right": 40,
      "padding-top": 20
    };
    let formcontainerStyle = {
      border: "1px solid grey",
      "border-radius": "10px",
      background: "white"
    };
    let FormStyle = {
      margin: "20px"
    };
    let childdiv = {
      margin: "30px"
    };

    let photostyle1 = {
      height: 150,
      width: 200
    };

    let Grounds = [...this.state.ApplicationGrounds].map((k, i) => {
      return {
        value: k.GroundNO,
        label: k.GroundNO
      };
    });

    let Actions = [
      {
        value: "No Objection",
        label: "No Objection"
      },
      {
        value: "Preliminary Objection",
        label: "Preliminary Objection"
      },
      {
        value: "Request Extension of deadline",
        label: "Request Extension of deadline"
      }
    ];
    return (
      <div>
        <div className="row wrapper border-bottom white-bg page-heading">
          <div className="col-lg-10">
            <ol className="breadcrumb">
              <li className="breadcrumb-item">
                <h2 className="font-weight-bold">
                  APPLICATION NO: {this.state.ApplicationNo}
                </h2>
              </li>
            </ol>
          </div>
          <div className="col-lg-2">
            <div className="row wrapper ">
              <Link to="/PEApplications">
                <button
                  type="button"
                  style={{ marginTop: 40 }}
                  className="btn btn-primary float-left"
                >
                  &nbsp; Back
                </button>
              </Link>
            </div>
          </div>
        </div>
        <p></p>

        <div className="row">
          <div className="col-lg-1"></div>
          <div className="col-lg-10 ">
            <h3 style={headingstyle}>
              Respond to ApplicationNo:{this.state.ApplicationNo}{" "}
            </h3>
            <div className="col-lg-12 ">
              <div style={formcontainerStyle}>
                {this.state.showAction ? (
                  <form style={divstyle}>
                    <div class="row">
                      <div class="col-sm-6">
                        <label for="Location" className="font-weight-bold">
                          Select Action
                        </label>

                        <Select
                          name="Action"
                          // value={Counties.filter(
                          //     option =>
                          //         option.label === this.state.County
                          // )}
                          onChange={this.handleSelectChange}
                          options={Actions}
                          required
                        />
                      </div>
                    </div>
                    <br />
                  </form>
                ) : null}
                <br />
                {this.state.Action === "Request Extension of deadline" ? (
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
                          Response{" "}
                        </a>
                      </div>
                    </nav>

                    <div class="tab-content " id="nav-tabContent">
                      <div
                        class="tab-pane fade show active"
                        id="nav-home"
                        role="tabpanel"
                        aria-labelledby="nav-home-tab"
                        style={childdiv}
                      >
                        {/* <form style={FormStyle} onSubmit={this.SaveTenders}> */}
                        <div style={formcontainerStyle}>
                          <form
                            style={divstyle}
                            onSubmit={this.handleSubmitDeadlinerequest}
                          >
                            <div classname="row">
                              <div class="col-sm-6">
                                <label
                                  for="Location"
                                  className="font-weight-bold"
                                >
                                  Requested Deadline
                                </label>

                                <input
                                  type="date"
                                  name="NewDeadLine"
                                  required
                                  defaultValue={this.state.NewDeadLine}
                                  className="form-control"
                                  onChange={this.handleInputChange}
                                />
                              </div>
                            </div>
                            <br />
                            <div classname="row">
                              <div class="col-sm-12">
                                <label for="Name" className="font-weight-bold">
                                  Reason
                                </label>
                                <CKEditor
                                  onChange={this.onDeadlineEditorChange}
                                />
                              </div>
                            </div>
                            <br />
                            <div class="row">
                              <div className="col-sm-11"></div>
                              <div className="col-sm-1">
                                <button
                                  className="btn btn-primary"
                                  type="submit"
                                >
                                  Submit
                                </button>
                              </div>
                            </div>
                          </form>
                          <br />
                        </div>
                      </div>
                    </div>
                  </div>
                ) : null}
                {this.state.Action === "No Objection" ? (
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
                          Response{" "}
                        </a>
                        <a
                          class="nav-item nav-link font-weight-bold"
                          id="nav-profile-tab"
                          data-toggle="tab"
                          href="#nav-profile"
                          role="tab"
                          aria-controls="nav-profile"
                          aria-selected="false"
                        >
                          Attachements
                        </a>
                      </div>
                    </nav>

                    <div class="tab-content " id="nav-tabContent">
                      <div
                        class="tab-pane fade show active"
                        id="nav-home"
                        role="tabpanel"
                        aria-labelledby="nav-home-tab"
                        style={childdiv}
                      >
                        {/* <form style={FormStyle} onSubmit={this.SaveTenders}> */}
                        <div style={formcontainerStyle}>
                          <form
                            style={FormStyle}
                            onSubmit={this.SaveNoObjectionResponse}
                          >
                            <div class="row">
                              <div class="col-sm-2">
                                <label
                                  style={headingstyle}
                                  for="Location"
                                  className="font-weight-bold"
                                >
                                  Select Ground
                                </label>

                                <Select
                                  name="GroundNo"
                                  // value={Counties.filter(
                                  //     option =>
                                  //         option.label === this.state.County
                                  // )}
                                  onChange={this.handleSelectChange}
                                  options={Grounds}
                                  required
                                />
                              </div>
                            </div>
                            <br />
                            <div class="row">
                              <div class="col-sm-12">
                                <h3 style={headingstyle}>Ground Description</h3>
                                <br />
                                {ReactHtmlParser(this.state.grounddesc)}
                              </div>
                            </div>
                            <br />
                            <div class="row">
                              <div class="col-sm-12">
                                <h3 style={headingstyle}>Your Response</h3>
                                <br />
                                <CKEditor data={this.state.GroundResponse} onChange={this.onEditorChange} />
                              </div>
                            </div>
                            <br />
                            <div className=" row">
                              <div className="col-sm-2" />
                              <div className="col-sm-8" />
                              <div className="col-sm-1">
                                <button
                                  type="submit"
                                  className="btn btn-primary float-right"
                                >
                                  Add
                                </button>
                              </div>
                              <div className="col-sm-1">
                                {this.state.AddAdedendums ? null : (
                                  <button
                                    type="button"
                                    onClick={this.openAttachmentsTab}
                                    className="btn btn-primary float-left"
                                  >
                                    {" "}
                                    Next
                                  </button>
                                )}
                              </div>
                            </div>
                          </form>
                        </div>
                      </div>
                      <div
                        class="tab-pane fade"
                        id="nav-profile"
                        role="tabpanel"
                        style={childdiv}
                        aria-labelledby="nav-profile-tab"
                      >
                        <div style={formcontainerStyle}>
                          <ToastContainer />
                          <form
                            style={FormStyle}
                            onSubmit={this.handleDocumentSubmit}
                          >
                            <div class="row">
                              <div class="col-sm-6">
                                <label
                                  for="Document"
                                  className="font-weight-bold"
                                >
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
                                  type="submit"
                                  class="btn btn-success "
                                  // onClick={this.onClickHandler}
                                >
                                  Upload
                                </button>{" "}
                              </div>
                              <div class="col-sm-6">
                                <label
                                  for="Document"
                                  className="font-weight-bold"
                                >
                                  Description
                                </label>
                                <input
                                  type="text"
                                  className="form-control"
                                  name="DocumentDesc"
                                  onChange={this.handleInputChange}
                                  value={this.state.DocumentDesc}
                                  required
                                />
                              </div>
                            </div>
                            <br />
                            <div className="row">
                              <table className="table table-sm">
                                <th>#</th>
                                <th>Document Description</th>
                                <th>FileName</th>

                                {this.state.ResponseDocuments.map(function(
                                  k,
                                  i
                                ) {
                                  return (
                                    <tr>
                                      <td>{i + 1}</td>
                                      <td>{k.Description}</td>
                                      <td>{k.Name}</td>
                                    </tr>
                                  );
                                })}
                              </table>
                            </div>
                            <br />
                            <div className=" row">
                              <div className="col-sm-10" />

                              <div className="col-sm-2">
                                <button
                                  type="button"
                                  onClick={this.CompleteSubmision}
                                  className="btn btn-primary float-left"
                                >
                                  {" "}
                                  SUBMIT NOW
                                </button>
                              </div>
                            </div>
                          </form>
                        </div>
                      </div>
                    </div>
                  </div>
                ) : null}

                {this.state.Action === "Preliminary Objection" ? (
                  <div class="col-sm-12">
                    <h3 style={headingstyle}>Fees Description</h3>

                    <div className="col-lg-10 border border-success rounded">
                      <div className="row"></div>
                      <br />
                      <div className="row">
                        <table class="table table-sm">
                          <thead>
                            <tr>
                              <th scope="col">#</th>
                              <th scope="col">Fees description</th>
                              <th scope="col">Value</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td>1</td>
                              <td>Fees Description</td>
                              <td className="font-weight-bold">
                                {this.formatNumber(5000)}
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                    <br />
                    <h3 style={headingstyle}>payment options</h3>
                    <div className="col-lg-10 border border-success rounded">
                      <div className="row"></div>
                      <br />
                      <div className="row">
                        <div className="col-lg-1"></div>
                        <h3 style={headingstyle}>
                          REFFERENCE NUMBER: &nbsp;
                          <span className="font-weight-bold text-danger">
                            {this.state.ApplicationNo}
                          </span>{" "}
                          <span className="font-weight-bold text-warning">
                            &nbsp;&nbsp;&nbsp; Quote this Reference Number when
                            making payment.
                          </span>
                        </h3>
                      </div>
                      <br />

                      <div className="row">
                        <div className="col-lg-1"></div>
                        <h3 style={headingstyle}>
                          {" "}
                          &nbsp; &nbsp; &nbsp;Select Payment Mode{" "}
                        </h3>
                      </div>
                      <div className="row">
                        <div className="col-lg-1"></div>
                        <div className="col-lg-2">
                          <img
                            style={photostyle1}
                            src={
                              process.env.REACT_APP_BASE_URL +
                              "/images/bank.jpg"
                            }
                            alt=""
                          />
                        </div>
                        <div className="col-lg-2">
                          <img
                            style={photostyle1}
                            src={
                              process.env.REACT_APP_BASE_URL +
                              "/images/mpesa.jpg"
                            }
                            alt=""
                          />
                        </div>
                        <div className="col-lg-2">
                          <img
                            style={photostyle1}
                            src={
                              process.env.REACT_APP_BASE_URL +
                              "/images/card.jpg"
                            }
                            alt=""
                          />
                        </div>
                        <div className="col-lg-4"></div>
                      </div>
                      <br />
                    </div>
                  </div>
                ) : null}
                <br />
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default PEResponse;
