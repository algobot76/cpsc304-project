<%-- 
    Document   : NavBar.jsp
    Created on : 27-Mar-2018, 5:38:16 PM
    Author     : Adi
--%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script type="text/javascript">
    $(document).ready(function () {
        var location = window.location.href;
        $('#nav li a').each(function(){
            if(location.indexOf(this.href)>-1) {
               $(this).parent().addClass('active');
            }
        });
    });
</script>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
      <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <ul class="navbar-nav" id="nav">
          <li class="nav-item">
            <a class="nav-link" href="/RentalSite">Home</a>
          </li>  
          <li class="nav-item">
            <a class="nav-link" href="/RentalSite/customer/">Customers</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/RentalSite/realtor/">Realtors</a>
          </li>
        </ul>
      </nav>

    </head>
    <body>
    </body>
</html>
