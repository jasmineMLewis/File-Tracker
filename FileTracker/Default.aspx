<%@ Page Title="" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false"
    CodeBehind="Default.aspx.vb" Inherits="FileTracker._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
        <div class="container">
            <a class="navbar-brand" href="#page-top">File Tracker</a>
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

            </div>
        </div>
    </section>


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
                        <div class="col-lg-12">
                            <div class="input-group input-group-md">
                                <div class="input-group-addon">
                                    <i class="fa fa-envelope"></i>
                                </div>
                                <input type="text" class="form-control" id="email" name="email" placeholder="Email"
                                    required="required" />
                            </div>
                            <p></p>
                            <div class="input-group input-group-md">
                                <div class="input-group-addon">
                                    <i class="fa fa-key"></i>
                                </div>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password"
                                    required="required" />
                            </div>
                        </div>
                    </div>
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
                </form>
            </div>
        </div>
    </div>


    <!-- Feature Modals-->
    <!-- Feature Item 1 Modal Popup-->
    <div class="feature-modal modal fade" id="featureModalOne" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <div class="container">
                    <div class="modal-body">
                        <h2 class="text-uppercase">Files</h2>
                        <p class="item-intro text-muted">Maintain accurate record of destroyed files.</p>
                        <div class="row">
                            <div class="col-md-4">
                                <h3><i class="fa-solid fa-clipboard"></i> Create <i class="fa-solid fa-clipboard"></i></h3>
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
                                <h3>Purge Type <i class="fa-regular fa-calendar-days"></i></h3>
                                <ul>
                                    <li>How Client left HCV Program
                                            <ul>
                                                <li>EOP | Denial/Withdrawal |Port Out</li>
                                            </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h3>Location <i class="fa-solid fa-warehouse"></i></h3>
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

    <!-- Feature Modals-->
    <!-- Feature Item 2 Modal Popup-->
    <div class="feature-modal modal fade" id="featureModalTwo" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <div class="container">
                    <div class="modal-body">
                        <h2 class="text-uppercase">Boxes</h2>
                        <p class="item-intro text-muted">Maintain count and traction for location of files in boxes.</p>
                        <div class="row">
                            <%--                         <div class="col-md-4">
                             <h3>Create <i class="fa-solid fa-clipboard"></i></h3>
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
                         </div>--%>
                            <%--                         <div class="col-md-4">
                             <h3>Purge Type <i class="fa-regular fa-calendar-days"></i></h3>
                             <ul>
                                 <li>How Client left HCV Program
                                         <ul>
                                             <li>EOP | Denial/Withdrawal |Port Out</li>
                                         </ul>
                                 </li>
                             </ul>
                         </div>--%>
                            <%--<div class="col-md-4">
                             <h3>Location <i class="fa-solid fa-warehouse"></i></h3>
                             <ul>
                                 <li>Where the File is Located
                                     <ul>
                                         <li>On Site | Warehouse | Unknown</li>
                                     </ul>
                                 </li>
                             </ul>
                         </div>--%>
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
