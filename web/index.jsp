<%-- 
    Document   : index
    Created on : 28-Mar-2018, 4:31:53 AM
    Author     : Darren
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<jsp:include page="shared/navBar.jsp" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rental Site</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <div class="masthead">
            <div class="jumbotron title-page-body">
                <h1 class="display-4">There's no place like home</h1>
                <p>Find your dream house today</p>
                <p class="lead">
                    <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/customer" role="button">Learn more</a>
                </p>
            </div>
        </div>
    </body>
</html>
    
