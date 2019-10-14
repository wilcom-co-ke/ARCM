import React, { Component } from "react";
import swal from "sweetalert";
import Table from "./../../Table";
import TableWrapper from "./../../TableWrapper";
import Select from "react-select";
import axios from "axios";
import { Progress } from "reactstrap";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { Link } from "react-router-dom";
import Popup from "reactjs-popup";
import popup from "./../../Styles/popup.css";
import "./../../Styles/tablestyle.css";
import CKEditor from "ckeditor4-react";
import ReactHtmlParser from "react-html-parser";
let userdateils = localStorage.getItem("UserData");
let data = JSON.parse(userdateils);
var dateFormat = require("dateformat");
class Applications extends Component {
  constructor() {
    super();
    this.state = {
      open: false,
      openRequest: false,
      ApplicantEmail: data.Email,
      ApplicantPhone: data.Phone,
      Applications: [],
      PE: [],
      Today: dateFormat(
        new Date().toLocaleDateString(),
        "isoDate"
      ),
      TenderNo: "",
      TenderID: "",
      TenderValue: "",
      ApplicationID: "",
      TenderName: "",
      PEID: "",
      StartDate: "",
      ClosingDate: "",
      ApplicationREf: "",
      ApplicantID: "",
      AdendumDescription: "",
      EntryType: "",
      RequestDescription: "",
      GroundDescription: "",
      profile: true,
      summary: false,
      IsUpdate: false,

      selectedFile: null,
      loaded: 0,
      DocumentDescription: "",
      AddedAdendums: [],
      AdendumStartDate: "",
      RequestsAvailable: false,
      GroundsAvailable: false,
      AdendumsAvailable: false,
      AdendumClosingDate: "",
      AdendumNo: "",
      AddAdedendums: false,
      ApplicantDetails: [],
      Applicantname: "",
      ApplicationGrounds: [],
      ApplicationDocuments: [],
      Applicationfees: [],
      FilingDate: "",
      PEName: "",
      ApplicationNo: "",
      openView: false,
      DocumentsAvailable: false,
      GroundNO: "",

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

      ApplicantPostalCode: "",
      ApplicantPOBox: "",
      ApplicantTown: "",

      alert: null
    };
    this.handViewApplication = this.handViewApplication.bind(this);
    this.Resetsate = this.Resetsate.bind(this);
    this.SaveApplication = this.SaveApplication.bind(this);
    this.handleInputChange = this.handleInputChange.bind(this);
    this.SaveTenderdetails = this.SaveTenderdetails.bind(this);
    this.CompletedApplication = this.CompletedApplication.bind(this);
  }
  closeModal = () => {
    this.setState({ open: false });
  };
  onEditorChange = evt => {
    this.setState({
      GroundDescription: evt.editor.getData()
    });
  };
  onEditor2Change = evt => {
    this.setState({
      RequestDescription: evt.editor.getData()
    });
  };

  closeFileViewModal = () => {
    this.setState({ openFileViewer: true });
  };
  ViewFile = (k, e) => {
    let filepath = k.Path + "/" + k.FileName;
    window.open(filepath);
    //this.setState({ openFileViewer: true });
  };
  closeRequestModal = () => {
    this.setState({ openRequest: false });
  };
  OpenGroundsModal = e => {
    e.preventDefault();
    this.setState({ open: true });
  };
  OpenRequestsModal = e => {
    e.preventDefault();
    this.setState({ openRequest: true });
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
  fetchApplicationGrounds = Applicationno => {
    fetch("/api/grounds/" + Applicationno, {
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
  fetchTenderAdendums = TenderID => {
    fetch("/api/tenderaddendums/" + TenderID, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(AddedAdendums => {
        if (AddedAdendums.length > 0) {
          this.setState({ AddedAdendums: AddedAdendums });
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
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
          this.setState({ Applicationfees: Applicationfees });

          this.setState({ TotalAmountdue: Applicationfees[0].total });
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  fetchApplicationDocuments = Applicationno => {
    fetch("/api/applicationdocuments/" + Applicationno, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(ApplicationDocuments => {
        if (ApplicationDocuments.length > 0) {
          this.setState({ ApplicationDocuments: ApplicationDocuments });
        } else {
          swal("", ApplicationDocuments.message, "error");
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
  hideAlert() {
    this.setState({
      alert: null
    });
  }
  DeleteRequest = d => {
    const data = {
      ApplicationID: this.state.ApplicationID,
      EntryType: d.EntryType,
      Description: d.Description
    };

    return fetch("/api/grounds/" + 1, {
      method: "Delete",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      },
      body: JSON.stringify(data)
    })
      .then(response =>
        response.json().then(data => {
          if (data.success) {
            var rows = [...this.state.ApplicationGrounds];
            const filtereddata = rows.filter(
              item => item.Description !== d.Description
            );
            this.setState({ ApplicationGrounds: filtereddata });
          } else {
            swal("", "Remove Failed", "error");
          }
        })
      )
      .catch(err => {
        swal("", "Remove Failed", "error");
      });
  };
  handleDeleteRequest = d => {
    const data = {
      ApplicationID: this.state.ApplicationID,
      EntryType: d.EntryType,
      Description: d.Description
    };

    swal({
      text: "Are you sure that you want to remove this record?",
      icon: "warning",
      dangerMode: true,
      buttons: true
    }).then(willDelete => {
      if (willDelete) {
        return fetch("/api/grounds/" + 1, {
          method: "Delete",
          headers: {
            "Content-Type": "application/json",
            "x-access-token": localStorage.getItem("token")
          },
          body: JSON.stringify(data)
        })
          .then(response =>
            response.json().then(data => {
              if (data.success) {
                var rows = [...this.state.ApplicationGrounds];
                const filtereddata = rows.filter(
                  item => item.Description !== d.Description
                );
                this.setState({ ApplicationGrounds: filtereddata });
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
  handleDeleteAdendum = d => {
    swal({
      text: "Are you sure that you want to remove this record?",
      icon: "warning",
      dangerMode: true,
      buttons: true
    }).then(willDelete => {
      if (willDelete) {
        return fetch("/api/tenderaddendums/" + d.AdendumNo, {
          method: "Delete",
          headers: {
            "Content-Type": "application/json",
            "x-access-token": localStorage.getItem("token")
          }
        })
          .then(response =>
            response.json().then(data => {
              if (data.success) {
                var rows = [...this.state.AddedAdendums];
                const filtereddata = rows.filter(
                  item => item.AdendumNo !== d.AdendumNo
                );
                this.setState({ AddedAdendums: filtereddata });
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
  handleDeleteDocument = d => {
    swal({
      text: "Are you sure that you want to remove this record?",
      icon: "warning",
      dangerMode: true,
      buttons: true
    }).then(willDelete => {
      if (willDelete) {
        return fetch("/api/applicationdocuments/" + d.FileName, {
          method: "Delete",
          headers: {
            "Content-Type": "application/json",
            "x-access-token": localStorage.getItem("token")
          }
        })
          .then(response =>
            response.json().then(data => {
              if (data.success) {
                var rows = [...this.state.ApplicationDocuments];
                const filtereddata = rows.filter(
                  item => item.FileName !== d.FileName
                );
                this.setState({ ApplicationDocuments: filtereddata });
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
  handleDeleteGround = d => {
    const data = {
      ApplicationID: this.state.ApplicationID,
      EntryType: d.EntryType,
      Description: d.Description
    };

    swal({
      text: "Are you sure that you want to remove this record?",
      icon: "warning",
      dangerMode: true,
      buttons: true
    }).then(willDelete => {
      if (willDelete) {
        return fetch("/api/grounds/" + 1, {
          method: "Delete",
          headers: {
            "Content-Type": "application/json",
            "x-access-token": localStorage.getItem("token")
          },
          body: JSON.stringify(data)
        })
          .then(response =>
            response.json().then(data => {
              if (data.success) {
                var rows = [...this.state.ApplicationGrounds];
                const filtereddata = rows.filter(
                  item => item.Description !== d.Description
                );
                this.setState({ ApplicationGrounds: filtereddata });
              } else {
                swal("", data.message, "error");
              }
            })
          )
          .catch(err => {
            swal("", err.message, "error");
          });
      }
    });
  };
  SaveTenders = event => {
    event.preventDefault();
  

    let awarddate = new Date(this.state.ClosingDate);
    awarddate.setDate(awarddate.getDate() + 14);
    //alert(awarddate)

    if (this.state.Today > dateFormat(new Date(awarddate).toLocaleDateString(), "isoDate")) {
      swal({
        text: "You are only allowed to submit an appeal within 14 days from date of award.To continue with the application click OK.",
        icon: "warning",
        dangerMode: true,
        buttons: true
      }).then(willDelete => {
        if (willDelete) {
          if (this.state.IsUpdate) {
            this.UpdateTenderdetails();
          } else {
            this.SaveTenderdetails();
          }
        }
      });

      
    } else {
      if (this.state.IsUpdate) {
        this.UpdateTenderdetails();
      } else {
        this.SaveTenderdetails();
      }
    }
  
    
    
  };

  UpdateTenderdetails() {
    let data = {
      TenderNo: this.state.TenderNo,
      TenderName: this.state.TenderName,
      PEID: this.state.PEID,
      StartDate: this.state.StartDate,
      ClosingDate: this.state.ClosingDate,
      TenderValue: this.state.TenderValue
    };
    fetch("/api/tenders/" + this.state.TenderID, {
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
            this.UpdateApplication();
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("!", err.message, "error");
      });
  }
  UpdateApplication() {
    let data = {
      TenderID: this.state.TenderID,
      ApplicantID: this.state.ApplicantID,
      PEID: this.state.PEID,
      ApplicationREf: this.state.ApplicationREf
    };
    fetch("/api/applications/" + this.state.ApplicationNo, {
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
            this.UpdateApplicationFees();
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  }
  UpdateApplicationFees() {
    let data = {
      EntryType: "10% On tender Value",
      AmountDue: this.state.TenderValue * 0.1
    };
    fetch("/api/applicationfees/" + this.state.ApplicationID, {
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
            toast.success("Information updated");
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  }
  SaveTenderdetails() {
    let data = {
      TenderNo: this.state.TenderNo,
      TenderName: this.state.TenderName,
      PEID: this.state.PEID,
      StartDate: this.state.StartDate,
      ClosingDate: this.state.ClosingDate,
      TenderValue: this.state.TenderValue
    };
    fetch("/api/tenders", {
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
            this.setState({ TenderID: data.results[0].TenderID });
            this.SaveApplication(data.results[0].TenderID);
            if (this.state.AdendumDescription) {
              //this.saveTenderAdendums(data.results[0].TenderID);
            }
            //document.getElementById("nav-profile-tab").click();
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  }
  saveGroundsDescriptions(EntryType) {
    if (this.state.ApplicationID) {
      let datatosave = {
        ApplicationID: this.state.ApplicationID,
        EntryType: EntryType,
        Description: this.state.GroundDescription,
        GroundNO: this.state.GroundNO
      };
      fetch("/api/grounds", {
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
              // this.setState({ Grounds: datatosave });
              var rows = this.state.ApplicationGrounds;
              rows.push(datatosave);
              this.setState({ ApplicationGrounds: rows });
              this.setState({ GroundDescription: "" });
              this.setState({ GroundsAvailable: true });
              this.setState({ open: false });
              this.setState({ GroundNO: "" });
            } else {
              swal("", "Could not be added please try again", "error");
            }
          })
        )
        .catch(err => {
          swal("", "Could not be added please try again", "error");
        });
    } else {
      alert(
        "Please ensure You have filled tender details before filling grounds and requests."
      );
    }
  }
  saveRequests(EntryType) {
    if (this.state.ApplicationID) {
      let datatosave = {
        ApplicationID: this.state.ApplicationID,
        EntryType: EntryType,
        Description: this.state.RequestDescription,
        GroundNO: this.state.GroundNO
      };
      fetch("/api/grounds", {
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
              // this.setState({ Grounds: datatosave });
              var rows = this.state.ApplicationGrounds;
              rows.push(datatosave);
              this.setState({ ApplicationGrounds: rows });
              this.setState({ RequestDescription: "" });
              this.setState({ RequestsAvailable: true });
              this.setState({ GroundNO: "" });

              this.setState({ openRequest: false });
            } else {
              swal("", "Could not be added please try again", "error");
            }
          })
        )
        .catch(err => {
          swal("", "Could not be added please try again", "error");
        });
    } else {
      alert(
        "Please ensure You have filled tender details before filling grounds and requests."
      );
    }
  }
  saveDocuments(FileName) {
    if (this.state.ApplicationID) {
      //save

      let datatosave = {
        ApplicationID: this.state.ApplicationID,
        Description: this.state.DocumentDescription,
        Path: process.env.REACT_APP_BASE_URL + "/Documents",
        FileName: FileName
      };
      fetch("/api/applicationdocuments", {
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
              toast.success("upload success");
              var rows = this.state.ApplicationDocuments;
              let datapush = {
                FileName: FileName,
                Description: this.state.DocumentDescription
              };
              rows.push(datapush);
              this.setState({ ApplicationDocuments: rows });
              this.setState({ DocumentsAvailable: true });
              this.setState({
                loaded: 0
              });
            } else {
              toast.error("Could not be saved please try again!");
              // swal("Saved!", "Could not be saved please try again", "error");
            }
          })
        )
        .catch(err => {
          swal("", "Could not be saved please try again", "error");
        });
    } else {
      toast.error(
        "Please ensure You have filled tender details before filling grounds and requests."
      );
      // alert("Please ensure You have filled tender details before filling grounds and requests.")
    }
  }
  handleGroundsSubmit = event => {
    event.preventDefault();
    this.saveGroundsDescriptions("Grounds for Appeal");
  };
  handleRequestSubmit = event => {
    event.preventDefault();
    this.saveRequests("Requested Orders");
  };
  Savefees(ApplicantID) {
    let data = {
      ApplicationID: ApplicantID,
      EntryType: "Application fee",
      AmountDue: 5000,
      RefNo: this.state.ApplicationREf
    };
    let data2 = {
      ApplicationID: ApplicantID,
      EntryType: "10% On Tender Value",
      AmountDue: 0.1 * this.state.TenderValue,
      RefNo: this.state.ApplicationREf
    };

    fetch("/api/applicationfees", {
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
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
    fetch("/api/applicationfees", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      },
      body: JSON.stringify(data2)
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
  SaveApplication(_TenderID) {
    let data = {
      TenderID: _TenderID,
      ApplicantID: this.state.ApplicantID,
      PEID: this.state.PEID,
      ApplicationREf: this.state.ApplicationREf
    };
    fetch("/api/applications", {
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
            this.setState({ ApplicationID: data.results[0].ApplicationID });
            this.setState({ ApplicationNo: data.results[0].ApplicationNo });

            this.Savefees(data.results[0].ApplicationID);
            toast.success("Tender details saved");
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  }
  handleswitchMenu = e => {
    e.preventDefault();
    if (this.state.profile === false) {
      this.setState({ profile: true });
    } else {
      this.setState({ profile: false });
      this.Resetsate();
    }
  };
  GoBack = e => {
    e.preventDefault();
    this.setState({ summary: false });
  };
  EditApplication = e => {
    if (this.state.profile === false) {
      this.setState({ profile: true });
    } else {
      this.setState({ profile: false });
    }
    this.setState({ GroundsAvailable: true });
    this.setState({ RequestsAvailable: true });
    this.setState({ IsUpdate: true });
    this.setState({ AddAdedendums: true });
    this.setState({ AdendumsAvailable: true });
    this.setState({ DocumentsAvailable: true });
  };
  handleSelectChange = (UserGroup, actionMeta) => {
    this.setState({ [actionMeta.name]: UserGroup.value });
  };
  handleInputChange = event => {
    // event.preventDefault();
    // this.setState({ [event.target.name]: event.target.value });
    const target = event.target;
    const value = target.type === "checkbox" ? target.checked : target.value;
    const name = target.name;
    this.setState({ [name]: value });
  };
  Resetsate() {
    const data = {
      TenderNo: "",
      TenderID: "",
      TenderValue: "",
      ApplicationID: "",
      TenderName: "",
      PEID: "",
      StartDate: "",
      ClosingDate: "",
      ApplicationREf: "",
      AdendumDescription: "",
      EntryType: "",
      RequestDescription: "",
      GroundDescription: "",
      ApplicationGrounds: [],
      ApplicationDocuments: [],
      Applicationfees: [],
      FilingDate: "",
      PEName: "",
      ApplicationNo: "",
      AddedAdendums: [],
      AdendumStartDate: "",
      RequestsAvailable: false,
      GroundsAvailable: false,
      AdendumsAvailable: false,
      AdendumClosingDate: "",
      AddAdedendums: false,
      IsUpdate: false,
      DocumentsAvailable: false
    };
    this.setState(data);
  }
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
    const types = [
      "application/pdf",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ];
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
          this.saveDocuments(res.data);
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
    this.setState({ AddedAdendums: [] });
    this.setState({ ApplicationGrounds: [] });
    this.setState({ ApplicationDocuments: [] });
    this.setState({ Applicationfees: [] });
    this.setState({ TotalAmountdue: "" });

    this.fetchApplicationGrounds(k.ID);
    this.fetchApplicationfees(k.ID);
    this.fetchApplicationDocuments(k.ID);
    this.fetchTenderAdendums(k.TenderID);
    const data = {
      PEPOBox: k.PEPOBox,
      PEPostalCode: k.PEPostalCode,
      PETown: k.PETown,
      PEPostalCode: k.PEPostalCode,
      PEMobile: k.PEMobile,
      PEEmail: k.PEEmail,
      PEWebsite: k.PEWebsite,

      TenderID: k.TenderID,
      ApplicationID: k.ID,
      ApplicationNo: k.ApplicationNo,
      TenderNo: k.TenderNo,
      ApplicationREf: k.ApplicationREf,
      PEName: k.PEName,
      FilingDate: new Date(k.FilingDate).toLocaleDateString(),
      TenderName: k.TenderName,
      Status: k.Status,
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
  };

  showAttacmentstab = e => {
    e.preventDefault();
    document.getElementById("nav-Attachments-tab").click();
  };
  openFeesTab() {
    document.getElementById("nav-Fees-tab").click();
  }
  CompletedApplication = () => {
    swal("", "Your Application has been submited", "success");
    let applicantMsg =
      "Your Application with ApplicationNO:" +
      this.state.ApplicationNo +
      " has been Received";
    this.SendSMS(this.state.ApplicantPhone, applicantMsg);
    this.sendApproverNotification();
    if (this.state.profile === false) {
      this.setState({ profile: true });
    }else{
      this.setState({ profile: false });
    }
    this.fetchMyApplications(this.state.ApplicantID);
  };
  sendApproverNotification = () => {
    fetch("/api/NotifyApprover/" + this.state.ApplicationNo, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(response =>
        response.json().then(data => {
          if (data.results) {
            let ApproversPhone = data.results[0].ApproversPhone;
            let ApproversMail = data.results[0].ApproversMail;
            let applicantMsg =
              "New Application with APPLICATIONNO:" +
              this.state.ApplicationNo +
              " has been submited and is awaiting your review";
            this.SendSMS(ApproversPhone, applicantMsg);
            let ID1 = "Applicant";
            let ID2 = "Approver";
            let subject1 = "PPARB APPLICATION ACKNOWLEDGEMENT";
            let subject2 = "APPROVAL REQUEST";
            this.SendMail(
              this.state.ApplicationNo,
              ApproversMail,
              ID2,
              subject2
            );
            this.SendMail(
              this.state.ApplicationNo,
              this.state.ApplicantEmail,
              ID1,
              subject1
            );
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  SendMail = (ApplicationNo, email, ID, subject1) => {
    const emaildata = {
      to: email,
      subject: subject1,
      ApplicationNo: ApplicationNo,
      ID: ID
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
  ShowAdendumsWindow = () => {
    this.setState({ AddAdedendums: !this.state.AddAdedendums });
  };
  openRequestTab() {
    document.getElementById("nav-profile-tab").click();
  }
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
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  }
  AddAdendum = event => {
    event.preventDefault();
    if (this.state.TenderID) {
      let dataToSave = {
        TenderID: this.state.TenderID,
        Description: this.state.AdendumDescription,
        StartDate: this.state.AdendumStartDate,
        ClosingDate: this.state.AdendumClosingDate,
        AdendumNo: this.state.AdendumNo
      };
      fetch("/api/tenderaddendums", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-access-token": localStorage.getItem("token")
        },
        body: JSON.stringify(dataToSave)
      })
        .then(response =>
          response.json().then(data => {
            if (data.success) {
              var rows = [...this.state.AddedAdendums];
              rows.push(dataToSave);
              this.setState({ AddedAdendums: rows });
              this.setState({ AdendumsAvailable: true });
              this.setState({ AdendumDescription: "" });
            } else {
              swal("", "Could not be added,Please try again", "error");
            }
          })
        )
        .catch(err => {
          swal("", err.message, "error");
        });
    } else {
      alert(
        "Ensure that you have saved tender details before adding Addendums"
      );
    }
  };

  render() {
    const PE = [...this.state.PE].map((k, i) => {
      return {
        value: k.PEID,
        label: k.Name
      };
    });

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
        if (k.Status === "NOT PAID") {
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
                  style={{ color: "#FF3C33" }}
                  onClick={e => this.handViewApplication(k, e)}
                >
                  AWAITING PAYMENT
                </b>
              </span>
            ),

            action: (
              <span>
                <Link
                  to={{
                    pathname: "/payment",
                    ApplicationID: k.ID,
                    ApplicationNo: k.ApplicationNo
                  }}
                >
                  <a
                    style={{ color: "#55FF33" }}
                    // onClick={e => this.handViewApplication(k, e)}
                  >
                    PAY NOW
                  </a>
                </Link>
              </span>
            )
          };
          Rowdata1.push(Rowdata);
        } else {
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
              <a
                className="font-weight-bold"
                onClick={e => this.handViewApplication(k, e)}
              >
                {k.Status}
              </a>
            ),

            action: (
              <span>
                <a
                  style={{ color: "#007bff" }}
                  onClick={e => this.handViewApplication(k, e)}
                >
                  {" "}
                  View{" "}
                </a>
              </span>
            )
          };
          Rowdata1.push(Rowdata);
        }
      });
    }
    let FormStyle = {
      margin: "20px"
    };
    let formcontainerStyle = {
      border: "1px solid grey",
      "border-radius": "10px"
    };
    let form2containerStyle = {
      border: "1px solid grey",
      "border-radius": "10px",
      margin: "50"
    };
    let divconatinerstyle = {
      width: "95%",
      margin: "0 auto",
      backgroundColor: "white"
    };

    let childdiv = {
      margin: "30px"
    };
    let adendumslink = {
      "margin-left": "40px",
      color: "blue"
    };
    let headingstyle = {
      color: "#7094db"
    };
    let ViewFile = this.ViewFile;

    if (this.state.profile) {
      if (this.state.summary) {
        return (
          <div>
            <div className="row wrapper border-bottom white-bg page-heading">
              <div className="col-lg-10">
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
                      STATUS:{" "}
                      {this.state.Status === "DECLINED" ? (
                        <span className="text-danger">
                          {" "}
                          {this.state.Status}
                        </span>
                      ) : (
                        <span className="text-success">
                          {" "}
                          {this.state.Status}
                        </span>
                      )}
                    </h2>
                  </li>
                </ol>
              </div>
              <div className="col-lg-2">
                <div className="row wrapper ">
                  <button
                    type="button"
                    style={{ marginTop: 40 }}
                    onClick={this.GoBack}
                    className="btn btn-primary float-left"
                  >
                    &nbsp; Back
                  </button>
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
                          {" "}
                          {this.formatNumber(this.state.TenderValue)}
                        </td>
                      </tr>
                      <tr>
                        <td className="font-weight-bold"> FilingDate:</td>
                        <td> {this.state.FilingDate}</td>
                      </tr>{" "}
                    </table>
                    <h3 style={headingstyle}>Tender Addendums</h3>
                    <table className="table table-borderless table-sm">
                      <th>No</th>
                      <th>StartDate</th>
                      <th>ClosingDate</th>
                      <th>Description</th>

                      {this.state.AddedAdendums.map((r, i) => (
                        <tr>
                          <td className="font-weight-bold">{r.AdendumNo}</td>

                          <td className="font-weight-bold">
                            {" "}
                            {new Date(r.StartDate).toLocaleDateString()}
                          </td>
                          <td className="font-weight-bold">
                            {" "}
                            {new Date(r.ClosingDate).toLocaleDateString()}
                          </td>
                          <td className="font-weight-bold">{r.Description}</td>
                        </tr>
                      ))}
                    </table>
                  </div>
                </div>
              </div>
              <br />
              <div className="row">
                <div className="col-lg-12 ">
                  <h3 style={headingstyle}>Grounds for Appeal</h3>
                  <div className="col-lg-11 border border-success rounded">
                    {this.state.ApplicationGrounds.map(function(k, i) {
                      if (k.EntryType === "Grounds for Appeal") {
                        return (
                          <p>
                            <h3>Ground NO:{k.GroundNO}</h3>

                            {ReactHtmlParser(k.Description)}
                            {/* <h3>Ground NO: {k.GroundNO}</h3>

                            <CKEditor readOnly="true" data={k.Description} /> */}
                          </p>
                        );
                      }
                    })}
                  </div>
                </div>
              </div>
              <br />
              <div className="row">
                <div className="col-lg-12 ">
                  <h3 style={headingstyle}>Requested Orders</h3>

                  <div className="col-lg-11 border border-success rounded">
                    {this.state.ApplicationGrounds.map(function(k, i) {
                      if (k.EntryType === "Requested Orders") {
                        return (
                          <p>
                            <h3>Request NO:{k.GroundNO}</h3>

                            {ReactHtmlParser(k.Description)}
                          </p>
                        );
                      }
                    })}
                  </div>
                </div>
              </div>
              <br />
              <div className="row">
                <div className="col-lg-12 ">
                  <h3 style={headingstyle}>Documents Attached</h3>
                  <div className="col-lg-11 border border-success rounded">
                    <table className="table table-sm">
                      <th>ID</th>
                      <th>Document Description</th>
                      <th>FileName</th>
                      <th>Date Uploaded</th>
                      <th>Actions</th>
                      {this.state.ApplicationDocuments.map(function(k, i) {
                        return (
                          <tr>
                            <td>{i + 1}</td>
                            <td>{k.Description}</td>
                            <td>{k.FileName}</td>
                            <td>
                              {new Date(k.DateUploaded).toLocaleDateString()}
                            </td>
                            <td>
                              {/* <a
                                href={k.Path + "/" + k.FileName}
                                target="_blank"
                                >
                                Download
                                </a> */}

                              <a
                                onClick={e => ViewFile(k, e)}
                                className="text-success"
                              >
                                <i class="fa fa-eye" aria-hidden="true"></i>View
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
              <div className="row">
                <div className="col-lg-12 ">
                  <h3 style={headingstyle}>Fees</h3>
                  <div className="col-lg-11 border border-success rounded">
                    <div class="col-sm-8">
                      <table class="table table-sm">
                        <thead>
                          <tr>
                            <th scope="col">#</th>
                            <th scope="col">Fees description</th>
                            <th scope="col">Value</th>
                          </tr>
                        </thead>
                        <tbody>
                          {this.state.Applicationfees.map((r, i) => (
                            <tr>
                              <td>{i + 1}</td>
                              <td>{r.EntryType}</td>
                              <td className="font-weight-bold">
                                {this.formatNumber(r.AmountDue)}
                              </td>
                            </tr>
                          ))}
                          <tr>
                            <th></th>
                            <th>Total Amount</th>
                            <th className="font-weight-bold text-danger">
                              {" "}
                              {this.formatNumber(this.state.TotalAmountdue)}
                            </th>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>

              <br />
              <div className="row">
                <div className="col-lg-10"></div>
                <div className="col-lg-1">
                  {this.state.Status === "NOT PAID" ? (
                    <Link
                      to={{
                        pathname: "/payment",
                        ApplicationID: this.state.ApplicationID,
                        ApplicationNo: this.state.ApplicationNo
                      }}
                    >
                      <button
                        type="button"
                        onClick={this.EditApplication}
                        className="btn btn-primary float-left"
                      >
                        &nbsp; PAY NOW
                      </button>
                    </Link>
                  ) : null}
                  {this.state.Status === "Unverified" ? (
                    <button
                      type="button"
                      onClick={this.EditApplication}
                      className="btn btn-primary float-left"
                    >
                      &nbsp; EDIT
                    </button>
                  ) : null}
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
              <div className="col-lg-10">
                <ol className="breadcrumb">
                  <li className="breadcrumb-item">
                    <h2>My Applications</h2>
                  </li>
                </ol>
              </div>
              <div className="col-lg-2">
                <div className="row wrapper ">
                  <button
                    type="button"
                    style={{ marginTop: 40 }}
                    onClick={this.handleswitchMenu}
                    className="btn btn-primary float-left"
                  >
                    &nbsp; New Application
                  </button>
                </div>
                {/* <div classname="col-lg-1"></div> */}
              </div>
            </div>

            <TableWrapper>
              <Table Rows={Rowdata1} columns={ColumnData} />
            </TableWrapper>
          </div>
        );
      }
    } else {
      return (
        <div>
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-10">
              <ol className="breadcrumb">
                <li className="breadcrumb-item">
                  {this.state.IsUpdate ? (
                    <h2 className="font-weight-bold">
                      Application NO: {this.state.ApplicationNo}
                    </h2>
                  ) : (
                    <h2>New Application</h2>
                  )}
                </li>
              </ol>
            </div>
            <div className="col-lg-2">
              <div className="row wrapper ">
                <button
                  type="button"
                  style={{ marginTop: 40 }}
                  onClick={this.handleswitchMenu}
                  className="btn btn-primary float-left"
                >
                  &nbsp; Back
                </button>
              </div>
            </div>
          </div>
          <p></p>
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
                      Tender Details{" "}
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
                      Grounds for Appeal
                    </a>
                    <a
                      class="nav-item nav-link font-weight-bold"
                      id="nav-Attachments-tab"
                      data-toggle="tab"
                      href="#nav-Attachments"
                      role="tab"
                      aria-controls="nav-Attachments"
                      aria-selected="false"
                    >
                      Attachments
                    </a>
                    <a
                      class="nav-item nav-link font-weight-bold"
                      id="nav-Fees-tab"
                      data-toggle="tab"
                      href="#nav-Fees"
                      role="tab"
                      aria-controls="nav-Fees"
                      aria-selected="false"
                    >
                      Fees
                    </a>
                  </div>
                </nav>
                <ToastContainer />
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
                      <form style={FormStyle} onSubmit={this.SaveTenders}>
                        <div class="row">
                          <div class="col-sm-2">
                            <label
                              for="ApplicantID"
                              className="font-weight-bold "
                            >
                              Applicant{" "}
                            </label>
                          </div>

                          <div class="col-sm-4">
                            <input
                              type="text"
                              class="form-control"
                              name="ApplicantID"
                              value={this.state.Applicantname}
                              required
                              disabled
                            />
                          </div>
                          <div class="col-sm-2">
                            <label for="PEID" className="font-weight-bold">
                              Procuring Entity{" "}
                            </label>
                          </div>
                          <div class="col-sm-4">
                            <div className="form-group">
                              <Select
                                name="PEID"
                                //value={this.state.PEID}
                                // value={PE.filter(
                                //     option =>
                                //         option.label === this.state.PEName
                                // )}
                                defaultInputValue={this.state.PEName}
                                onChange={this.handleSelectChange}
                                options={PE}
                                required
                              />
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col-sm-2">
                            <label for="TenderNo" className="font-weight-bold">
                              Tender NO
                            </label>
                          </div>
                          <div class="col-sm-4">
                            <input
                              type="text"
                              class="form-control"
                              name="TenderNo"
                              onChange={this.handleInputChange}
                              value={this.state.TenderNo}
                              required
                            />
                          </div>
                          <div class="col-sm-2">
                            <label
                              for="ApplicationREf"
                              className="font-weight-bold"
                            >
                              Refference{" "}
                            </label>
                          </div>
                          <div class="col-sm-4">
                            <input
                              type="text"
                              class="form-control"
                              name="ApplicationREf"
                              onChange={this.handleInputChange}
                              value={this.state.ApplicationREf}
                              required
                            />
                          </div>
                        </div>
                        <br />
                        <div class="row">
                          <div class="col-sm-2">
                            <label
                              for="TenderName"
                              className="font-weight-bold"
                            >
                              Tender Name{" "}
                            </label>
                          </div>
                          <div class="col-sm-4">
                            <input
                              type="text"
                              class="form-control"
                              name="TenderName"
                              onChange={this.handleInputChange}
                              value={this.state.TenderName}
                              required
                            />
                          </div>
                          <div class="col-sm-2">
                            <label for="TenderNo" className="font-weight-bold">
                              Tender Amount
                            </label>
                          </div>
                          <div class="col-sm-4">
                            <input
                              type="number"
                              class="form-control"
                              name="TenderValue"
                              onChange={this.handleInputChange}
                              value={this.state.TenderValue}
                              required
                              min="1"
                            />
                          </div>
                        </div>
                        <br />
                        <div class="row">
                          <div class="col-sm-2">
                            <label for="Town" className="font-weight-bold">
                              Tender Opening Date{" "}
                            </label>
                          </div>
                          <div class="col-sm-4">
                            <input
                              type="date"
                              name="StartDate"
                              required
                              defaultValue={this.state.StartDate}
                              className="form-control"
                              onChange={this.handleInputChange}
                              max={this.state.Today}
                            />
                          </div>
                          <div class="col-sm-2">
                            <label
                              for="ClosingDate"
                              className="font-weight-bold"
                            >
                              Date of Award
                            </label>
                          </div>
                          <div class="col-sm-4">
                            <input
                              type="date"
                              name="ClosingDate"
                              required
                              defaultValue={this.state.ClosingDate}
                              className="form-control"
                              onChange={this.handleInputChange}
                              max={this.state.Today}
                            />
                          </div>
                        </div>
                        <p></p>
                        <div className=" row">
                          <div className="col-sm-2" />
                          <div className="col-sm-8" />
                          <div className="col-sm-1">
                            <button
                              type="submit"
                              className="btn btn-primary float-right"
                            >
                              Save
                            </button>
                          </div>
                          <div className="col-sm-1">
                            {this.state.AddAdedendums ? null : (
                              <button
                                type="button"
                                onClick={this.openRequestTab}
                                className="btn btn-primary float-left"
                              >
                                {" "}
                                &nbsp; Next
                              </button>
                            )}
                          </div>
                        </div>
                      </form>
                    </div>
                    {/* </form> */}
                    <a
                      onClick={this.ShowAdendumsWindow}
                      style={adendumslink}
                      className="font-weight-bold"
                    >
                      Add Tender Addendums
                    </a>
                    {this.state.AddAdedendums ? (
                      <div style={formcontainerStyle}>
                        <div style={FormStyle}>
                          <div class="row">
                            <div class="col-sm-6">
                              <div class="row">
                                <div class="col-sm-2">
                                  <label
                                    for="Town"
                                    className="font-weight-bold"
                                  >
                                    Number{" "}
                                  </label>
                                  <input
                                    type="text"
                                    name="AdendumNo"
                                    required
                                    defaultValue={this.state.AdendumNo}
                                    className="form-control"
                                    onChange={this.handleInputChange}
                                  />
                                </div>
                                <div class="col-sm-5">
                                  <label
                                    for="Town"
                                    className="font-weight-bold"
                                  >
                                    Issuing Date{" "}
                                  </label>
                                  <input
                                    type="date"
                                    name="AdendumStartDate"
                                    required
                                    defaultValue={this.state.AdendumStartDate}
                                    className="form-control"
                                    onChange={this.handleInputChange}
                                    max={this.state.Today}
                                  />
                                </div>

                                <div class="col-sm-5">
                                  <label
                                    for="Town"
                                    className="font-weight-bold"
                                  >
                                    Closing Date{" "}
                                  </label>
                                  <input
                                    type="date"
                                    name="AdendumClosingDate"
                                    required
                                    defaultValue={this.state.AdendumClosingDate}
                                    className="form-control"
                                    onChange={this.handleInputChange}
                                    max={this.state.Today}
                                  />
                                </div>
                              </div>
                              <div class="row">
                                <div class="col-sm-10">
                                  <label
                                    for="Name"
                                    className="font-weight-bold"
                                  >
                                    Description{" "}
                                  </label>

                                  <textarea
                                    onChange={this.handleInputChange}
                                    value={this.state.AdendumDescription}
                                    type="text"
                                    name="AdendumDescription"
                                    className="form-control"
                                  />
                                </div>
                                <div class="col-sm-2">
                                  <br />
                                  <br />
                                  <button
                                    onClick={this.AddAdendum}
                                    className="btn btn-primary float-left "
                                  >
                                    &nbsp; Add{" "}
                                  </button>
                                </div>
                              </div>
                            </div>
                            <div class="col-sm-6">
                              <div class="col-sm-12">
                                {this.state.AdendumsAvailable ? (
                                  <table className="table table-sm">
                                    <th scope="col">No</th>
                                    <th scope="col">Issuing Date</th>
                                    <th scope="col">Closing Date</th>
                                    <th scope="col">Description</th>
                                    <th scope="col">Action</th>
                                    {this.state.AddedAdendums.map((r, i) => (
                                      <tr>
                                        <td>{r.AdendumNo}</td>
                                        <td>
                                          {new Date(
                                            r.StartDate
                                          ).toLocaleDateString()}
                                        </td>

                                        <td>
                                          {new Date(
                                            r.ClosingDate
                                          ).toLocaleDateString()}
                                        </td>

                                        <td>{r.Description}</td>
                                        <td>
                                          {" "}
                                          <span>
                                            <a
                                              style={{ color: "#f44542" }}
                                              onClick={e =>
                                                this.handleDeleteAdendum(r, e)
                                              }
                                            >
                                              &nbsp; Remove
                                            </a>
                                          </span>
                                        </td>
                                      </tr>
                                    ))}
                                  </table>
                                ) : null}
                              </div>
                            </div>
                          </div>
                          <div className="row">
                            <div className="col-sm-10"></div>
                            <div className="col-sm-2">
                              {this.state.AddAdedendums ? (
                                <button
                                  type="button"
                                  onClick={this.openRequestTab}
                                  className="btn btn-primary float-right"
                                >
                                  {" "}
                                  &nbsp; Next
                                </button>
                              ) : null}
                            </div>
                          </div>
                        </div>
                      </div>
                    ) : null}
                    <div>
                      <br />

                      <br />
                      <i className="font-weight-bold">
                        If false information is input in the system, the
                        applicant risks losing his deposit, and in addition to
                        this if found to be corrupt/ fraudulent, the DG of PPRA
                        may initiate case proceedings against the applicant in a
                        court of law.
                      </i>
                    </div>
                  </div>
                  <div
                    class="tab-pane fade"
                    id="nav-profile"
                    role="tabpanel"
                    style={childdiv}
                    aria-labelledby="nav-profile-tab"
                  >
                    <div style={form2containerStyle}>
                      <form onSubmit={this.handleGroundsSubmit}>
                        <div style={childdiv}>
                          <label for="Name" className="font-weight-bold">
                            1. Grounds for appeal &nbsp; &nbsp; &nbsp; &nbsp;
                          </label>
                          <button
                            className="btn btn-info"
                            type="button"
                            onClick={this.OpenGroundsModal}
                          >
                            Add
                          </button>
                          <Popup
                            open={this.state.open}
                            closeOnDocumentClick
                            onClose={this.closeModal}
                          >
                            <div className={popup.modal}>
                              <div className="container-fluid">
                                <div className="col-sm-12">
                                  <div className="ibox-con</div>tent">
                                    <div
                                      className={popup.header}
                                      className="font-weight-bold"
                                    >
                                      {" "}
                                      Add ground for appeal{" "}
                                    </div>
                                    <br />
                                    <label
                                      for="ApplicantID"
                                      className="font-weight-bold "
                                    >
                                      Ground NO{" "}
                                    </label>
                                    <div class="row">
                                      <div class="col-sm-4">
                                        <input
                                          type="number"
                                          class="form-control"
                                          name="GroundNO"
                                          onChange={this.handleInputChange}
                                          value={this.state.GroundNO}
                                          required
                                          min="1"
                                        />
                                      </div>
                                    </div>
                                    <br />
                                    <label
                                      for="GroundDescription"
                                      className="font-weight-bold "
                                    >
                                      Description{" "}
                                    </label>
                                    <div class="row">
                                      <div class="col-sm-12">
                                        <CKEditor
                                          data={this.state.RequestDescription}
                                          onChange={this.onEditorChange}
                                        />
                                      </div>
                                    </div>

                                    <br />
                                    <div className="row">
                                      <div class="col-sm-9"></div>
                                      <div class="col-sm-3">
                                        <button
                                          type="button"
                                          onClick={this.closeModal}
                                          className="btn btn-danger float-left "
                                        >
                                          &nbsp;Close{" "}
                                        </button>
                                        <button
                                          type="submit"
                                          className="btn btn-primary float-right "
                                        >
                                          &nbsp;Save{" "}
                                        </button>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </Popup>
                          <p></p>
                          <div class="row">
                            <div class="col-sm-8">
                              {this.state.GroundsAvailable ? (
                                <table class="table table-sm">
                                  <thead>
                                    <tr>
                                      <th scope="col">NO</th>
                                      <th scope="col">Grounds for appeal</th>
                                      <th scope="col">Actions</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {this.state.ApplicationGrounds.map((r, i) =>
                                      r.EntryType === "Grounds for Appeal" ? (
                                        <tr>
                                          <td>{r.GroundNO}</td>
                                          <td>
                                            {ReactHtmlParser(r.Description)}
                                          {/* <CKEditor
                                            data={r.Description}
                                            onChange={this.onEditorChange}
                                          /> */}
                                          </td>
                                          <td>
                                            {" "}
                                            <span>
                                              <a
                                                style={{ color: "#f44542" }}
                                                onClick={e =>
                                                  this.handleDeleteRequest(r, e)
                                                }
                                              >
                                                &nbsp; Remove
                                              </a>
                                              {this.state.alert}
                                            </span>
                                          </td>
                                        </tr>
                                      ) : null
                                    )}
                                  </tbody>
                                </table>
                              ) : null}
                            </div>
                          </div>
                        </div>
                      </form>

                      <form onSubmit={this.handleRequestSubmit}>
                        <div style={childdiv}>
                          <label for="Name" className="font-weight-bold">
                            2. Requested Orders &nbsp; &nbsp; &nbsp; &nbsp;
                            &nbsp;
                          </label>
                          <button
                            className="btn btn-info"
                            type="button"
                            onClick={this.OpenRequestsModal}
                          >
                            Add
                          </button>
                          <Popup
                            open={this.state.openRequest}
                            closeOnDocumentClick
                            onClose={this.closeRequestModal}
                          >
                            <div className={popup.modal}>
                              <div className="container-fluid">
                                <div className="col-sm-12">
                                  <div className="ibox-con</div>tent">
                                    <div
                                      className={popup.header}
                                      className="font-weight-bold"
                                    >
                                      {" "}
                                      Add Requested Orders{" "}
                                    </div>
                                    <br />
                                    <label
                                      for="ApplicantID"
                                      className="font-weight-bold "
                                    >
                                      Request NO{" "}
                                    </label>
                                    <div class="row">
                                      <div class="col-sm-4">
                                        <input
                                          type="number"
                                          class="form-control"
                                          name="GroundNO"
                                          onChange={this.handleInputChange}
                                          value={this.state.GroundNO}
                                          required
                                          min="1"
                                        />
                                      </div>
                                    </div>
                                    <br />
                                    <label
                                      for="GroundDescription"
                                      className="font-weight-bold "
                                    >
                                      Description{" "}
                                    </label>
                                    <div class="row">
                                      <div class="col-sm-12">
                                        <CKEditor
                                          data={this.state.GroundDescription}
                                          onChange={this.onEditor2Change}
                                        />
                                      </div>
                                    </div>
                                   
                                    <br />
                                    <div className="row">
                                      <div class="col-sm-9"></div>
                                      <div class="col-sm-3">
                                        <button
                                          type="button"
                                          onClick={this.closeRequestModal}
                                          className="btn btn-danger float-left "
                                        >
                                          &nbsp;Close{" "}
                                        </button>
                                        <button
                                          type="submit"
                                          className="btn btn-primary float-right "
                                        >
                                          &nbsp;Save{" "}
                                        </button>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </Popup>

                          <div class="row">
                            <div class="col-sm-8">
                              {this.state.RequestsAvailable ? (
                                <table class="table table-sm">
                                  <thead>
                                    <tr>
                                      <th scope="col">NO</th>
                                      <th scope="col">Requested Orders</th>
                                      <th scope="col">Actions</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {this.state.ApplicationGrounds.map((r, i) =>
                                      r.EntryType === "Requested Orders" ? (
                                        <tr>
                                          <td>{r.GroundNO}</td>
                                          <td>
                                            {/* <CKEditor
                                              data={r.Description}
                                              onChange={this.onEditorChange}
                                            /> */}
                                            {ReactHtmlParser(r.Description)}
                                          </td>
                                          <td>
                                            {" "}
                                            <span>
                                              <a
                                                style={{ color: "#f44542" }}
                                                onClick={e =>
                                                  this.handleDeleteRequest(r, e)
                                                }
                                              >
                                                &nbsp; Remove
                                              </a>
                                            </span>
                                          </td>
                                        </tr>
                                      ) : null
                                    )}
                                  </tbody>
                                </table>
                              ) : null}
                            </div>
                          </div>
                          <div className=" row">
                            <div className="col-sm-11"></div>
                            <div className="col-sm-1">
                              <button
                                className="btn btn-primary"
                                onClick={this.showAttacmentstab}
                              >
                                Next &nbsp;
                              </button>
                            </div>
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                  <div
                    class="tab-pane fade"
                    id="nav-Attachments"
                    role="tabpanel"
                    style={childdiv}
                    aria-labelledby="nav-Attachments-tab"
                  >
                    <div style={formcontainerStyle}>
                      <form style={FormStyle} onSubmit={this.onClickHandler}>
                        <div class="row">
                          <div class="col-sm-6">
                            <label
                              for="DocumentDescription"
                              className="font-weight-bold"
                            >
                              Description{" "}
                            </label>
                            <input
                              type="text"
                              class="form-control"
                              name="DocumentDescription"
                              onChange={this.handleInputChange}
                              value={this.state.DocumentDescription}
                              required
                            />
                          </div>
                        </div>
                        <div class="row">
                          <div class="col-sm-6">
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
                              type="submit"
                              class="btn btn-success "
                              // onClick={this.onClickHandler}
                            >
                              Upload
                            </button>{" "}
                          </div>
                        </div>

                        <div class="row">
                          <div class="col-sm-8">
                            {this.state.DocumentsAvailable ? (
                              <table class="table table-sm">
                                <thead>
                                  <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">File Description</th>
                                    {/* <th scope="col">File Name</th> */}
                                    <th scope="col">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  {this.state.ApplicationDocuments.map(
                                    (r, i) => (
                                      <tr>
                                        <td>{i + 1}</td>
                                        <td>{r.Description}</td>
                                        {/* <td>{r.FileName}</td> */}
                                        <td>
                                          <span>
                                            <a
                                              style={{ color: "#f44542" }}
                                              onClick={e =>
                                                this.handleDeleteDocument(r, e)
                                              }
                                            >
                                              &nbsp; Remove
                                            </a>
                                          </span>
                                        </td>
                                      </tr>
                                    )
                                  )}
                                </tbody>
                              </table>
                            ) : null}
                          </div>
                        </div>
                        <div class="row">
                          <div class="col-sm-11"></div>
                          <div class="col-sm-1">
                            <button
                              type="button"
                              onClick={this.openFeesTab}
                              className="btn btn-primary "
                            >
                              {" "}
                              &nbsp; Next
                            </button>
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                  <div
                    class="tab-pane fade"
                    id="nav-Fees"
                    role="tabpanel"
                    style={childdiv}
                    aria-labelledby="nav-Fees-tab"
                  >
                    <div style={formcontainerStyle}>
                      <div style={FormStyle}>
                        <h3 style={headingstyle}>Application fees</h3>

                        <div className="row">
                          <div class="col-sm-8">
                            <table className="table table-sm">
                              <th>#</th>
                              <th>fees description</th>
                              <th>Value</th>
                              <tr>
                                <td>1</td>
                                <td>Application fee</td>
                                <td>5000</td>
                              </tr>
                              <tr>
                                <td>2</td>
                                <td>
                                  10% Deposit fee of Tender Value (
                                  {this.formatNumber(this.state.TenderValue)})
                                </td>
                                <td>
                                  {this.formatNumber(
                                    this.state.TenderValue * 0.1
                                  )}
                                </td>
                              </tr>
                              <tfoot>
                                <tr>
                                  <th></th>
                                  <th scope="row">Total Amount</th>
                                  <th>
                                    {this.formatNumber(
                                      this.state.TenderValue * 0.1 + 5000
                                    )}
                                  </th>
                                </tr>
                              </tfoot>
                            </table>
                          </div>
                        </div>
                        <div className=" row">
                          <div className="col-sm-10" />
                          <div className="col-sm-2">
                            <button
                              className="btn btn-primary"
                              onClick={this.CompletedApplication}
                            >
                              SUBMIT FOR REVIEW
                            </button>
                          </div>
                        </div>
                        <br />
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
}

export default Applications;
