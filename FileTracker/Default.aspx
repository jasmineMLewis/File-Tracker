<%@ Page Title="" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false"
    CodeBehind="Default.aspx.vb" Inherits="FileTracker._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
        <div class="container">
            <a class="navbar-brand" href="#page-top"><i>File Tracker</i></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
                aria-expanded="false" aria-label="Toggle navigation">
                Menu
                    <i class="fas fa-bars ms-1"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                    <li class="nav-item"><a class="nav-link" href="#services"><i class="fa fa-server"></i>&nbsp; Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="#features"><i class="fa fa-cog"></i>&nbsp; Features</a></li>
                    <li class="nav-item">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                            data-bs-target="#loginModal">
                            <i class="fa fa-sign-in"></i>&nbsp;  Login
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Masthead-->
    <header class="masthead">
        <div class="container">
            <div class="masthead-subheading">Housing Authority of New Orleans</div>
            <div class="masthead-heading text-uppercase">File Tracker</div>
            <a class="btn btn-primary btn-xl text-uppercase" href="#services"><i class="fa fa-server"></i>&nbsp; Learn More</a>
        </div>
    </header>

    <!-- Services-->
    <section class="page-section" id="services">
        <div class="container">
            <div class="text-center">
                <h2 class="section-heading text-uppercase"><i class="fa fa-server"></i>&nbsp; Services</h2>
                <h3 class="section-subheading text-muted">Document requested and destroyed files</h3>
            </div>
            <div class="row text-center">
                <div class="col-md-3">
                    <span class="fa-stack fa-4x">
                        <i class="fas fa-circle fa-stack-2x text-primary"></i>
                        <i class="fas fa-file fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="my-3">Files</h4>
                    <p class="text-muted">
                        Maintain accurate record of destroyed files.
                    </p>
                </div>
                <div class="col-md-3">
                    <span class="fa-stack fa-4x">
                        <i class="fas fa-circle fa-stack-2x text-primary"></i>
                        <i class="fas fa-archive fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="my-3">Boxes</h4>
                    <p class="text-muted">
                        Maintain count and traction for location of files in boxes.
                    </p>
                </div>
                <div class="col-md-3">
                    <span class="fa-stack fa-4x">
                        <i class="fas fa-circle fa-stack-2x text-primary"></i>
                        <i class="fas fa-users fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="my-3">Users</h4>
                    <p class="text-muted">
                        Manage users who have access to the system.
                    </p>
                </div>
                <div class="col-md-3">
                    <span class="fa-stack fa-4x">
                        <i class="fas fa-circle fa-stack-2x text-primary"></i>
                        <i class="fas fa-envelope fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="my-3">Requests</h4>
                    <p class="text-muted">
                        Solicit files needed for clients and inspection.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Feature Grid-->
    <section class="page-section bg-warning" id="features">
        <div class="container">
            <div class="text-center">
                <h2 class="section-heading text-uppercase"><i class="fa fa-cog"></i>&nbsp; Features</h2>
                <h3 class="section-subheading text-muted">List of specific components</h3>
            </div>
            <div class="row">
                <!-- Feature Item 1-->
                <div class="col-lg-4 col-sm-6 mb-4 text-center">
                    <div class="feature-item">
                        <a class="feature-link" data-bs-toggle="modal" href="#featureModalOne">
                            <img class="img-fluid" src="/Images/features/feature-files.png" alt="Files" />
                        </a>
                        <div class="feature-caption text-center" style="background-color: #fff;">
                            <h3>Files</h3>
                            <div class="feature-caption-subheading text-muted">File Features</div>
                        </div>
                    </div>
                </div>

                <!-- Feature Item 2-->
                <div class="col-lg-4 col-sm-6 mb-4 text-center">
                    <div class="feature-item">
                        <a class="feature-link" data-bs-toggle="modal" href="#featureModalTwo">
                            <img class="img-fluid" src="/Images/features/feature-boxes.jpg" alt="Files" />
                        </a>
                        <div class="feature-caption text-center" style="background-color: #fff;">
                            <h3>Boxes</h3>
                            <div class="feature-caption-subheading text-muted">Box Features</div>
                        </div>
                    </div>
                </div>

                <!-- Feature Item 3 -->
                <div class="col-lg-4 col-sm-6 mb-4 text-center">
                    <div class="feature-item">
                        <a class="feature-link" data-bs-toggle="modal" href="#featureModalThree">
                            <img class="img-fluid" src="/Images/features/feature-request.jpg" alt="Files" />
                        </a>
                        <div class="feature-caption text-center" style="background-color: #fff;">
                            <h3>Requests</h3>
                            <div class="feature-caption-subheading text-muted">Request Features</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <!-- Empty Feature Item -->
                <div class="col-lg-4 col-sm-6 mb-4 text-center">
                </div>

                <!-- Feature Item 4 -->
                <div class="col-lg-4 col-sm-6 mb-4 text-center">
                    <div class="feature-item">
                        <a class="feature-link" data-bs-toggle="modal" href="#featureModalFour">
                            <img class="img-fluid" src="/Images/features/feature-users.png" alt="Files" />
                        </a>
                        <div class="feature-caption text-center" style="background-color: #fff;">
                            <h3>Users</h3>
                            <div class="feature-caption-subheading text-muted">User Features</div>
                        </div>
                    </div>
                </div>

                <!-- Empty Feature Item -->
                <div class="col-lg-4 col-sm-6 mb-4 text-center">
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer py-4">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-4 text-lg-start">Copyright &copy; 2019</div>
                <div class="col-lg-4 my-3 my-lg-0">
                    <img class="img-fluid" src="./Images/hano-logo.png" alt="HANO" />
                </div>
                <div class="col-lg-4 text-lg-end">
                </div>
            </div>
        </div>
    </footer>
    <%--    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <img class="img-fluid" src="./Images/hano-logo.png" alt="HANO" />
                </div>
            </div>
        </div>
    </footer>--%>

    <!-- Login Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginaModalLabel"
        aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="loginForm" runat="server" action="">
                    <div class="modal-body">
                       
                        <div class="row">
                            <div class="input-group mb-3">
  <span class="input-group-text" id="basic-addon1">@</span>
  <input type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
</div>

                        </div>
                      <%--      <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon1"><i class="fa fa-envelope"></i></span>
                                                         <input type="text" class="form-control" id="email" name="email" placeholder="Email" required="required" />

                            </div>--%>
                        

                        <%-- <div class="input-group input-group-md">
                                <div class="input-group-addon">
                                    <i class="fa fa-envelope"></i>
                                </div>
                                <input type="text" class="form-control" id="email" name="email" placeholder="Email"
                                    required="required" />
                            </div>--%>
                        <%--<p></p>--%>
<%--                        <div class="input-group input-group-md">
                            <div class="input-group-addon">
                                <i class="fa fa-key"></i>
                            </div>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password"
                                required="required" />
                        </div>--%>
                    </div>
                </form>
                                     <div class="modal-footer">
              <button id="buttonLogin" type="button" class="btn btn-primary" runat="server"
                  onserverclick="btnLogin">
                  <i class="fa fa-sign-in"></i>&nbsp; Login
              </button>
              <button id="buttonClose" type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                  <i class="fa fa-ban"></i>&nbsp Close
              </button>
              <asp:Label ID="lblMsg" runat="server" Style="font-size: 14px; font-weight: 700; color: #1A926A"
                  EnableViewState="False">
              </asp:Label>
          </div>
            </div>
  
        </div>
    </div>

    <!-- Feature Modals-->
    <!-- Feature Item 1:Files Modal -->
    <div class="feature-modal modal fade" id="featureModalOne" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <div class="container">
                    <div class="modal-body">
                        <h2 class="text-uppercase">Files</h2>
                        <p class="item-intro text-muted">
                            Maintain accurate record of destroyed files.
                        </p>
                        <div class="row">
                            <div class="col-md-4">
                                <h3>
                                    <i class="fa-solid fa-file"></i>Create <i class="fa-solid fa-file"></i>
                                </h3>
                                <ul>
                                    <li>Only create Files for Purging</li>
                                    <li>File Information must contain:
                                            <ul>
                                                <li>First & Last Name, Last Four of SSN</li>
                                                <li>Purge Type & Date</li>
                                                <li>Box</li>
                                                <li>Location</li>
                                                <li>Notes</li>
                                            </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h3>
                                    <i class="fa-regular fa-calendar-days"></i>Purge Type <i class="fa-regular fa-calendar-days"></i>
                                </h3>
                                <ul>
                                    <li>How Client left HCV Program
                                            <ul>
                                                <li>EOP | Denial/Withdrawal | Port Out</li>
                                            </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h3>
                                    <i class="fa-solid fa-warehouse"></i>Location <i class="fa-solid fa-warehouse"></i>
                                </h3>
                                <ul>
                                    <li>Where the File is Located
                                        <ul>
                                            <li>On Site | Warehouse | Unknown</li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                            <i class="fas fa-xmark me-1"></i>
                            Close Project
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Feature Item 2:Boxes Modal -->
    <div class="feature-modal modal fade" id="featureModalTwo" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <div class="container">
                    <div class="modal-body">
                        <h2 class="text-uppercase">Boxes</h2>
                        <p class="item-intro text-muted">
                            Maintain count and traction for location of files in boxes.
                        </p>
                        <div class="row">
                            <div class="col-md-4">
                                <h3>
                                    <i class="fa-solid fa-boxes-stacked"></i>Create <i class="fa-solid fa-boxes-stacked"></i>
                                </h3>
                                <ul>
                                    <li>Only create Boxes for Purging</li>
                                    <li>Box Information must contain:
                               <ul>
                                   <li>Box Number</li>
                                   <li>Year</li>
                                   <li>Anticipated Delivery Date to Warehouse</li>
                                   <li>Location</li>
                               </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h3>
                                    <i class="fa-solid fa-shop"></i>Info <i class="fa-solid fa-shop"></i>
                                </h3>
                                <ul>
                                    <li>Update Box Information</li>
                                    <li>View Files in Boxes</li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h3>
                                    <i class="fa-solid fa-location-dot"></i>Location <i class="fa-solid fa-location-dot"></i>
                                </h3>
                                <ul>
                                    <li>Where the Box is Located
                           <ul>
                               <li>On Site | Warehouse | Unknown</li>
                           </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                            <i class="fas fa-xmark me-1"></i>
                            Close Project
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Feature Item 3:Requests Modal -->
    <div class="feature-modal modal fade" id="featureModalThree" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <div class="container">
                    <div class="modal-body">
                        <h2 class="text-uppercase">Requests</h2>
                        <p class="item-intro text-muted">
                            Solicit files needed for clients and inspection.
                        </p>
                        <div class="row">
                            <div class="col-md-3">
                                <h3>
                                    <i class="fa-solid fa-newspaper"></i>Create <i class="fa-solid fa-newspaper"></i>
                                </h3>
                                <ul>
                                    <li>Create a Request for a File
                           <ul>
                               <li>Client First & Last name | Last Four of SSN </li>
                           </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-3">
                                <h3>
                                    <i class="fa-solid fa-tag"></i>Check Out <i class="fa-solid fa-tag"></i>
                                </h3>
                                <ul>
                                    <li>Indication that the user has received the File</li>
                                </ul>
                            </div>
                            <div class="col-md-3">
                                <h3>
                                    <i class="fa-solid fa-envelope"></i>Request <i class="fa-solid fa-envelope"></i>
                                </h3>
                                <ul>
                                    <li>Indication to File Clerk for Pick Up</li>
                                </ul>
                            </div>
                            <div class="col-md-3">
                                <h3>
                                    <i class="fa-solid fa-paperclip"></i>Check In <i class="fa-solid fa-paperclip"></i>
                                </h3>
                                <ul>
                                    <li>Indication the user has given the File to Clerk</li>
                                </ul>
                            </div>
                        </div>
                        <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                            <i class="fas fa-xmark me-1"></i>
                            Close Project
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Feature Item 4:Users Modal -->
    <div class="feature-modal modal fade" id="featureModalFour" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <div class="container">
                    <div class="modal-body">
                        <h2 class="text-uppercase">Users</h2>
                        <p class="item-intro text-muted">
                            Manage users who have access to the system.
                        </p>
                        <div class="row">
                            <div class="col-md-6">
                                <h3>
                                    <i class="fa-solid fa-folder-open"></i>File Room Clerk <i class="fa-solid fa-folder-open"></i>
                                </h3>
                                <ul>
                                    <li>View Requests from all Users</li>
                                    <li>Export Requests to Excel</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h3>
                                    <i class="fa-solid fa-house-user"></i>Housing Specialist <i class="fa-solid fa-house-user"></i>
                                </h3>
                                <ul>
                                    <li>Create a Request</li>
                                    <li>Check Out, Request Pick Up and Check In for Requests
                                    </li>
                                </ul>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <h3>
                                    <i class="fa-solid fa-flask"></i>Project Specialist <i class="fa-solid fa-flask"></i>
                                </h3>
                                <ul>
                                    <li>Create Files to be Purge</li>
                                    <li>Create Boxes for Files that will be Purged</li>
                                    <li>Create a Request</li>
                                    <li>Check Out, Request Pick Up and Check In for Requests</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h3>
                                    <i class="fa-solid fa-user-secret"></i>Admin <i class="fa-solid fa-user-secret"></i>
                                </h3>
                                <ul>
                                    <li>All Aforementioned Features</li>
                                    <li>Create & Edit User</li>
                                </ul>
                            </div>
                        </div>
                        <button class="btn btn-primary btn-xl text-uppercase" data-bs-dismiss="modal" type="button">
                            <i class="fas fa-xmark me-1"></i>
                            Close Project
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
