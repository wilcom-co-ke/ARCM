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
import Modal from "react-awesome-modal";
let userdateils = localStorage.getItem("UserData");
let data = JSON.parse(userdateils);
var dateFormat = require("dateformat");
class Applications extends Component {
  constructor() {
    super();
    this.state = {
      open: false,
      Confidential: false,
      openRequest: false,
      Board: data.Board,
      ApplicantEmail: data.Email,
      ApplicantPhone: data.Phone,
      Applications: [],
      PE: [],
      PaymentDetails: [],
      BankSlips: [],
      interestedparties: [],
      Today: dateFormat(new Date().toLocaleDateString(), "isoDate"),
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
      openPaymentModal:false,
      TenderTypes: [],
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
      TenderType: "",
      ApplicantPostalCode: "",
      ApplicantPOBox: "",
      ApplicantTown: "",
      AddInterestedParty: false,
      alert: null,
      Timer: "",
      Unascertainable: false,
      Ascertainable: false,
      TenderCategory: "",
      InterestedPartyContactName: "",
      InterestedPartyName: "",
      InterestedPartyEmail: "",
      InterestedPartyTelePhone: "",
      InterestedPartyMobile: "",
      InterestedPartyPhysicalAddress: "",
      InterestedPartyPOBox: "",
      InterestedPartyPostalCode: "",
      InterestedPartyTown: "",
      InterestedPartyDesignation: "",
      TenderTypeDesc: "",
      ShowPaymentDetails: false,

      AmountPaid: "",
      DateofPayment: "",
      PaymentReference: "",
      PaidBy: ""
    };
    this.handViewApplication = this.handViewApplication.bind(this);
    this.Resetsate = this.Resetsate.bind(this);
    this.SaveApplication = this.SaveApplication.bind(this);
    this.handleInputChange = this.handleInputChange.bind(this);
    this.SaveTenderdetails = this.SaveTenderdetails.bind(this);
    this.CompletedApplication = this.CompletedApplication.bind(this);
  }
  checkDocumentRoles = (CreatedBy) => {
  
    if (this.state.Board) {

      return true;
    }
    if (localStorage.getItem("UserName") === CreatedBy) {
      return true;
    }

    return false;

  }
  closeAddInterestedParty = () => {
    this.setState({ AddInterestedParty: false });
  };
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
  ClosePaymentModal = () => {
    this.setState({ openPaymentModal: false });
  }
  OpenPaymentModal = () => {
    this.setState({ openPaymentModal: true });
  }
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
          this.setState({ AdendumsAvailable: true });
        }else{
          this.setState({ AddAdedendums: false });
          this.setState({ AdendumsAvailable: false });
        }
      })
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  fetchApplicationfees = Applicationno => {
    this.setState({ Applicationfees: [] });
    this.setState({ TotalAmountdue: "" });
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
            ApplicantPostalCode: ApplicantDetails[0].PostalCode,          
            ApplicantPOBox: ApplicantDetails[0].POBox ,
            ApplicantTown: ApplicantDetails[0].Town ,
            ApplicantDetails: ApplicantDetails ,
            Applicantname: ApplicantDetails[0].Name ,
            ApplicantLocation: ApplicantDetails[0].Location ,
            ApplicantMobile: ApplicantDetails[0].Mobile,
            ApplicantEmail: ApplicantDetails[0].Email,
            ApplicantPIN: ApplicantDetails[0].PIN ,
            ApplicantWebsite: ApplicantDetails[0].Website ,
            ApplicantID: ApplicantDetails[0].ID });
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
  handleDeleteInterestedparty = d => {
    swal({
      text: "Are you sure that you want to remove this record?",
      icon: "warning",
      dangerMode: true,
      buttons: true
    }).then(willDelete => {
      if (willDelete) {
        return fetch("/api/interestedparties/" + d.ID, {
          method: "Delete",
          headers: {
            "Content-Type": "application/json",
            "x-access-token": localStorage.getItem("token")
          }
        })
          .then(response =>
            response.json().then(data => {
              if (data.success) {
                toast.success("Removed successfully");
                this.fetchinterestedparties(this.state.ApplicationID);
              } else {
                toast.error("Remove Failed");
              }
            })
          )
          .catch(err => {
            toast.error("Remove Failed");
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
  handleDeleteBankSlip = d => {
    swal({
      text: "Are you sure that you want to remove this slip?",
      icon: "warning",
      dangerMode: true,
      buttons: true
    }).then(willDelete => {
      if (willDelete) {
        return fetch("/api/applicationfees/" + d, {
          method: "Delete",
          headers: {
            "Content-Type": "application/json",
            "x-access-token": localStorage.getItem("token")
          }
        })
          .then(response =>
            response.json().then(data => {
              if (data.success) {
                var rows = [...this.state.BankSlips];
                const filtereddata = rows.filter(item => item.Name !== d);
                this.setState({ BankSlips: filtereddata });
                toast.success("Removed successfully");
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
    if (
      this.state.Today >
      dateFormat(new Date(awarddate).toLocaleDateString(), "isoDate")
    ) {
      swal({
        text:
          "You are only allowed to submit an appeal within 14 days from date of award.To continue with the application click OK.",
        icon: "warning",
        dangerMode: true,
        buttons: true
      }).then(willDelete => {
        if (willDelete) {
          if (this.state.IsUpdate) {
            this.UpdateTenderdetails();
          } else {
            this.SaveTenderdetails("Submited after 14 days");
          }
        }
      });
    } else {
      if (this.state.IsUpdate) {
        this.UpdateTenderdetails();
      } else {
        this.SaveTenderdetails("Submited within 14 days");
      }
    }
  };
  UpdateTenderdetails = () => {
    if (this.state.TenderType === "B") {
      if (!this.state.TenderCategory) {
        toast.error("Tender category is required.");
        return;
      }
      if (!this.state.TenderSubCategory) {
        toast.error("Tender subcategory is required.");
        return;
      }
    }
    let data = {
      TenderNo: this.state.TenderNo,
      TenderName: this.state.TenderName,
      PEID: this.state.PEID,
      StartDate: this.state.StartDate,
      ClosingDate: this.state.ClosingDate,
      TenderValue: this.state.TenderValue,
      TenderType: this.state.TenderType,
      TenderSubCategory: this.state.TenderSubCategory,
      TenderCategory: this.state.TenderCategory
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
  };
  UpdateApplication = () => {
    let data = {
      TenderID: this.state.TenderID,
      ApplicantID: this.state.ApplicantID,
      PEID: this.state.PEID
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
            let newdata = {
              TenderValue: "",
              TenderType: "",
              TenderSubCategory: "",
              TenderCategory: ""
            };
            this.setState(newdata);
            this.UpdateApplicationFees();
          } else {
            swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        swal("", err.message, "error");
      });
  };
  UpdateApplicationFees() {
    fetch("/api/applicationfees/" + this.state.ApplicationID, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(response =>
        response.json().then(data => {
          if (data.success) {
            toast.success("Information updated");
            this.fetchApplicationfees(this.state.ApplicationID);
          } else {
            toast.error(data.message);
            // swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        toast.error(err.message);
        // swal("", err.message, "error");
      });
  }
  SavePaymentdetails=()=>{    
    
    if (!this.state.DateofPayment)
    {
      swal("", "Date of payment is required", "error");
      return;
    }
    if (!this.state.PaymentReference) {
      swal("", "Reference is required", "error");
      return;
    }
    if (!this.state.AmountPaid) {
      swal("", "Amount paid is required", "error");
      return;
    }
    if (!this.state.PaidBy) {
      swal("", "Paid by is required", "error");
      return;
    }
    if (+this.state.TotalAmountdue > +this.state.AmountPaid) {
      toast.warn("Amount paid is less than amount due");
    }
    let data = {
      ApplicationID: this.state.ApplicationID,
      Paidby: this.state.PaidBy,
      Reference: this.state.PaymentReference,
      DateOfpayment: this.state.DateofPayment,
      AmountPaid: this.state.AmountPaid,
      Category:"Applicationfees"
    };       
    fetch("/api/applicationfees/1/Paymentdetails", {
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
             
            toast.success("Payment details save successfuly");  
            //swal("","Payment details save successfuly","success")   
            this.SubmitApplication();
            this.sendApproverNotification();
            this.setState({ PaymentStatus:"Submited"})       
          } else {
            toast.error(data.message);
          }
        })
      )
      .catch(err => {
        toast.error(err.message);
       });
  }

  SaveTenderdetails(Timer) {
    if (this.state.TenderType === "B") {
      if (!this.state.TenderCategory) {
        toast.error("Tender category is required.");
        return;
      } else {
        if (this.state.TenderCategory === "Other Tenders") {
        } else {
          if (!this.state.TenderSubCategory) {
            toast.error("Tender subcategory is required.");
            return;
          }
        }
      }
    }
    let data = {
      TenderNo: this.state.TenderNo,
      TenderName: this.state.TenderName,
      PEID: this.state.PEID,
      StartDate: this.state.StartDate,
      ClosingDate: this.state.ClosingDate,
      TenderValue: this.state.TenderValue,
      TenderType: this.state.TenderType,
      TenderSubCategory: this.state.TenderSubCategory,
      TenderCategory: this.state.TenderCategory,
      Timer: Timer
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
            toast.error(data.message);
            // swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        toast.error(err.message);
        //swal("", err.message, "error");
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
              toast.error("Could not be added please try again");
              // swal("", , "error");
            }
          })
        )
        .catch(err => {
          toast.error("Could not be added please try again");
        });
    } else {
      toast.error(
        "Please ensure You have filled tender details before filling grounds and requests."
      );
    }
  }
  fetchAdditionalSubmisions = (ApplicationID) => {
    this.setState({
      AdditionalSubmisions: []
    });
    fetch("/api/additionalsubmissions/" + ApplicationID + "/Applicant", {
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
              toast.error("Could not be added please try again");
            }
          })
        )
        .catch(err => {
          toast.error("Could not be added please try again");
        });
    } else {
      toast.error(
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
        FileName: FileName,
        Confidential: this.state.Confidential
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
  handleInterestedPartySubmit = event => {
    event.preventDefault();
    if (this.state.ApplicationID) {
      let datatosave = {
        Name: this.state.InterestedPartyName,
        ApplicationID: this.state.ApplicationID,
        ContactName: this.state.InterestedPartyContactName,
        Email: this.state.InterestedPartyEmail,
        TelePhone: this.state.InterestedPartyTelePhone,
        Mobile: this.state.InterestedPartyMobile,
        PhysicalAddress: this.state.InterestedPartyPhysicalAddress,
        PostalCode: this.state.InterestedPartyPostalCode,
        Town: this.state.InterestedPartyTown,
        POBox: this.state.InterestedPartyPOBox,
        Designation: this.state.InterestedPartyDesignation
      };
      fetch("/api/interestedparties", {
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
              var rows = this.state.interestedparties;
              rows.push(datatosave);
              this.setState({ interestedparties: rows });
              toast.success("Added successfully");
              let setstatedata = {
                InterestedPartyContactName: "",
                InterestedPartyName: "",
                InterestedPartyEmail: "",
                InterestedPartyTelePhone: "",
                InterestedPartyMobile: "",
                InterestedPartyPhysicalAddress: "",
                InterestedPartyPOBox: "",
                InterestedPartyPostalCode: "",
                InterestedPartyTown: "",
                InterestedPartyDesignation: "",
                AddInterestedParty: false
              };
              this.setState(setstatedata);
            } else {
              toast.error(data.message);
              //swal("", "Could not be added please try again", "error");
            }
          })
        )
        .catch(err => {
          toast.error("Could not be added please try again");
        });
    } else {
      toast.error(
        "Please ensure You have filled tender details before adding interested parties."
      );
    }
  };
  Savefees(ApplicantID) {
    let data = {
      ApplicationID: ApplicantID
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
            this.fetchApplicationfees(this.state.ApplicationID);
          } else {
            toast.error("Error occured while generating fees");
          }
        })
      )
      .catch(err => {
        toast.error("Error occured while generating fees");
      });
  }
  SaveApplication(_TenderID) {
    let data = {
      TenderID: _TenderID,
      ApplicantID: this.state.ApplicantID,
      PEID: this.state.PEID
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
            this.setState({ ApplicationREf: data.results[0].ApplicationREf });
            this.Savefees(data.results[0].ApplicationID);
            toast.success("Tender details saved");
            let newdata = {
              TenderValue: "",
              TenderType: "",
              TenderSubCategory: "",
              TenderCategory: ""
            };
            this.setState(newdata);
          } else {
            toast.error(data.message);
            //swal("", data.message, "error");
          }
        })
      )
      .catch(err => {
        toast.error(err.message);
        // swal("", err.message, "error");
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
    
    this.setState({ DocumentsAvailable: true });
    if (this.state.TenderType === "A") {
      this.setState({
        Ascertainable: true,
        Unascertainable: false,
        ShowSubcategory: false
      });
    } else {
      this.setState({
        Ascertainable: false,
        Unascertainable: true,
        ShowSubcategory: true
      });
    }
  };
  handleSelectChange = (UserGroup, actionMeta) => {
    this.setState({ [actionMeta.name]: UserGroup.value });
    if (actionMeta.name === "TenderType") {
      if (UserGroup.value === "A") {
        this.setState({
          Ascertainable: true,
          Unascertainable: false,
          ShowSubcategory: false
        });
      } else {
        this.setState({
          Ascertainable: false,
          Unascertainable: true,
          ShowSubcategory: false
        });
      }
    }
    if (actionMeta.name === "TenderCategory") {
      if (UserGroup.value === "Unquantified Tenders") {
        this.setState({ ShowSubcategory: true });
      } else if (UserGroup.value === "Pre-qualification") {
        this.setState({ ShowSubcategory: true });
      } else {
        this.setState({ ShowSubcategory: false });
      }
    }
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
  fetchBankSlips = Applicationno => {
    this.setState({ BankSlips: [] });
    fetch("/api/applicationfees/" + Applicationno + "/Bankslips", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(BankSlips => {
        if (BankSlips.length > 0) {
          this.setState({ BankSlips: BankSlips });
        }
      })
      .catch(err => {
        toast.error(err.message)
      });
  };
  fetchPaymentDetails = ApplicationID => {
    this.setState({ PaymentDetails: [] });
    fetch("/api/applicationfees/" + ApplicationID + "/PaymentDetails", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(PaymentDetails => {
        if (PaymentDetails.length > 0) {
          this.setState({ PaymentDetails: PaymentDetails });
        }
      })
      .catch(err => {
        toast.error(err.message)
        //swal("", err.message, "error");
      });
  };
  SaveBankSlip(Filename) {
    let data = {
      ApplicationID: this.state.ApplicationID,
      filename: Filename,
      Category:"ApplicationFees"
    };
    fetch("/api/applicationfees/BankSlip", {
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
            toast.success("upload complete");
            this.fetchBankSlips(this.state.ApplicationID);
          } else {
            toast.error("Error occured while saving uploaded document");
          }
        })
      )
      .catch(err => {
        toast.error("Error occured while saving uploaded document");
      });
  }
  UploadBankSlip = event => {
    event.preventDefault();
    if (this.state.selectedFile) {
      const data = new FormData();

      for (var x = 0; x < this.state.selectedFile.length; x++) {
        data.append("file", this.state.selectedFile[x]);
      }
      axios
        .post("/api/upload/BankSlips", data, {
          // receive two parameter endpoint url ,form data
          onUploadProgress: ProgressEvent => {
            this.setState({
              loaded: (ProgressEvent.loaded / ProgressEvent.total) * 100
            });
          }
        })
        .then(res => {
          this.SaveBankSlip(res.data);
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
  fetchinterestedparties = (ApplicationID) => {
    this.setState({ interestedparties: [] });
    fetch("/api/interestedparties/" + ApplicationID, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(interestedparties => {
        if (interestedparties.length > 0) {
          this.setState({ interestedparties: interestedparties });
        } else {
          toast.error(interestedparties.message);
        }
      })
      .catch(err => {
        toast.error(err.message);
      });
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
  fetchTenderTypes = () => {
    fetch("/api/tendertypes", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(res => res.json())
      .then(TenderTypes => {
        if (TenderTypes.length > 0) {
          this.setState({ TenderTypes: TenderTypes });
        } else {
          toast.err(TenderTypes.message);
        }
      })
      .catch(err => {
        toast.err(err.message);
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
              this.fetchTenderTypes();
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
    this.fetchPaymentDetails(k.ID)
    this.fetchApplicationDocuments(k.ID);
    this.fetchTenderAdendums(k.TenderID);
    this.fetchBankSlips(k.ID);
    this.fetchAdditionalSubmisions(k.ID);
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
      AwardDate: new Date(k.AwardDate).toLocaleDateString(),
      FilingDate: new Date(k.FilingDate).toLocaleDateString(),
      TenderName: k.TenderName,
      Status: k.Status,
      TenderValue: k.TenderValue,
      TenderType: k.TenderType,
      TenderSubCategory: k.TenderSubCategory,
      TenderTypeDesc: k.TenderTypeDesc,
      TenderCategory: k.TenderCategory,
      PEID: k.PEID,
      Timer: k.Timer,
      PaymentStatus: k.PaymentStatus,
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
    this.fetchinterestedparties(k.ID);
  };

  showAttacmentstab = e => {
    e.preventDefault();
    document.getElementById("nav-Attachments-tab").click();
  };
  openFeesTab() {
    document.getElementById("nav-Fees-tab").click();
  }
  openInterestedPartiesTab() {
    document.getElementById("nav-InterestedParties-tab").click();
  }
  AddNewInterestedparty = () => {
    this.setState({ AddInterestedParty: true });
  };
  AddpaymentDetails = () => {
    this.setState({ ShowPaymentDetails: !this.state.ShowPaymentDetails });
  };
  SubmitApplication() {   
    fetch("/api/applications/"+this.state.ApplicationID, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-access-token": localStorage.getItem("token")
      }
    })
      .then(response =>
        response.json().then(data => {
          if (data.success) {
            swal("", "Your Application has been submited", "success");
            let applicantMsg =
              "Your Application with Reference:" +
              this.state.ApplicationNo +
              " has been Received";
            this.SendSMS(this.state.ApplicantPhone, applicantMsg);            
            this.setState({ profile:true });
            this.setState({ summary: false });
            this.setState({ openPaymentModal: false }); 
            this.setState({ Status: "Submited" });                        
            this.fetchMyApplications(this.state.ApplicantID);
          } else {
            toast.error(data.message);            
          }
        })
      )
      .catch(err => {
        toast.error(err.message);
       
      });
  }
  CompletedApplication = () => {
    if (this.state.ShowPaymentDetails) {
      this.SavePaymentdetails();    
      //this.SubmitApplication();
    } else {
      this.SubmitApplication();
    }
  };
  sendBulkNtification = (ApproversPhone, ApproversMail) => {
    let applicantMsg =
      "New request to approve application fees for Application with Reference No:" +
      this.state.ApplicationREf +
      " has been submited and is awaiting your review";
    this.SendSMS(ApproversPhone, applicantMsg);
    let ID1 = "Applicant";
    let ID2 = "FeesApprover";
    let subject1 = "APPLICATION ACKNOWLEDGEMENT";
    let subject2 = "APPLICATION FEES APPROVAL REQUEST";
    this.SendMail(this.state.ApplicationREf, ApproversMail, ID2, subject2);
    this.SendMail(
      this.state.ApplicationREf,
      this.state.ApplicantEmail,
      ID1,
      subject1
    );
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
            data.results.map((item, key) =>
              this.sendBulkNtification(item.ApproversPhone, item.ApproversMail)
            );
          }
        })
      )
      .catch(err => {
        toast.error(err.message);
       
      });
  };
  sendApproverNotification1 = () => {
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
  openRequestTab=()=> {
    if (this.state.TenderID) {
    document.getElementById("nav-profile-tab").click();
    }else{
      toast.error("Fill in tender details to proceed")
    }
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
    let TenderTypes = [...this.state.TenderTypes].map((k, i) => {
      return {
        value: k.Code,
        label: k.Description
      };
    });
    let TenderSubCategories = [
      {
        value: "Simple",
        label: "Simple"
      },
      {
        value: "Medium",
        label: "Medium"
      },
      {
        value: "Complex",
        label: "Complex"
      }
    ];
    let TenderCategories = [
      {
        value: "Pre-qualification",
        label: "Pre-qualification"
      },
      {
        value: "Unquantified Tenders",
        label: "Unquantified Tenders"
      },
      {
        value: "Other Tenders",
        label: "Other Tenders"
      }
    ];
    const ColumnData = [
      { label: "ApplicationNo", field: "ApplicationNo" },
      {
        label: "TenderName",
        field: "TenderName",
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
            <ToastContainer />
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
                        <span>
                            {this.state.PaymentStatus === "Not Submited" ?
                              <span className="text-danger">NOT PAID</span>: null
                            }
                            {this.state.PaymentStatus === "Approved" ?
                              <span className="text-success"> {this.state.Status}</span> : null
                            }
                            {this.state.PaymentStatus === "Submited" ?
                             <span className="text-warning">Payment Pending Confirmation</span>  : null
                            }
                        </span>
                      )}
                    </h2>
                  </li>
                </ol>
              </div>
              <div className="col-lg-2">
                <div className="row wrapper ">
                  
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
                      </tr>
                      <tr>
                        <td className="font-weight-bold">Date of Notification of Award/Occurrence of Breach: </td>
                        <td> {this.state.AwardDate}</td>
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
                      {this.state.ApplicationDocuments.map((k, i)=> {
                        return (
                          
                          k.Confidential ?
                           
                              this.checkDocumentRoles(k.Created_By) ?
                              <tr>
                                <td>{i + 1}</td>
                                <td>{k.Description}</td>
                                <td>{k.FileName}</td>
                                <td>
                                  {new Date(k.DateUploaded).toLocaleDateString()}
                                </td>
                                <td>
                                  <a
                                    onClick={e => ViewFile(k, e)}
                                    className="text-success"
                                  >
                                    <i class="fa fa-eye" aria-hidden="true"></i>View
                                  </a>
                                </td>
                              </tr>
                              :null
                         :
                            <tr>
                              <td>{i + 1}</td>
                              <td>{k.Description}</td>
                              <td>{k.FileName}</td>
                              <td>
                                {new Date(k.DateUploaded).toLocaleDateString()}
                              </td>
                              <td>
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
              <div className="row">
                <div className="col-lg-12 ">
                  <h3 style={headingstyle}>Interested Parties</h3>
                  <div className="col-lg-11 border border-success rounded">
                  <table className="table table-sm">
                    <th>Org Name</th>
                    <th>ContactName</th>
                    <th>Designation</th>
                    <th>Email</th>
                    <th>TelePhone</th>
                    <th>Mobile</th>
                    <th>PhysicalAddress</th>
                    {this.state.interestedparties.map((r, i) => (
                      <tr>
                        <td>{r.Name}</td>
                        <td> {r.ContactName} </td>
                        <td> {r.Designation} </td>
                        <td> {r.Email} </td>
                        <td> {r.TelePhone} </td>
                        <td> {r.Mobile} </td>
                        <td> {r.PhysicalAddress} </td>
                     
                      </tr>
                    ))}
                  </table>
                </div>
                </div>
              </div>
              <div className="row">
                <div className="col-lg-12 ">
                  <h3 style={headingstyle}>Fees</h3>
                  <div className="col-lg-11 border border-success rounded">
                    <div class="col-sm-8">
                      <h3 style={headingstyle}>Fees Details </h3>
                      <table class="table table-sm">
                        <thead>
                          <tr>
                            <th scope="col">#</th>
                            <th scope="col">Fees description</th>
                            <th scope="col">Amount</th>
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
                      {this.state.PaymentStatus ==="Not Submited"?
                        <h4>Fees Status: <span className="text-danger">NOT PAID</span> </h4>  :null
                     }
                      {this.state.PaymentStatus === "Approved" ?
                        <h4>Fees Status: <span className="text-success">PAID</span> </h4> : null
                      }
                      {this.state.PaymentStatus === "Submited" ?
                        <h4>Fees Status: <span className="text-warning">Payment Pending Confirmation</span> </h4> : null
                      }
                    </div>
                    <br/>
                    {this.state.PaymentStatus === "Submited" ? (
                      <div class="col-sm-8">
                        <h3 style={headingstyle}>Payment Details</h3>
                        <table class="table table-sm">
                          <thead>
                            <tr>
                              <th scope="col">Date paid</th>
                              <th scope="col">Amount</th>
                              <th scope="col">Refference</th>
                              <th scope="col">Paidby</th>
                            </tr>
                          </thead>
                          <tbody>
                            {this.state.PaymentDetails.map((r, i) => (
                              <tr>

                                <td> {new Date(r.DateOfpayment).toLocaleDateString()} </td>

                                <td>{this.formatNumber(r.AmountPaid)}</td>

                                <td>{r.Refference}</td>
                                <td>{r.Paidby}</td>

                              </tr>
                            ))}
                          </tbody>
                        </table>
                      </div>
                    ) : null}

                   
                    <br/>
                    <div className="row">
                      <div className="col-lg-10"></div>
                      <div className="col-lg-2">
                        {this.state.PaymentStatus === "Not Submited" ? (
                         
                            <button
                              type="button"
                            onClick={this.OpenPaymentModal}
                              className="btn btn-success"
                            >
                              PAY NOW
                      </button>                         
                        ) : null}&nbsp;&nbsp;
                     {this.state.Status === "Not Submited" ? (
                          <button
                            type="button"
                            onClick={this.EditApplication}
                            className="btn btn-primary"
                          >
                            EDIT
                    </button>
                        ) : null}
                         &nbsp; &nbsp;
                        <button
                          type="button"
                           onClick={this.GoBack}
                          className="btn btn-warning float-right"
                        >
                          Back
                  </button>
                      </div>
                    </div>
                    <br/>

                    <Modal visible={this.state.openPaymentModal} width="900" height="410" effect="fadeInUp" onClickAway={() => this.ClosePaymentModal()}>
                      <a style={{ float: "right", color: "red", margin: "10px" }} href="javascript:void(0);" onClick={() => this.ClosePaymentModal()}><i class="fa fa-close"></i></a>
                      <div>
                        <h4 style={{ "text-align": "center", color: "#1c84c6" }}>Payment Details</h4>
                        <div className="container-fluid">
                          <div className="col-sm-12">
                            <div className="ibox-content">
                              <div>  
                                                            
                                <div className="col-lg-12 border border-success rounded">
                                  <div style={FormStyle}>
                                    <div className=" row">
                                      <div className="col-md-6">
                                        <div className="row">
                                          <div className="col-md-4">
                                            <label
                                              htmlFor="exampleInputPassword1"
                                              className="font-weight-bold"
                                            >
                                              Amount Paid
                                        </label>
                                          </div>
                                          <div className="col-md-8">
                                            <input
                                              onChange={this.handleInputChange}
                                              value={this.state.AmountPaid}
                                              type="number"
                                              required
                                              name="AmountPaid"
                                              className="form-control"
                                            />
                                          </div>
                                        </div>
                                      </div>
                                      <div className="col-md-6">
                                        <div className="row">
                                          <div className="col-md-4">
                                            <label
                                              htmlFor="exampleInputPassword1"
                                              className="font-weight-bold"
                                            >
                                              Date of Payment
                                        </label>
                                          </div>
                                          <div className="col-md-8">
                                            <input
                                              onChange={this.handleInputChange}
                                              value={this.state.DateofPayment}
                                              type="date"
                                              required
                                              name="DateofPayment"
                                              className="form-control"
                                            />
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                    <br />
                                    <div className=" row">
                                      <div className="col-md-6">
                                        <div className="row">
                                          <div className="col-md-4">
                                            <label
                                              htmlFor="exampleInputPassword1"
                                              className="font-weight-bold"
                                            >
                                              Payment Reference
                                        </label>
                                          </div>
                                          <div className="col-md-8">
                                            <input
                                              onChange={this.handleInputChange}
                                              value={this.state.PaymentReference}
                                              type="text"
                                              required
                                              name="PaymentReference"
                                              className="form-control"
                                            />
                                          </div>
                                        </div>
                                      </div>
                                      <div className="col-md-6">
                                        <div className="row">
                                          <div className="col-md-4">
                                            <label
                                              htmlFor="exampleInputPassword1"
                                              className="font-weight-bold"
                                            >
                                              Paid By
                                        </label>
                                          </div>
                                          <div className="col-md-8">
                                            <input
                                              onChange={this.handleInputChange}
                                              value={this.state.PaidBy}
                                              type="text"
                                              required
                                              name="PaidBy"
                                              className="form-control"
                                            />
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                      <div className="col-md-6">
                                        <div className="row">
                                          <div className="col-md-4">
                                            <label
                                              htmlFor="exampleInputPassword1"
                                              className="font-weight-bold"
                                            >
                                              Payment slip
                                        </label>
                                          </div>
                                          <div className="col-md-8">
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
                                              onClick={this.UploadBankSlip}
                                            >
                                              Upload
                                        </button>
                                          </div>
                                        </div>
                                      </div>
                                      <div className="col-md-6">
                                        <table className="table table-sm">
                                          <th scope="col">Slip</th>
                                          <th scope="col">Action</th>
                                          {this.state.BankSlips.map((r, i) => (
                                            <tr>
                                              <td>{r.Name}</td>
                                              <td>
                                                <span>
                                                  <a
                                                    style={{ color: "#f44542" }}
                                                    onClick={e =>
                                                      this.handleDeleteBankSlip(
                                                        r.Name,
                                                        e
                                                      )
                                                    }
                                                  >
                                                    &nbsp; Remove
                                              </a>
                                                </span>
                                              </td>
                                            </tr>
                                          ))}
                                        </table>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <br/>
                                <div className="row">
                                  <div className="col-md-10">
                                  </div>
                                  <div className="col-md-2">
                                    <button type="button" onClick={this.SavePaymentdetails} className="btn btn-primary">Submit</button>&nbsp;
                                    <button type="button" className="btn btn-warning" onClick={this.ClosePaymentModal}>Close</button>
                                  </div>

                                </div>
                              </div> 
                             </div>
                          </div>
                        </div>

                      </div>
                    </Modal>


                  </div>
                </div>
              </div>

            </div>
          </div>
        );
      } else {
        return (
          <div>
            <ToastContainer />
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
          <ToastContainer />
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-11">
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
            <div className="col-lg-1">
              <div className="row wrapper ">
               
              </div>
            </div>
          </div>
          <p></p>
          <div style={divconatinerstyle}>
            
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
                      id="nav-InterestedParties-tab"
                      data-toggle="tab"
                      href="#nav-InterestedParties"
                      role="tab"
                      aria-controls="InterestedParties"
                      aria-selected="false"
                    >
                      Interested Parties
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
                          <div class="col-sm-1">
                            <label for="PEID" className="font-weight-bold">
                              Procuring Entity{" "}
                            </label>
                          </div>
                          <div class="col-sm-5">
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
                          <div class="col-sm-1">
                            <label
                              for="TenderName"
                              className="font-weight-bold"
                            >
                              Tender Name{" "}
                            </label>
                          </div>
                          <div class="col-sm-5">
                            <input
                              type="text"
                              class="form-control"
                              name="TenderName"
                              onChange={this.handleInputChange}
                              value={this.state.TenderName}
                              required
                            />
                          </div>
                        </div>
                        <div class="row">
                          <div class="col-sm-2">
                            <label for="TenderNo" className="font-weight-bold">
                              Tender Type
                            </label>
                          </div>
                          <div class="col-sm-4">
                            <Select
                              name="TenderType"
                              value={this.state.PEID}
                              value={TenderTypes.filter(
                                option => option.value === this.state.TenderType
                              )}
                              //defaultInputValue={this.state.TenderType}
                              onChange={this.handleSelectChange}
                              options={TenderTypes}
                              required
                            />
                          </div>
                          {this.state.Ascertainable ? (
                            <div class="col-sm-6">
                              <div className="row">
                                <div class="col-sm-2">
                                  <label
                                    for="TenderNo"
                                    className="font-weight-bold"
                                  >
                                    Tender Amount
                                  </label>
                                </div>
                                <div class="col-sm-10">
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
                            </div>
                          ) : null}

                          {this.state.Unascertainable ? (
                            <div class="col-sm-6">
                              <div className="row">
                                <div class="col-sm-2">
                                  <label
                                    for="TenderNo"
                                    className="font-weight-bold"
                                  >
                                    Category
                                  </label>
                                </div>
                                <div class="col-sm-4">
                                  <Select
                                    name="TenderCategory"
                                    value={TenderCategories.filter(
                                      option =>
                                        option.value ===
                                        this.state.TenderCategory
                                    )}
                                    onChange={this.handleSelectChange}
                                    options={TenderCategories}
                                  />
                                </div>
                                {this.state.ShowSubcategory ? (
                                  <div class="col-sm-6">
                                    <div className="row">
                                      <div class="col-sm-4">
                                        <label
                                          for="TenderNo"
                                          className="font-weight-bold"
                                        >
                                          Sub-Category
                                        </label>
                                      </div>
                                      <div class="col-sm-8">
                                        <Select
                                          name="TenderSubCategory"
                                          value={TenderSubCategories.filter(
                                            option =>
                                              option.value ===
                                              this.state.TenderSubCategory
                                          )}
                                          onChange={this.handleSelectChange}
                                          options={TenderSubCategories}
                                        />
                                      </div>
                                    </div>
                                  </div>
                                ) : null}
                              </div>
                            </div>
                          ) : null}
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
                              Date of Notification of Award/Occurrence of Breach
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
                        <br />

                        <p></p>
                        <div className=" row">
                            <div className="col-sm-9" />
                          <div className="col-sm-1">
                            <button
                              type="submit"
                              className="btn btn-primary float-right"
                            >
                              Save
                            </button>
                          </div>
                          <div className="col-sm-2">
                            {this.state.AddAdedendums ? null : (
                              <div>
                                <button
                                  type="button"
                                  onClick={this.openRequestTab}
                                  className="btn btn-success"
                                >
                                  {" "}
                                  &nbsp; Next
                              </button>
                                &nbsp;&nbsp;
                            <button
                                  type="button"
                                  onClick={this.handleswitchMenu}
                                  className="btn btn-warning"
                                >
                                  &nbsp; Close
                          </button>
                              </div>

                            
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
                                <div>
                                  <button
                                    type="button"
                                    onClick={this.openRequestTab}
                                    className="btn btn-success"
                                  >
                                    {" "}
                                    Next
                                </button>
&nbsp; &nbsp; 
                                  <button
                                    type="button"
                                    onClick={this.handleswitchMenu}
                                    className="btn btn-warning"
                                  >
                                    Close
                          </button>
                                </div>
                                
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
                            <div className="col-sm-10"></div>
                            <div className="col-sm-2">
                              <button
                                className="btn btn-success"
                                onClick={this.showAttacmentstab}
                              >
                                Next &nbsp;
                              </button>
                              &nbsp;&nbsp;
                            <button
                                type="button"
                                onClick={this.handleswitchMenu}
                                className="btn btn-warning"
                              >
                                &nbsp; Close
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
                          <div className="col-sm-2">
                            <div className="form-group">
                              <br />
                              <br />
                              <input
                                className="checkbox"
                                id="Confidential"
                                type="checkbox"
                                name="Confidential"
                                defaultChecked={this.state.Confidential}
                                onChange={this.handleInputChange}
                              />{" "}
                              <label
                                htmlFor="Confidential"
                                className="font-weight-bold"
                              >
                                Confidential
                                  </label>
                            </div>
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
                          <div class="col-sm-10"></div>
                          <div class="col-sm-2">
                            <button
                              type="button"
                              onClick={this.openInterestedPartiesTab}
                              className="btn btn-success "
                            >
                              {" "}
                              &nbsp; Next
                            </button>&nbsp;&nbsp;
                            <button
                              type="button"
                              onClick={this.handleswitchMenu}
                              className="btn btn-warning"
                            >
                              &nbsp; Close
                          </button>
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>

                  <div
                    class="tab-pane fade"
                    id="nav-InterestedParties"
                    role="tabpanel"
                    style={childdiv}
                    aria-labelledby="nav-InterestedParties-tab"
                  >
                    <Modal
                      visible={this.state.AddInterestedParty}
                      width="900"
                      height="450"
                      effect="fadeInUp"
                      onClickAway={() => this.closeAddInterestedParty()}
                    >
                      <a
                        style={{ float: "right", color: "red", margin: "10px" }}
                        href="javascript:void(0);"
                        onClick={() => this.closeAddInterestedParty()}
                      >
                        <i class="fa fa-close"></i>
                      </a>
                      <div>
                        <h4
                          style={{ "text-align": "center", color: "#1c84c6" }}
                        >
                          Interested Party
                        </h4>
                        <div className="container-fluid">
                          <div className="col-sm-12">
                            <div className="ibox-content">
                              <form onSubmit={this.handleInterestedPartySubmit}>
                                <div className=" row">
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Organization Name
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={this.state.InterestedPartyName}
                                          type="text"
                                          required
                                          name="InterestedPartyName"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Contact Name
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={
                                            this.state
                                              .InterestedPartyContactName
                                          }
                                          type="text"
                                          required
                                          name="InterestedPartyContactName"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <br />
                                <div className=" row">
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Designation
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={
                                            this.state
                                              .InterestedPartyDesignation
                                          }
                                          type="text"
                                          required
                                          name="InterestedPartyDesignation"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Email
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={
                                            this.state.InterestedPartyEmail
                                          }
                                          type="email"
                                          required
                                          name="InterestedPartyEmail"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <br />
                                <div className=" row">
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Mobile
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={
                                            this.state.InterestedPartyMobile
                                          }
                                          type="number"
                                          required
                                          name="InterestedPartyMobile"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          TelePhone
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={
                                            this.state.InterestedPartyTelePhone
                                          }
                                          type="number"
                                          required
                                          name="InterestedPartyTelePhone"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <br />
                                <div className=" row">
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          POBox
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={
                                            this.state.InterestedPartyPOBox
                                          }
                                          type="number"
                                          required
                                          name="InterestedPartyPOBox"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Postal Code
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={
                                            this.state.InterestedPartyPostalCode
                                          }
                                          type="text"
                                          required
                                          name="InterestedPartyPostalCode"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <br />

                                <div className=" row">
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Physical Address
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={
                                            this.state
                                              .InterestedPartyPhysicalAddress
                                          }
                                          type="text"
                                          required
                                          name="InterestedPartyPhysicalAddress"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Town
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={this.state.InterestedPartyTown}
                                          type="text"
                                          required
                                          name="InterestedPartyTown"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <br />
                                <div className="col-sm-12 ">
                                  <div className=" row">
                                    <div className="col-sm-9" />
                                    <div className="col-sm-3">
                                      <button
                                        type="submit"
                                        className="btn btn-primary"
                                      >
                                        Save
                                      </button>
                                      &nbsp; &nbsp;
                                      <button
                                        type="button"
                                        className="btn btn-danger"
                                        onClick={this.closeAddInterestedParty}
                                      >
                                        Close
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

                    <div style={formcontainerStyle}>
                      <div style={FormStyle}>
                        <h3 style={headingstyle}>Interested Parties</h3>

                        <div className="row">
                          <div class="col-sm-11">
                            <table className="table table-sm">
                              <th>Org Name</th>
                              <th>ContactName</th>
                              <th>Designation</th>
                              <th>Email</th>
                              <th>TelePhone</th>
                              <th>Mobile</th>
                              <th>PhysicalAddress</th>
                              <th>Actions</th>

                              {this.state.interestedparties.map((r, i) => (
                                <tr>
                                  <td>{r.Name}</td>
                                  <td> {r.ContactName} </td>
                                  <td> {r.Designation} </td>
                                  <td> {r.Email} </td>
                                  <td> {r.TelePhone} </td>
                                  <td> {r.Mobile} </td>
                                  <td> {r.PhysicalAddress} </td>
                                  <td>
                                    {" "}
                                    <span>
                                      <a
                                        style={{ color: "#f44542" }}
                                        onClick={e =>
                                          this.handleDeleteInterestedparty(r, e)
                                        }
                                      >
                                        &nbsp; Remove
                                      </a>
                                      {/* {this.state.alert} */}
                                    </span>
                                  </td>
                                </tr>
                              ))}
                            </table>
                          </div>
                        </div>
                        <div className=" row">
                          <div className="col-sm-9" />
                          <div className="col-sm-3">
                            <button
                              className="btn btn-primary"
                              onClick={this.AddNewInterestedparty}
                            >
                              ADD
                            </button>
                            &nbsp;
                            <button
                              type="button"
                              onClick={this.openFeesTab}
                              className="btn btn-success"
                            >
                              {" "}
                              &nbsp; Next
                            </button>
                            &nbsp;&nbsp;
                            <button
                              type="button"
                              onClick={this.handleswitchMenu}
                              className="btn btn-warning"
                            >
                              &nbsp; Close
                          </button>
                          </div>
                        </div>
                        <br />
                      </div>
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
                        <div className="col-lg-12 border border-success rounded">
                          <div className="row">
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
                                      {this.formatNumber(
                                        this.state.TotalAmountdue
                                      )}
                                    </th>
                                  </tr>
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>

                        {this.state.ShowPaymentDetails ? (
                          <div>
                            <h3 style={headingstyle}>Payment Details</h3>
                            <div className="col-lg-12 border border-success rounded">
                              <div style={FormStyle}>
                                <div className=" row">
                                  <div className="col-md-5">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Amount Paid
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={this.state.AmountPaid}
                                          type="number"
                                          required
                                          name="AmountPaid"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-5">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Date of Payment
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={this.state.DateofPayment}
                                          type="date"
                                          required
                                          name="DateofPayment"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <br />
                                <div className=" row">
                                  <div className="col-md-5">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Payment Reference
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={this.state.PaymentReference}
                                          type="text"
                                          required
                                          name="PaymentReference"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-5">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Paid By
                                        </label>
                                      </div>
                                      <div className="col-md-8">
                                        <input
                                          onChange={this.handleInputChange}
                                          value={this.state.PaidBy}
                                          type="text"
                                          required
                                          name="PaidBy"
                                          className="form-control"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <br />
                                <div class="row">
                                  <div className="col-md-5">
                                    <div className="row">
                                      <div className="col-md-4">
                                        <label
                                          htmlFor="exampleInputPassword1"
                                          className="font-weight-bold"
                                        >
                                          Payment slip
                                        </label>
                                      </div>
                                      <div className="col-md-8">
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
                                          onClick={this.UploadBankSlip}
                                        >
                                          Upload
                                        </button>
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-5">
                                    <table className="table table-sm">
                                      <th scope="col">Slip</th>
                                      <th scope="col">Action</th>
                                      {this.state.BankSlips.map((r, i) => (
                                        <tr>
                                          <td>{r.Name}</td>
                                          <td>
                                            <span>
                                              <a
                                                style={{ color: "#f44542" }}
                                                onClick={e =>
                                                  this.handleDeleteBankSlip(
                                                    r.Name,
                                                    e
                                                  )
                                                }
                                              >
                                                &nbsp; Remove
                                              </a>
                                            </span>
                                          </td>
                                        </tr>
                                      ))}
                                    </table>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        ) : null}

                        <br />
                        <div className=" row">
                          <div className="col-sm-8" />
                          <div className="col-sm-4">
                            <button
                              className="btn btn-success"
                              onClick={this.AddpaymentDetails}
                            >
                              Already paid
                            </button>
                            &nbsp;&nbsp;
                            <button
                              className="btn btn-primary"
                              onClick={this.CompletedApplication}
                            >
                              SUBMIT FOR REVIEW
                            </button>
                             &nbsp;&nbsp;
                            <button
                              type="button"
                              onClick={this.handleswitchMenu}
                              className="btn btn-warning"
                            >
                              &nbsp; Close
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
