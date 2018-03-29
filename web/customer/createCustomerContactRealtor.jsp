<%-- 
    Document   : createCustomerContactRealtor
    Created on : 28-Mar-2018, 5:23:25 PM
    Author     : Darren
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.sql.Timestamp" %>

<%
    java.util.Date date = new java.util.Date();
    pageContext.setAttribute("date", new SimpleDateFormat("yyyy-MM-dd").format(date).toString());
%>


<sql:update var="insertCount" dataSource="jdbc/RentalSite">
    insert into Customer(name, email, phone) 
    VALUES('${param.customer_name}','${param.customer_email}','${param.customer_phone}')
    ON DUPLICATE KEY UPDATE
    name='${param.customer_name}',phone='${param.customer_phone}'
</sql:update>

    <sql:update var="count" dataSource="jdbc/RentalSite">
        INSERT INTO CustomerContactRealtor(customer_id, realtor_id, date, contact_message)
        VALUES(
        (select customer_id from Customer where email='${param.customer_email}'),
        '${param.realtor_id}',
        '${date}',
        '${param.customer_message}');
    </sql:update>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
{
    "rowsAffected": ${count}
}