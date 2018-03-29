<%-- 
    Document   : message.jsp
    Created on : 29-Mar-2018, 4:42:38 AM
    Author     : Adi
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.sql.Timestamp" %>

<%
    String realtorID = request.getParameter("realtor_id");
    boolean messageChecked = Boolean.valueOf(request.getParameter("message_checked"));
    boolean nameChecked = Boolean.valueOf(request.getParameter("name_checked"));
    boolean emailChecked = Boolean.valueOf(request.getParameter("email_checked"));
    boolean phoneChecked = Boolean.valueOf(request.getParameter("phone_checked"));
    boolean dateChecked = Boolean.valueOf(request.getParameter("date_checked"));

    pageContext.setAttribute("realtorID", realtorID);
    pageContext.setAttribute("messageChecked", messageChecked);
    pageContext.setAttribute("nameChecked", nameChecked);
    pageContext.setAttribute("emailChecked", emailChecked);
    pageContext.setAttribute("phoneChecked", phoneChecked);
    pageContext.setAttribute("dateChecked", dateChecked);

    List<String> elements = new ArrayList<String>();

    if (messageChecked) {
        String message = "ccr.contact_message";
        elements.add(message);
    }
    if (nameChecked) {
        String name = "c.name";
        elements.add(name);
    }
    if (emailChecked) {
        String email = "c.email";
        elements.add(email);
    }
    if (phoneChecked) {
        String phone = "c.phone";
        elements.add(phone);
    }
    if (dateChecked) {
        String date = "ccr.date";
        elements.add(date);
    }

    String result = String.join(", ", elements);

    String sqlCheckBox = "select " + result + " "
            + "FROM CustomerContactRealtor ccr, Customer c "
            + "WHERE ccr.customer_id = c.customer_id";

    pageContext.setAttribute("sqlCheckBox", sqlCheckBox);
%>


<sql:query var="messagesQuery" dataSource="jdbc/RentalSite">
    <c:out value="${sqlCheckBox}"/> 
    AND realtor_id = '${realtorID}'
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table>
    <tr>
        <c:forEach var="columnName" items="${messagesQuery.columnNames}">
            <th>
                <c:out value="${columnName}"/>
            </th>
        </c:forEach>
    </tr>
    <c:forEach var="row" items="${messagesQuery.rowsByIndex}">
        <tr>
            <c:forEach var="column" items="${row}">
                <td>
                    <c:out value="${column}"/>
                </td>
            </c:forEach>
        </tr>
    </c:forEach>
</table>