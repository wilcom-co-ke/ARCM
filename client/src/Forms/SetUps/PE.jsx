import React, { Component } from "react";
import swal from "sweetalert";
import Table from "./../../Table";
import TableWrapper from "./../../TableWrapper";
import Select from "react-select";
import { Progress } from "reactstrap";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import ReactExport from "react-data-export";
var dateFormat = require("dateformat");
var jsPDF = require("jspdf");
require("jspdf-autotable");
class PE extends Component {
  constructor() {
    super();
    this.state = {
      PE: [],
      Counties: [],
      privilages: [],
      PETypes: [],
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
      PIN: "",
      Companyregistrationdate: "",
      RegistrationNo: "",
      CountyCode: "",
      PEType: "",
      PETypeID: "",
      Logo: "",
      isUpdate: false,
      selectedFile: null
    };

    this.Resetsate = this.Resetsate.bind(this);
    this.handleSelectChange = this.handleSelectChange.bind(this);
    this.handleInputChange = this.handleInputChange.bind(this);
  }
  showDiv() {
    document.getElementById("nav-profile-tab").click();
  }
  handleswitchMenu = e => {
    e.preventDefault();
    if (this.state.profile === false) {
      this.setState({ profile: true });
    } else {
      this.setState({ profile: false });
    }

    //this.setnewstate();
  };
  handleSelectChange = (County, actionMeta) => {
    if (actionMeta.name == "PEType") {
      this.setState({ PETypeID: County.value });
      this.setState({ [actionMeta.name]: County.label });
    } else {
      this.setState({ CountyCode: County.value });
      this.setState({ [actionMeta.name]: County.label });
    }
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
  fetchPETypes = () => {
    fetch("/api/petypes", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(PETypes => {
        if (PETypes.length > 0) {
          this.setState({ PETypes: PETypes });
        } else {
          swal("", PETypes.message, "error");
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  fetchTown = Code => {
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
    if (name === "PostalCode") {
      this.fetchTown(value);
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
      CountyCode: "",
      PEType: "",
      PETypeID: "",
      Logo: "",
      isUpdate: false,
      PIN: "",
      Companyregistrationdate: "",
      RegistrationNo: ""
    
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
  componentWillUnmount() {}
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
              this.fetchPE();
              this.fetchCounties();
              this.fetchPETypes();
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
      PEType: this.state.PETypeID,
      Location: this.state.Location,
      POBox: this.state.POBox,
      PostalCode: this.state.PostalCode,
      Town: this.state.Town,
      Mobile: this.state.Mobile,
      Telephone: this.state.Telephone,
      Email: this.state.Email,
      Logo: this.state.Logo,
      Website: this.state.Website,
      County: this.state.CountyCode,
      Companyregistrationdate: this.state.Companyregistrationdate,
      PIN: this.state.PIN,
      RegistrationNo: this.state.RegistrationNo,
      Username: localStorage.getItem("UserName")
    };

    if (this.state.isUpdate) {
      this.UpdateData("/api/PE/" + this.state.Code, data);
    } else {
      this.postData("/api/PE", data);
    }
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
      Companyregistrationdate: dateFormat(
        new Date(pe.RegistrationDate).toLocaleDateString(),
        "isoDate"
      ),
      PIN: pe.PIN,
      RegistrationNo: pe.RegistrationNo,
      CountyCode: pe.CountyCode,
      PEType: pe.PETypeName,
      PETypeID: pe.PEType,
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
      { title: "RegistrationNo", dataKey: "RegistrationNo" },
      { title: "RegistrationDate", dataKey: "RegistrationDate" },
      { title: "PIN", dataKey: "PIN" }
    ];

    const rows = [...this.state.PE];

    var doc = new jsPDF("p", "pt", "a2", "portrait");

    doc.autoTable(columns, rows, {
      margin: { top: 60 },
      beforePageContent: function(data) {
        doc.text("ARCM PROCUREMENT ENTITIES", 40, 50);
      }
    });
    doc.save("ARCM Procurement Entities.pdf");
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
  handleDelete = k => {
    swal({
      
      text: "Are you sure that you want to delete this record?",
      icon: "warning",
      dangerMode: true,
      buttons: true,
    }).then(willDelete => {
      if (willDelete) {
        return fetch("/api/PE/" + k, {
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
              this.fetchPE();
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
          this.fetchPE();

          if (data.success) {
            swal("", "Record has been Updated!", "success");
            this.Resetsate();
            if (this.state.profile === false) {
              this.setState({ profile: true });
            } else {
              this.setState({ profile: false });
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
          this.fetchPE();

          if (data.success) {
            swal("", "Record has been saved!", "success");
            this.setState({ open: false });
            if (this.state.profile === false) {
              this.setState({ profile: true });
            } else {
              this.setState({ profile: false });
            }
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
    const PETypes = [...this.state.PETypes].map((k, i) => {
      return {
        value: k.Code,
        label: k.Description
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
        label: "Website",
        field: "Website",
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
          Website: k.Website,
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
    let formcontainerStyle = {
      border: "1px solid grey",
      "border-radius": "10px"
    };
    let FormStyle = {
      margin: "20px"
    };
    if (this.state.profile) {
      return (
        <div>
          <div>
            <div className="row wrapper border-bottom white-bg page-heading">
              <div className="col-lg-9">
                <ol className="breadcrumb">
                  <li className="breadcrumb-item">
                    <h2>Procurement Entities</h2>
                  </li>
                </ol>
              </div>
              <div className="col-lg-3">
                <div className="row wrapper ">
                  {this.validaterole("Procurement Entities", "AddNew") ? (
                    <button
                      type="button"
                      style={{ marginTop: 40 }}
                      onClick={this.handleswitchMenu}
                      className="btn btn-primary float-right fa fa-plus"
                    >
                      &nbsp; New
                    </button>
                  ) : null}
                  &nbsp;
                  {this.validaterole("Procurement Entities", "Export") ? (
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
                  {this.validaterole("Procurement Entities", "Export") ? (
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
                      <ExcelSheet data={rows} name="Procurement Entities">
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
                  <h2>Procurement Entitity</h2>
                </li>
              </ol>
            </div>
            <div className="col-lg-2">
              <div className="row wrapper ">
                <button
                  type="button"
                  style={{ marginTop: 40 }}
                  onClick={this.handleswitchMenu}
                  className="btn btn-primary"
                >
                  &nbsp; Back
                </button>
              </div>
            </div>
          </div>
          <br />
          <div style={divconatinerstyle}>
            <ToastContainer />
            <div style={formcontainerStyle}>
              <div class="col-sm-12">
                <form style={FormStyle} onSubmit={this.handleSubmit}>
                  <div class="row">
                    <div class="col-sm-1">
                      <label for="Name" className="font-weight-bold">
                        Name
                      </label>
                    </div>
                    <div class="col-sm-5">
                      <input
                        type="text"
                        class="form-control"
                        name="Name"
                        onChange={this.handleInputChange}
                        value={this.state.Name}
                        required
                      />
                    </div>
                    <div class="col-sm-1">
                      <label for="PEType" className="font-weight-bold">
                        PE Type
                      </label>
                    </div>
                    <div class="col-sm-5">
                      <Select
                        name="PEType"
                        value={PETypes.filter(
                          option => option.label === this.state.PEType
                        )}
                        onChange={this.handleSelectChange}
                        options={PETypes}
                        required
                      />
                    </div>
                  </div>
                  <br />
                  <div class="row">
                    <div class="col-sm-1">
                      <label for="PEType" className="font-weight-bold">
                        County
                      </label>
                    </div>
                    <div class="col-sm-5">
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
                    <div class="col-sm-1">
                      <label for="PEType" className="font-weight-bold">
                        Location
                      </label>
                    </div>
                    <div class="col-sm-5">
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
                  <br />

                  <div class="row">
                    <div class="col-sm-1">
                      <label for="PEType" className="font-weight-bold">
                        Email
                      </label>
                    </div>
                    <div class="col-sm-5">
                      <input
                        type="text"
                        class="form-control"
                        name="Email"
                        onChange={this.handleInputChange}
                        value={this.state.Email}
                        required
                      />
                    </div>
                    <div class="col-sm-1">
                      <label for="PEType" className="font-weight-bold">
                        Website
                      </label>
                    </div>
                    <div class="col-sm-5">
                      <input
                        type="text"
                        class="form-control"
                        name="Website"
                        onChange={this.handleInputChange}
                        value={this.state.Website}
                        
                      />
                    </div>
                  </div>
                  <br />
                  <div class="row">
                    <div class="col-sm-1">
                      <label for="PEType" className="font-weight-bold">
                        Mobile
                      </label>
                    </div>
                    <div class="col-sm-5">
                      <input
                        type="number"
                        class="form-control"
                        name="Mobile"
                        onChange={this.handleInputChange}
                        value={this.state.Mobile}
                        required
                        min="1"
                      />
                    </div>
                    <div class="col-sm-1">
                      <label for="Telephone" className="font-weight-bold">
                        Telephone
                      </label>
                    </div>
                    <div class="col-sm-5">
                      <input
                        type="number"
                        class="form-control"
                        name="Telephone"
                        onChange={this.handleInputChange}
                        value={this.state.Telephone}
                        required
                        min="1"
                      />
                    </div>
                  </div>
                  <br />
                  <div class="row">
                    <div class="col-sm-1">
                      <label for="PEType" className="font-weight-bold">
                        PO BOX
                      </label>
                    </div>
                    <div class="col-sm-5">
                      <input
                        type="text"
                        class="form-control"
                        name="POBox"
                        onChange={this.handleInputChange}
                        value={this.state.POBox}
                        required
                      />
                    </div>
                    <div class="col-sm-1">
                      <label for="PEType" className="font-weight-bold">
                        Postal Code
                      </label>
                    </div>
                    <div class="col-sm-2">
                      <input
                        type="text"
                        class="form-control"
                        name="PostalCode"
                        onChange={this.handleInputChange}
                        value={this.state.PostalCode}
                        required
                      />
                    </div>
                    <div class="col-sm-1">
                      <label for="PEType" className="font-weight-bold">
                        Town
                      </label>
                    </div>
                    <div class="col-sm-2">
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
                  <br />
                  <div class="row">
                    <div class="col-sm-1">
                      <label for="Telephone" className="font-weight-bold">
                        Registration Date
                      </label>
                    </div>
                    <div class="col-sm-5">
                      <input
                        type="date"
                        name="Companyregistrationdate"
                        required
                        defaultValue={this.state.Companyregistrationdate}
                        className="form-control"
                        onChange={this.handleInputChange}
                        id="Companyregistrationdate"
                      />
                    </div>
                    <div class="col-sm-1">
                      <label for="Telephone" className="font-weight-bold">
                        Registration No
                      </label>
                    </div>
                    <div class="col-sm-2">
                      <input
                        type="text"
                        class="form-control"
                        name="RegistrationNo"
                        onChange={this.handleInputChange}
                        value={this.state.RegistrationNo}
                        required
                      />
                    </div>
                    <div class="col-sm-1">
                      <label for="Telephone" className="font-weight-bold">
                        PIN
                      </label>
                    </div>
                    <div class="col-sm-2">
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
                  <br />
                  <div class="row">
                    <div class="col-sm-1">
                      <label for="Logo" className="font-weight-bold">
                        Logo
                      </label>
                    </div>
                    <div class="col-sm-5">
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
                          src={
                            process.env.REACT_APP_BASE_URL +
                            "/profilepics/" +
                            this.state.Logo
                          }
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
                        className="btn btn-primary float-right"
                        type="submit"
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
      );
    }
  }
}

export default PE;
