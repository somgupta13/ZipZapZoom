<%--
    Document   : notification
    Created on : Oct 25, 2019, 2:37:46 PM
    Author     : Raja
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="connection.MyCon"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    String email=(String)session.getAttribute("email");
    String utype=(String)session.getAttribute("utype");
%>
<html lang="en">
<head>
  <title>Notification</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <!-- <link rel="stylesheet" href="inner.css"> -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <style>
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 550px}
   
    /* Set gray background color and 100% height */
    .sidenav {
      background-color: #2196F3;
      
      height: 50em;
      position:fixed;

      
    }
    #tag{
      color:white;
    }
       .well{
        background-color: white;
       }
       .list a{
        color: #101417d6;

        background-color: #2196F3;
       }
    /* On small screens, set height to 'auto' for the grid */
    @media screen and (max-width: 767px) {
      .row.content {height: auto;}
    }
    @media screen and (min-width: 767px) {
      .col-sm-10 {margin-left:17%;}
      .nav-stacked {
        margin-top: 30%;
      }
    }
    .notifications {
padding: 2.2% 2%;
  margin: 0% 8%;
}
.notifications div{
  border-top: .03px solid rgb(237, 239, 255);
  padding: 1.5% 1%;
  line-height:300%;
}
.notifications div:nth-child(odd){
  background-color: rgb(247, 250, 255);
}
.notifications div:nth-child(even){
  background-color: white;
}

.notifications  div a{
   
   display: inline;
color: rgb(43, 199, 170);
  font-style: none;
}
.notifications  a:hover{
color: rgb(0, 191, 144);
  font-style: none;
}
  </style>
</head>
<body>
    <nav class="navbar navbar-inverse visible-xs">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar">ddd</span>
        <span class="icon-bar">trfg</span>
        <span class="icon-bar">jhf</span>                        
      </button>
      <a class="navbar-brand"  href="#">ZipZapZoom</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav left_col">
       <%
           if(utype.equals("Customer")){%>
        <li ><a href="cust_order.jsp">Placeorder</a></li><%}%>
        <li><a href="bidingongoing.jsp"> Ongoing Biding</a></li>
        <li ><a href="currentordersstatus.jsp">Orders Ongoing</a></li>
        <li><a href="previousorder.jsp">All Orders</a></li>
        <li class="active"><a href="notification.jsp">Notifications</a></li>
        <li><a href="accountupdate.jsp">Manage Account</a></li>
        <li><a href="logout">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container-fluid">
  <div class="row content">
    <div class="sidenav col-sm-2  hidden-xs left_col  ">
      <h2 id="tag">ZipZapZoom</h2>
      <ul class="nav nav-pills  nav-stacked ">
          <%
           if(utype.equals("Customer")){%>
        <li class="list"><a href="cust_order.jsp"><i class="fa fa-truck" style="font-size:170%;color:white;" aria-hidden="true"></i>Placeorder</a></li>
        <%}%>
        <li class="list "><a href="bidingongoing.jsp"><i class="fa fa-television" style="font-size:170%;color:white;" aria-hidden="true"></i>Ongoing Biding</a></li>
        <li class="list "><a href="currentordersstatus.jsp"><i class="fa fa-clock-o" style="font-size:170%;color:white;" aria-hidden="true"></i>Orders Ongoing</a></li>
        <li class="list"><a href="previousorder.jsp"><i class="fa fa-table" style="font-size:170%;color:white;" aria-hidden="true"></i>All Orders</a></li>
        <li class="list active"><a href="notification.jsp"><i class="fa fa-bell-o" style="font-size:170%;color:white;"></i>Notifications</a></li>
        <li class="list"><a href="accountupdate.jsp"><i class="fa fa-address-book-o" style="font-size:170%;color:white;"></i>Manage Account</a></li>
        <li class="list"><a href="logout"><i class="fa fa-user-o" style="font-size:170%;color:white;"></i>Logout</a></li>
      </ul><br>
    </div>
    <br>
   
    <div class="col-sm-10">
      <div class="well">
        <h4>Dashboard</h4>
        <p>Some text..</p>
      </div>
        <div class="well">
        <h3>Notification</h3>
        
      </div>
      <div class="well">
          <div class="notifications">
        <%
         Connection con=MyCon.getConnection();
            PreparedStatement ps;
         if(utype.equals("Customer")){
         ps=con.prepareStatement("Select * from notification where email=?"); ps.setString(1,email);}
         else{
              ps=con.prepareStatement("Select * from notification where email=? or email=?");
            ps.setString(1,email);
                         ps.setString(2,"trans_email");
        }
            ResultSet rs=ps.executeQuery();
            rs.afterLast();
            int i=0;
            while(rs.previous())
            {
                String oid=rs.getString(2);
           i++;
        %>
        <div> <%=i%>. <%=rs.getString(3)%> 
            <span>
                <%if(utype.equals("Customer")&&(rs.getString(3).substring(0, 10).equals("Your order"))){%>
        <a href="cust_accept.jsp?oid=<%=oid%>" >...know more </a>
    <%}else{%>
    
    <%if(rs.getString(3).substring(0, 7).equals("Bidding")){%>
    <a href="bidingoid.jsp?oid=<%=oid%>" >...know more </a><%}%>
        <%}%>
            </span>
    </div>
        <%
            }
         %>
    </div>
        </div>
        

      </div>
      
      <div class="row">
        <div class="footer">
         
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>
