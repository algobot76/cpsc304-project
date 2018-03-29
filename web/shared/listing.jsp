<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<sql:query var="propertyQuery" dataSource="jdbc/RentalSite">
    <c:out value="${param.sqlString}"/> 
    AND Property.num_beds >= <c:out value="${param.numBeds}"/> 
    AND Property.num_baths >= <c:out value="${param.numBaths}"/> 
    AND PostalCode.city LIKE '%<c:out value="${param.cityInput}"/>%'
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> </title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
        <script defer src="https://use.fontawesome.com/releases/v5.0.9/js/all.js" integrity="sha384-8iPTk2s/jMVj81dnzb/iFR2sdA7u06vHJyyLlAd4snFpCl/SnyUjRrbdJsw1pGIl" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="listings content">
            <div class="listings-header">
                <div class="listings-count">
                    <div class="numResults">${fn:length(propertyQuery.rows)} results</div>
                </div>
                <div class="listings-refresh">
                    <div class="refresh-button">
                        <a type="button" onClick="window.location.href=window.location.href">
                            <i class="fas fa-sync"></i>
                        </a>
                    </div>
                </div>
            </div>
            <c:choose>
                <c:when test="${fn:length(propertyQuery.rows) > 0}"> 
                    <div class="row">
                        <c:forEach var="row" items="${propertyQuery.rows}">
                            <div class="card listing_item col-md-5" property_id="${row.property_id}" type_id="${param.type_id}" data-toggle="modal" data-target="#modalView">
                                <div class="image-container">
                                    <img class="card-img-top" src="${row.image_url}" alt="...">
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${row.property_type}</h5>
                                    <p class="card-text">
                                        $${row.price} <br>
                                        ${row.address}, ${row.city}, ${row.province} <br>
                                        ${row.num_beds} beds &middot ${row.num_baths} baths &middot ${row.sq_ft}sqft
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <div class="alert alert-warning" role="alert">
                            Could not find any posting matching the search criteria. <a href="javascript:history.back()" class="alert-link">Click here</a> to start a new search!
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="modal modalView" id="modalView" role="dialog"></div>
    </body>
</html>
