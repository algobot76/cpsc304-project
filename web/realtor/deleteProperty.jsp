<%-- 
    Document   : deleteProperty
    Created on : 29-Mar-2018, 5:13:38 AM
    Author     : Darren
--%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<sql:update var="count" dataSource="jdbc/RentalSite">
        DELETE FROM Property
        WHERE Property.property_id = ${param.property_id}
</sql:update>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
{
    "rowsAffected": ${count}
}