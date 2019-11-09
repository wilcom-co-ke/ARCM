import React, { Component } from "react";
import swal from "sweetalert";
import Chart from "react-google-charts";
class PEAppearanceFrequencyPerCategory extends Component {
  constructor() {
    super();
    this.state = {
      Applications: [],
      FromDate: "",
      Todate: "",
      Data: [],
      All: false
    };

    this.Downloadfile = this.Downloadfile.bind(this);
  }
  handleInputChange = event => {
    // event.preventDefault();
    // this.setState({ [event.target.name]: event.target.value });
    const target = event.target;
    const value = target.type === "checkbox" ? target.checked : target.value;
    const name = target.name;
    this.setState({ [name]: value, Data: [] });
  };
  fetchApplications = () => {
    fetch("/api/Applications", {
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
  PrintFile = () => {
    let filepath = process.env.REACT_APP_BASE_URL + "/Cases/" + this.state.File;
    window.open(filepath);
  };
  formatNumber = num => {
    let newtot = Number(num).toFixed(2);
    return newtot.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
  };

  Downloadfile = () => {
    this.setState({ FilePath: "" });
    if (this.state.FromDate) {
      fetch(
        "/api/ExecutiveReports/" +
          this.state.FromDate +
          "/" +
          this.state.Todate +
          "/" +
          +this.state.All,
        {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "x-access-token": localStorage.getItem("token")
          }
        }
      )
        .then(res => res.json())
        .then(Applications => {
          if (Applications.length > 0) {
            this.setState({ Data: Applications });
          } else {
            swal("", Applications.message, "error");
          }
        })
        .catch(err => {
          swal("", err.message, "error");
        });
    } else {
      swal("", "Select Date to Continue", "error");
    }
  };

  render() {
    let FormStyle = {
      margin: "20px"
    };
    const data = [["PE Category", "Frequency"]];
    [...this.state.Data].map((k, i) => {
      let d = [k.PEDesc, k.Count];
      data.push(d);
    });

    return (
      <div>
        <div>
          <div className="row wrapper border-bottom white-bg page-heading">
            <div className="col-lg-9">
              <ol className="breadcrumb">
                <li className="breadcrumb-item">
                  <h2>PE Appearance Frequency Per Category</h2>
                </li>
              </ol>
            </div>
          </div>
        </div>

        <div>
          <br />
          <div className="row">
            <div className="col-lg-1"></div>
            <div className="col-lg-10 border border-success rounded bg-white">
              <div style={FormStyle}>
                <div class="row">
                  <div class="col-sm-1">
                    <label for="ApplicantID" className="font-weight-bold ">
                      From Date{" "}
                    </label>
                  </div>

                  <div class="col-sm-3">
                    <div className="form-group">
                      <input
                        onChange={this.handleInputChange}
                        value={this.state.FromDate}
                        type="date"
                        required
                        name="FromDate"
                        className="form-control"
                      />
                    </div>
                  </div>
                  <div class="col-sm-1">
                    <label for="ApplicantID" className="font-weight-bold ">
                      To Date{" "}
                    </label>
                  </div>

                  <div class="col-sm-3">
                    <div className="form-group">
                      <input
                        onChange={this.handleInputChange}
                        value={this.state.Todate}
                        type="date"
                        required
                        name="Todate"
                        className="form-control"
                      />
                    </div>
                  </div>

                  <div class="col-sm-1">
                    <p></p>
                    <input
                      className="checkbox"
                      id="All"
                      type="checkbox"
                      name="All"
                      defaultChecked={this.state.All}
                      onChange={this.handleInputChange}
                    />{" "}
                    <label htmlFor="All" className="font-weight-bold">
                      All
                    </label>
                  </div>
                  <div class="col-sm-1">
                    <button
                      onClick={this.Downloadfile}
                      className="btn btn-primary"
                      type="button"
                    >
                      Generate
                    </button>
                  </div>
                  <div class="col-sm-1">
                    <button
                      onClick={this.PrintFile}
                      className="btn btn-success"
                      type="button"
                    >
                      Print
                    </button>
                  </div>
                </div>
                <hr />
                <br />
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
                        Bar Chart{" "}
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
                        Table View
                      </a>
                    </div>
                  </nav>
                  <div class="tab-content " id="nav-tabContent">
                    <div
                      class="tab-pane fade show active"
                      id="nav-home"
                      role="tabpanel"
                      aria-labelledby="nav-home-tab"
                    >
                      <br />
                      {this.state.Data.length > 0 ? (
                        <div className="App">
                          <Chart
                            chartType="Bar"
                            width="100%"
                            height="400px"
                            data={data}
                            loader={<div>Loading Chart</div>}
                            options={{
                              // Material design options
                              chart: {
                                title: "PE Appearance Frequency Per Category"
                              }
                            }}
                          />
                        </div>
                      ) : null}
                    </div>
                    <div
                      class="tab-pane fade"
                      id="nav-profile"
                      role="tabpanel"
                      aria-labelledby="nav-profile-tab"
                    >
                      <br />
                      <h3>PE Appearance Frequency Per Category</h3>
                      <table className="table table-borderless table-sm">
                        <thead className="thead-light">
                          <th>No</th>
                          <th>PE Category</th>
                          <th>Frequency</th>
                        </thead>
                        {this.state.Data.map((r, i) => (
                          <tr>
                            <td className="font-weight-bold">{i + 1}</td>

                            <td className="font-weight-bold">{r.PEDesc}</td>
                            <td className="font-weight-bold">{r.Count}</td>
                          </tr>
                        ))}
                      </table>
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

export default PEAppearanceFrequencyPerCategory;
