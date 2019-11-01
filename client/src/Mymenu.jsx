import React, { Component } from "react";
import { Link } from "react-router-dom";

class Mymenu extends Component {
  constructor() {
    super();
    this.state = {
      loading: true,
      redirect: true,
      profile: "",
      CompanyDetails: [],
      Logo: ""
    };
  }
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
          this.setState({ CompanyDetails: data });
          this.setState({ Logo: data[0].Logo });
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
  render() {
    let photostyle = {
      height: 130,
      width: 170,
      background: "#a7b1c2",
      margin: 10,
      "border-radius": 20
    };
    let UserCategory = localStorage.getItem("UserCategory");
    return (
      <nav className="navbar-default navbar-static-side" role="navigation">
        <div className="sidebar-collapse">
          <ul className="nav metismenu" id="side-menu">
            <li className="">
              <div className="dropdown profile-element">
                <img
                  className="rounded-circle"
                  src={
                    process.env.REACT_APP_BASE_URL +
                    "/profilepics/" +
                    this.state.Logo
                  }
                  style={photostyle}
                />
              </div>
            </li>

            <li className="active">
              <a href="">
                <i className="fa fa-th-large" />
                <span className="nav-label active">My menu</span>
                <span className="fa arrow" />
              </a>
              <ul className="nav nav-second-level collapse">
                <li className="active">
                  <Link to="/ApplicantProfile">My Details</Link>
                </li>
                {UserCategory === "Applicant" ? (
                  <li>
                    <Link to="/Applications">Applications</Link>
                  </li>
                ) : (
                  <li>
                    <Link to="/PEApplications">Applications</Link>
                  </li>
                )}
                {UserCategory === "Applicant" ? (
                  <li>
                    <Link to="/additionalsubmissions">
                      Additional submissions
                    </Link>
                  </li>
                ) : (
                  <li>
                    <Link to="/PEadditionalsubmissions">
                      Additional submissions
                    </Link>
                  </li>
                )}
                {UserCategory === "PE" ? (
                  <li>
                    <Link to="/MyResponse">Response</Link>
                  </li>
                ) : null}
                {UserCategory === "Applicant" ? (
                  <li>
                    <Link to="/CaseWithdrawal">Case Withdrawal</Link>
                  </li>
                ) : null}
                {UserCategory === "Applicant" ? (
                  <li>
                    <Link to="/adjournment">Case adjournment</Link>
                  </li>
                ) : null}
              </ul>
            </li>
          </ul>
        </div>
      </nav>
    );
  }
}

export default Mymenu;
