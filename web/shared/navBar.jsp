<%-- 
    Document   : NavBar.jsp
    Created on : 27-Mar-2018, 5:38:16 PM
    Author     : Adi
--%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var location = window.location.href;
        $('#nav li a').each(function () {
            if (location.indexOf(this.href) > -1) {
                $(this).parent().addClass('active');
            }
        });
    });
</script>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark sticky-top">
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
