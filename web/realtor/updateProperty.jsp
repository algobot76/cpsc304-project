<%-- 
    Document   : updateProperty
    Created on : 29-Mar-2018, 5:13:48 AM
    Author     : Darren
--%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.lang.Integer"%>


<sql:update var="propertyUpdateCount" dataSource="jdbc/RentalSite">
    UPDATE Property p
    SET p.address = '${param.address}',
    p.sq_ft = ${param.sq_ft},
    p.num_beds = ${param.num_beds},
    p.num_baths = ${param.num_baths}
    WHERE p.property_id = ${param.property_id}
</sql:update>

<sql:update var="typeUpdateCount" dataSource="jdbc/RentalSite">
    UPDATE ${param.type_id}
    SET price = ${param.price}
    WHERE property_id = ${param.property_id};
</sql:update>
    
<% 
    int propertyUpdateCount = Integer.parseInt(pageContext.getAttribute("propertyUpdateCount").toString());
    int typeUpdateCount = Integer.parseInt(pageContext.getAttribute("typeUpdateCount").toString());
    
    pageContext.setAttribute("rowsAffected", propertyUpdateCount + typeUpdateCount);
%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
{
"rowsAffected": ${rowsAffected}
}
