<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 
    Document   : detailedView
    Created on : 26-Mar-2018, 2:34:54 AM
    Author     : Darren
--%>

<%
    String propertyId = request.getParameter("property_id");
    String typeId = request.getParameter("type_id");
    String tableToJoin = typeId.equals("rental") ? "ForRent" : "ForSale";
    String priceType = tableToJoin.equals("ForRent") ? "rent" : "price";
    String typeString = typeId.equals("rental") ? "For Rent" : "For Sale";
    
    String sqlString = "select Property.*, Postalcode.*, {{tableName}}.{{priceType}} "
                        + "from Property, PostalCode, {{tableName}} "
                        + "WHERE Property.postal_code = PostalCode.postal_code "
                        + "AND {{tableName}}.property_id = Property.property_id "
                        + "AND " + propertyId + " = Property.property_id";
    
    
    sqlString = sqlString.replace("{{priceType}}", priceType);
    sqlString = sqlString.replace("{{tableName}}", tableToJoin);
    System.out.println(sqlString);
    
    pageContext.setAttribute("sqlString", sqlString);
    pageContext.setAttribute("typeString", typeString);
%>
<sql:query var="propertyQuery" dataSource="jdbc/RentalSite">
    <c:out value="${sqlString}"/>
</sql:query>

<c:set var="propertyDetails" value="${propertyQuery.rows[0]}"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <body>
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    <div style="height: 500px;"> PICTURES GO HERE LEL, remember to remove</div>
                    <div class="propertyDescription">
                        <h1>
                            ${propertyDetails.address}
                            <span>
                                ${propertyDetails.city}, ${propertyDetails.province} ${propertyDetails.postal_code}
                            </span>
                        </h1>
                        <h3>
                            <span>
                                ${propertyDetails.num_beds} beds
                            </span>
                            <span>
                                /
                            </span>
                            <span>
                                ${propertyDetails.sq_ft} sqft
                            </span>
                        </h3>
                    </div>
                    <div class="propertyPriceDetails">
                        <h1>${typeString}</h1>
                        <h2>$${propertyDetails.price}</h2>
                    </div>
                </div>
            </div>
        </div>
    </body>
