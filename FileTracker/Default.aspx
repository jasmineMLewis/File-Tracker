<%@ Page Title="" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false"
    CodeBehind="Default.aspx.vb" Inherits="FileTracker._Default" %>


<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
 <nav class="navbar fixed-top navbar-toggleable-md navbar-inverse" id="mainNav">
        <div class="container">
            <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                Menu <i class="fa fa-bars"></i>
            </button>
            <a class="navbar-brand" href="#page-top"><i class="fa fa-file"></i>&nbsp; File Tracker</a>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#services"><i class="fa fa-server"></i>&nbsp; Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#portfolio"><i class="fa fa-cog"></i>&nbsp; Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" role="button" id="loginModal" name="loginModal" data-toggle="modal" data-target="#myModal"><i class="fa fa-sign-in"></i>&nbsp; Login</a>
                    </li>
                </ul>
            </div>
        </div>
 </nav>
    <header class="masthead">
        <div class="container">
            <div class="intro-text">
                <div class="intro-lead-in">Housing Authority of New Orleans</div>
                <div class="intro-heading">File Tracker</div>
                <a href="#services" class="btn btn-xl"><i class="fa fa-server"></i>&nbsp; Learn More</a>
            </div>
        </div>
    </header>
    <section id="services">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading"><i class="fa fa-server"></i>&nbsp; Services</h2>
                    <h3 class="section-subheading text-muted">Document requested and destroyed files</h3>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-md-3">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-primary"></i>
                        <i class="fa fa-file fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading">Files</h4>
                    <p class="text-muted">Maintain accurate record of destroyed files.</p>
                </div>
                <div class="col-md-3">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-primary"></i>
                        <i class="fa fa-archive fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading">Boxes</h4>
                    <p class="text-muted">Maintain count and traction for location of files in boxes.</p>
                </div>
                <div class="col-md-3">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-primary"></i>
                        <i class="fa fa-users fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading">Users</h4>
                    <p class="text-muted">Manage users who have access to the system.</p>
                </div>
                <div class="col-md-3">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-primary"></i>
                        <i class="fa fa-shopping-cart fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading">Requests</h4>
                    <p class="text-muted">Solicit files needed for clients and inspection.</p>
                </div>
            </div>
        </div>
    </section>
    <section id="portfolio"  style="background-color:#FED136;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading"><i class="fa fa-cog"></i>&nbsp; Features</h2>
                    <h3 class="section-subheading text-muted">List of specific componnets</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-sm-6 portfolio-item">
                    <div class="portfolio"></div>
                    <div class="portfolio-caption">
                        <h4>Files</h4>
                        <p class="text-muted">Create Files</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 portfolio-item">
                    <div class="portfolio"></div>
                    <div class="portfolio-caption">
                        <h4>Boxes</h4>
                        <p class="text-muted">Create Boxes</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 portfolio-item">
                    <div class="portfolio"></div>
                    <div class="portfolio-caption">
                        <h4>Users</h4>
                        <p class="text-muted">Create Users</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 portfolio-item">
                    <div class="portfolio"></div>
                    <div class="portfolio-caption">
                        <h4>Requests</h4>
                        <p class="text-muted">Create Requests</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 portfolio-item">
                    <div class="portfolio"></div>
                    <div class="portfolio-caption">
                        <h4>Files</h4>
                        <p class="text-muted">Add & Delete Files</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 portfolio-item">
                    <div class="portfolio"></div>
                    <div class="portfolio-caption">
                        <h4>Boxes</h4>
                        <p class="text-muted">Search Files in Boxes</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 portfolio-item">
                    <div class="portfolio"></div>
                    <div class="portfolio-caption">
                        <h4>Users</h4>
                        <p class="text-muted">Add & Delete Users</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 portfolio-item">
                    <div class="portfolio"></div>
                    <div class="portfolio-caption">
                        <h4>Requests</h4>
                        <p class="text-muted">Check Out Files</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title"><i class="fa fa-sign-in"></i>&nbsp; Login</h3>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form id="Form1" runat="server" action="">
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
                    <button id="Button1" type="button" class="btn btn-info btn-md" runat="server" onserverclick="btnLogin">
                        <i class="fa fa-sign-in"></i>&nbsp;Login
                    </button>
                    <button type="button" class="btn btn-default btn-md" data-dismiss="modal" name="btnCancel"
                        id="btnCancel">
                        <i class="fa fa-ban"></i>&nbsp; Cancel
                    </button>
                     <asp:Label ID="lblMsg" runat="server" Style="font-size: 14px; font-weight: 700;
                           color: #1A926A" EnableViewState="False">
                     </asp:Label>
                 </div>
                </form>
            </div>
        </div>
    </div>
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <img class="img-fluid" src="./Images/hanoLogoSmaller.png" alt="" />
                </div>
            </div>
        </div>
    </footer>
</asp:Content>
