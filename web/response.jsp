<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 
    Document   : repsonse.jsp
    Created on : 11-Mar-2018, 6:47:08 PM
    Author     : Adi
--%>
<%
    String typeId = request.getParameter("type_id");
    String address = request.getParameter("addr_input");
    String tableToJoin = typeId.equals("rental") ? "ForRent" : "ForSale";
    String priceType = tableToJoin.equals("ForRent") ? "rent" : "price";
    
    Integer priceFrom = Integer.parseInt(request.getParameter("price_from"));
    Integer priceTo = Integer.parseInt(request.getParameter("price_to"));
    
    Integer sqftFrom = Integer.parseInt(request.getParameter("sqft_from"));
    Integer sqftTo = Integer.parseInt(request.getParameter("sqft_to"));
    
    String sqlString = "select Property.*, {{tableName}}.{{priceType}} "
                        + "from Property "
                        + "INNER JOIN {{tableName}} on "
                        + "{{tableName}}.property_id = Property.property_id "
                        + "WHERE ( {{priceType}} BETWEEN " + priceFrom + " AND " + priceTo + ")"
                        + " AND ( sq_ft BETWEEN " + sqftFrom + " AND " + sqftTo + ")";
    sqlString = sqlString.replace("{{priceType}}", priceType);
    sqlString = sqlString.replace("{{tableName}}", tableToJoin);
    System.out.println("here is the input " + priceFrom.getClass().getName() + ", " + priceTo.getClass().getName() + ", " + sqftTo.getClass().getName() + ", " + sqftFrom.getClass().getName());
    System.out.println(sqlString);

    pageContext.setAttribute("sqlString", sqlString);
%>
<sql:query var="propertyQuery" dataSource="jdbc/RentalSite">
    <c:out value="${sqlString}"/>
</sql:query>
    
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
