<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : repsonse.jsp
    Created on : 11-Mar-2018, 6:47:08 PM
    Author     : Adi
--%>
<%
    String typeId = request.getParameter("type_id");
    String tableToJoin = typeId.equals("rental") ? "ForRent" : "ForSale";
    
    String sqlString = "select * from Property INNER JOIN {{tableName}} on {{tableName}}.property_id = Property.property_id;";
    sqlString = sqlString.replace("{{tableName}}", tableToJoin);
    System.out.println(sqlString);
    pageContext.setAttribute("sqlString", sqlString);
%>
<sql:query var="propertyQuery" dataSource="jdbc/RentalSite">
    <c:out value="${sqlString}"/>
</sql:query>
    
<%--<c:set var="propertyDetails" value="${propertyQuery.rows[0]}"/>--%>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> </title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <ul>
            <c:forEach var="row" items="${propertyQuery.rows}">
                <li>
                    <div property_id="${row.property_id}">
                        <div>
                            ${row.property_type}
                        </div>
                        <div>
                            ${row.address}
                        </div>
                        <div>
                            ${row.price}
                        </div>
                    </div>
                    
                </li>
            </c:forEach>
        </ul>

    </body>
</html>
