import React, { Component } from "react";
import swal from "sweetalert";
import Select from "react-select";
var dateFormat = require("dateformat");
//console.log(localStorage.getItem("CompanyData"))

class casesittingsregister extends Component {
  constructor() {
    super();
    this.state = {
      Date: dateFormat(new Date().toLocaleDateString(), "isoDate"),
      Venue: "",
      Branch: "",
      VenueID: "",
      ApplicationNo: "",
      Logo: "",
      Name: "",
      MobileNo: "",
      IdNO: "",
      Email: "",
      Category: "",
      summary: "Step 1",
      RegisterID: "",
      Applications: []
    };
    this.handlePublicself = this.handlePublicself.bind(this);
    this.handleInputChange = this.handleInputChange.bind(this);
    this.handleSelectChange = this.handleSelectChange.bind(this);
  }
  resetState() {
    let data = {
      // Date: dateFormat(new Date().toLocaleDateString(), "isoDate"),
      Venue: "",
      Branch: "",
      VenueID: "",
      ApplicationNo: "",
      Logo: "",
      Name: "",
      MobileNo: "",
      IdNO: "",
      Category: "",
      summary: "Step 1",
      RegisterID: ""
    };
    this.setState(data);
  }
  handleInputChange = event => {
    // event.preventDefault();
    // this.setState({ [event.target.name]: event.target.value });
    const target = event.target;
    const value = target.type === "checkbox" ? target.checked : target.value;
    const name = target.name;
    this.setState({ [name]: value });
  };
  handleSelfPublicSubmit = event => {
    event.preventDefault();

    const data = {
      RegisterID: this.state.RegisterID,
      Name: this.state.Name,
      IDNO: this.state.IdNO,
      MobileNo: this.state.MobileNo,
      Category: this.state.Category,
      Email: this.state.Email
    };

    this.postSelfRegistrationData(
      "/api/casesittingsregister/SelfRegistration",
      data
    );
  };
  handleSubmit = event => {
    event.preventDefault();

    const data = {
      VenueID: this.state.VenueID,
      ApplicationNo: this.state.ApplicationNo,
      Date: this.state.Date
    };

    this.postData("/api/casesittingsregister", data);
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
            this.setState({ RegisterID: data.results[0].RegisterID });
            this.setState({ summary: "Step 2" });
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  }
  postSelfRegistrationData(url = ``, data = {}) {
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
            if (data.results[0].msg === "Success") {
              swal("", "Registration successful", "success");

              this.resetState();
            } else {
              swal("", "You are already registered", "error");

              this.resetState();
            }
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  }
  fetchApplications = () => {
    fetch("/api/casesittingsregister", {
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
  handleSelectChange = (UserGroup, actionMeta) => {
    this.setState({ [actionMeta.name]: UserGroup.value });

    if (actionMeta.name === "ApplicationNo") {
      var rows = [...this.state.Applications];
      const filtereddata = rows.filter(
        item => item.ApplicationNo == UserGroup.value
      );
      this.setState({
        Date: dateFormat(new Date().toLocaleDateString(), "isoDate")
      });
      this.setState({ VenueID: filtereddata[0].VenueID });
      this.setState({ Venue: filtereddata[0].VenueName });
      this.setState({ Branch: filtereddata[0].BranchName });
    }
  };
  fetchCompanyDetails = () => {
    fetch("/api/configurations/" + 1, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(data => {
        if (data.length > 0) {
          // this.setState({ CompanyDetails: data });
          this.setState({ Logo: data[0].Logo });
          //localStorage.setItem("CompanyLogo", data[0].Logo);
        } else {
          // swal("Oops!", data.message, "error");
        }
      })
      .catch(err => {
        // swal("Oops!", err.message, "error");
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
                          this.fetchApplications();
                          this.fetchCompanyDetails();
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
  GoBack = e => {
    e.preventDefault();
    this.setState({ summary: "Step 1" });
  };
  handlePublicself = e => {
    e.preventDefault();
    this.setState({ summary: "Public" });
  };
  handlePPRA = e => {
    e.preventDefault();
    this.setState({ summary: "ppra" });
  };
  render() {
    let divconatinerstyle = {
      width: "80%",
      margin: "0 auto",
      backgroundColor: "white"
    };
    let FormStyle = {
      margin: "20px"
    };
    let formcontainerStyle = {
      border: "1px solid grey",
      "border-radius": "10px",
      width: "80%",
      margin: "0 auto"
    };
    let HeadingStyle = {
      marginLeft: "20px",
      paddingTop: "10px",
      color: "#7094db"
    };
    let photostyle = {
      height: 130,
      width: 170,
      background: "#a7b1c2",
      margin: 10,
      "border-radius": 20
    };
    const ApplicationOptions = [...this.state.Applications].map((k, i) => {
      return {
        value: k.ApplicationNo,
        label: k.ApplicationNo
      };
    });
    let CategoryOptions = [
      {
        value: "PE",
        label: "Procuring Entity"
      },
      {
        value: "Applicant",
        label: "Applicant"
      },
      {
        value: "Member of Public",
        label: "Member of Public"
      }
    ];
    let CategoryOptions1 = [
      {
        value: "PPRA",
        label: "PPRA"
      }
    ];
    if (this.state.summary === "Step 1") {
      return (
        <div>
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-12">
              <ol className="breadcrumb">
                <li className="breadcrumb-item">
                  <h2>CASE SITTING REGISTRATION</h2>
                </li>
              </ol>
            </div>
          </div>
          <br />
          <div style={divconatinerstyle}>
            <div className="text-center">
              <h2 style={HeadingStyle}>Step One</h2>
            </div>
            <div style={formcontainerStyle}>
              <form style={FormStyle} onSubmit={this.handleSubmit}>
                <br />
                <div className="row">
                  <div className="col-sm-6">
                    <label for="PEID" className="font-weight-bold">
                      Application NO{" "}
                    </label>
                    <div className="form-group">
                      <Select
                        name="ApplicationNo"
                        value={ApplicationOptions.filter(
                          option => option.label === this.state.ApplicationNo
                        )}
                        onChange={this.handleSelectChange}
                        options={ApplicationOptions}
                        required
                      />
                    </div>
                  </div>

                  <div className="col-sm-6">
                    <label for="TenderNo" className="font-weight-bold">
                      Date
                    </label>
                    <input
                      type="date"
                      name="StartDate"
                      required
                      defaultValue={this.state.Date}
                      className="form-control"
                      disabled
                    />
                  </div>
                </div>
                <div className="row">
                  <div className="col-sm-6">
                    <label for="Branch" className="font-weight-bold">
                      Branch
                    </label>
                    <input
                      type="text"
                      className="form-control"
                      name="Branch"
                      value={this.state.Branch}
                      required
                      disabled
                    />
                  </div>

                  <div className="col-sm-6">
                    <label for="Venue" className="font-weight-bold">
                      Venue{" "}
                    </label>
                    <input
                      type="text"
                      className="form-control"
                      name="Venue"
                      value={this.state.Venue}
                      required
                      disabled
                    />
                  </div>
                </div>
                <p></p>
                <div className=" row">
                  <div className="col-sm-2" />
                  <div className="col-sm-8" />
                  <div className="col-sm-2">
                    <button
                      type="submit"
                      className="btn btn-primary float-right"
                    >
                      Continue
                    </button>
                  </div>
                </div>
              </form>
            </div>
            <br />
          </div>
        </div>
      );
    }
    if (this.state.summary === "Step 2") {
      return (
        <div>
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-10">
              <ol className="breadcrumb">
                <li className="breadcrumb-item">
                  <h2>CASE SITTING RTEGISTRATION</h2>
                </li>
              </ol>
            </div>
            <div className="col-lg-2">
              <div className="row wrapper ">
                <button
                  type="button"
                  style={{ marginTop: 40 }}
                  onClick={this.GoBack}
                  className="btn btn-warning float-left"
                >
                  &nbsp; Back{" "}
                </button>
              </div>
            </div>
          </div>
          <br />
          <div style={divconatinerstyle}>
            <div className="text-center">
              <h2 style={HeadingStyle}>Step Two</h2>
            </div>
            <div style={formcontainerStyle}>
              <div className="text-center">
                <img
                  src={
                    process.env.REACT_APP_BASE_URL +
                    "/profilepics/" +
                    this.state.Logo
                  }
                  style={photostyle}
                />
                <h3>CASE NO: {this.state.ApplicationNo}</h3>
                <br />
                <h3>SELF REGISTRATION </h3>
                <br />
                <button
                  className="btn btn-success"
                  style={{ width: "270px" }}
                  onClick={this.handlePublicself}
                >
                  PE,APPELANT,MEMBERS OF PUBLIC
                </button>
                <br />
                <br />
                <br />
                <button
                  className="btn btn-success"
                  style={{ width: "270px", marginBottom: "10px" }}
                  onClick={this.handlePPRA}
                >
                  PPRA STAFF
                </button>
              </div>
              <br />
            </div>
            <br />
          </div>
        </div>
      );
    }
    if (this.state.summary === "Public") {
      return (
        <div>
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-10">
              <ol className="breadcrumb">
                <li className="breadcrumb-item">
                  <h2>CASE SITTING REGISTRATION</h2>
                </li>
              </ol>
            </div>
            <div className="col-lg-2">
              <div className="row wrapper ">
                <button
                  type="button"
                  style={{ marginTop: 40 }}
                  onClick={this.GoBack}
                  className="btn btn-warning float-left"
                >
                  &nbsp; Back{" "}
                </button>
              </div>
            </div>
          </div>
          <br />
          <div style={divconatinerstyle}>
            <div className="text-center">
              <h2 style={HeadingStyle}>Self Registration</h2>
            </div>

            <div style={formcontainerStyle}>
              <form style={FormStyle} onSubmit={this.handleSelfPublicSubmit}>
                <div className="text-center">
                  <img
                    src={
                      process.env.REACT_APP_BASE_URL +
                      "/profilepics/" +
                      this.state.Logo
                    }
                    style={photostyle}
                  />
                  <h3>CASE NO: {this.state.ApplicationNo}</h3>

                  <h3>SELF REGISTRATION </h3>
                  <h3>Date:{this.state.Date}</h3>
                </div>
                <div className="row">
                  <div className="col-sm-6">
                    <label for="PEID" className="font-weight-bold">
                      Identification NO{" "}
                    </label>
                    <div className="form-group">
                      <input
                        type="number"
                        className="form-control"
                        name="IdNO"
                        value={this.state.IdNO}
                        onChange={this.handleInputChange}
                        required
                      />
                    </div>
                  </div>

                  <div className="col-sm-6">
                    <label for="TenderNo" className="font-weight-bold">
                      Name
                    </label>
                    <input
                      type="text"
                      name="Name"
                      required
                      defaultValue={this.state.Name}
                      onChange={this.handleInputChange}
                      className="form-control"
                    />
                  </div>
                </div>
                <div className="row">
                  <div className="col-sm-6">
                    <label for="Branch" className="font-weight-bold">
                      Mobile No
                    </label>
                    <input
                      type="text"
                      className="form-control"
                      name="MobileNo"
                      value={this.state.MobileNo}
                      onChange={this.handleInputChange}
                      required
                    />
                  </div>

                  <div className="col-sm-6">
                    <label for="Venue" className="font-weight-bold">
                      Category{" "}
                    </label>
                    <Select
                      name="Category"
                      onChange={this.handleSelectChange}
                      options={CategoryOptions}
                      required
                    />
                  </div>
                </div>
                <p></p>

                <div className=" row">
                  <div className="col-sm-6">
                    <label for="Branch" className="font-weight-bold">
                      Email
                    </label>
                    <input
                      type="email"
                      className="form-control"
                      name="Email"
                      value={this.state.Email}
                      onChange={this.handleInputChange}
                      required
                    />
                  </div>
                  <div className="col-sm-4"></div>
                  <div className="col-sm-2">
                    <br/>
                    <button
                      type="submit"
                      className="btn btn-primary float-right"
                    >
                      Register
                    </button>
                  </div>
                </div>
              </form>
            </div>
            <br />
          </div>
        </div>
      );
    }
    if (this.state.summary === "ppra") {
      return (
        <div>
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-10">
              <ol className="breadcrumb">
                <li className="breadcrumb-item">
                  <h2>CASE SITTING RTEGISTRATION</h2>
                </li>
              </ol>
            </div>
            <div className="col-lg-2">
              <div className="row wrapper ">
                <button
                  type="button"
                  style={{ marginTop: 40 }}
                  onClick={this.GoBack}
                  className="btn btn-warning float-left"
                >
                  &nbsp; Back{" "}
                </button>
              </div>
            </div>
          </div>
          <br />
          <div style={divconatinerstyle}>
            <div className="text-center">
              <h2 style={HeadingStyle}>Self Registration</h2>
            </div>

            <div style={formcontainerStyle}>
              <form style={FormStyle} onSubmit={this.handleSelfPublicSubmit}>
                <div className="text-center">
                  <img
                    src={
                      process.env.REACT_APP_BASE_URL +
                      "/profilepics/" +
                      this.state.Logo
                    }
                    style={photostyle}
                  />
                  <h3>CASE NO: {this.state.ApplicationNo}</h3>

                  <h3>SELF REGISTRATION </h3>
                  <h3>Date:{this.state.Date}</h3>
                </div>
                <div className="row">
                  <div className="col-sm-6">
                    <label for="PEID" className="font-weight-bold">
                      Identification NO{" "}
                    </label>
                    <div className="form-group">
                      <input
                        type="number"
                        className="form-control"
                        name="IdNO"
                        value={this.state.IdNO}
                        onChange={this.handleInputChange}
                        required
                      />
                    </div>
                  </div>

                  <div className="col-sm-6">
                    <label for="TenderNo" className="font-weight-bold">
                      Name
                    </label>
                    <input
                      type="text"
                      name="Name"
                      required
                      defaultValue={this.state.Name}
                      onChange={this.handleInputChange}
                      className="form-control"
                    />
                  </div>
                </div>
                <div className="row">
                  <div className="col-sm-6">
                    <label for="Branch" className="font-weight-bold">
                      Mobile No
                    </label>
                    <input
                      type="text"
                      className="form-control"
                      name="MobileNo"
                      value={this.state.MobileNo}
                      onChange={this.handleInputChange}
                      required
                    />
                  </div>

                  <div className="col-sm-6">
                    <label for="Venue" className="font-weight-bold">
                      Category{" "}
                    </label>
                    <Select
                      name="Category"
                      onChange={this.handleSelectChange}
                      options={CategoryOptions1}
                      required
                    />
                  </div>
                </div>
                <p></p>
                <div className=" row">
                  <div className="col-sm-2" />
                  <div className="col-sm-8" />
                  <div className="col-sm-2">
                    <button
                      type="submit"
                      className="btn btn-primary float-right"
                    >
                      Register
                    </button>
                  </div>
                </div>
              </form>
            </div>
            <br />
          </div>
        </div>
      );
    }
  }
}

export default casesittingsregister;
