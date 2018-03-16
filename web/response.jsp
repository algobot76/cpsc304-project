<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : repsonse.jsp
    Created on : 11-Mar-2018, 6:47:08 PM
    Author     : Adi
--%>
<sql:query var="propertyQuery" dataSource="jdbc/RentalSite">
SET @first := (SELECT Property.*, Forrent.rent AS price FROM Property, Forrent WHERE Property.property_id = Forrent.property_id) 

SET @second := (SELECT * from Property) 
SET @combined := @first UNION @second
IF ? <sql:param value="${param.price_id}"/> = 'range1' 
SELECT * FROM @combined WHERE @combined.price < 100000 AND @combined.rent < 100000 AS rangeTable 
ELSE IF ? <sql:param value="${param.price_id}"/> = 'range2' 
SELECT * FROM @combined WHERE (@combined.price >= 100000 AND @combined.price <= 500000) 
AND (@combined.rent >= 100000 AND @combined.rent <= 500000) AS rangeTable
ELSE IF ? <sql:param value="${param.price_id}"/> = 'range3'
SELECT * FROM @combined WHERE (@combined.price >= 500000 AND @combined.price <= 1000000) 
                AND (@combined.rent >= 500000 AND @combined.rent <= 1000000) AS rangeTable
        END
    ELSE IF ? <sql:param value="${param.price_id}"/> = 'range4'
        BEGIN
            SELECT * FROM @combined WHERE (@combined.price > 1000000 AND @combined.rent > 1000000) 
                AS rangeTable
        END
    ELSE IF ? <sql:param value="${param.price_id}"/> = 'range0'
        BEGIN
            SELECT * FROM @combined AS rangeTable
        END    
    IF ? <sql:param value="${param.sqft_id}"/> = 'footage0'
        BEGIN
            SELECT * FROM @combined AS footageTable
        END
    ELSE IF ? <sql:param value="${param.sqft_id}"/> = 'footage1'
        BEGIN
            SELECT * FROM @combined WHERE (@combined.sq_ft < 1000) AS footageTable
        END
    ELSE IF ? <sql:param value="${param.sqft_id}"/> = 'footage2'
        BEGIN
            SELECT * FROM @combined WHERE (@combined.sq_ft >= 1000 AND @combined.sq_ft <= 2500) AS footageTable
        END
    ELSE IF ? <sql:param value="${param.sqft_id}"/> = 'footage3'
        BEGIN
            SELECT * FROM @combined WHERE (@combined.sq_ft > 2500 ) AS footageTable
        END
       
    IF ? <sql:param value="${param.type_id}"/> = 'rental'
        BEGIN
            SELECT * FROM Property a
            INNER JOIN Forrent b ON a.property_id=b.property_id 
            INNER JOIN rangeTable c ON a.property_id = c.property_id
            INNER JOIN footageTable d ON a.property_id = d.property_id
        END
    ELSE IF ? <sql:param value="${param.type_id}"/> = 'sale'
                SELECT * FROM Property a
                INNER JOIN Forsale b ON a.property_id=b.property_id 
                INNER JOIN rangeTable c ON a.property_id = c.property_id
                INNER JOIN footageTable d ON a.property_id = d.property_id
            ELSE
                BEGIN 
                    SELECT * FROM Property a
                    INNER JOIN combined b ON a.property_id=b.property_id 
                    INNER JOIN rangeTable c ON a.property_id = c.property_id
                    INNER JOIN footageTable d ON a.property_id = d.property_id
                END
           
</sql:query>
    
<c:set var="propertyDetails" value="${propertyQuery.rows}"/>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> </title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <table border="0">
            <thead>
                <tr>
                    <th colspan="2">Details</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Property Type:</strong></td>
                    <td><span style="font-size:smaller; font-style:italic;">${propertyDetails.type}</span></td>
                </tr>
                <tr>
                    <td><strong>Address:</strong></td>
                    <td>${propertyDetails.address}
                        <br>
                        <span style="font-size:smaller; font-style:italic;">
                        </span>
                    </td>
                </tr>
                <tr>
                    <td><strong>Pricing: </strong></td>
                    <td>
                        <a href="mailto:{placeholder}">${propertyDetails.price}</a>
                        <br><strong></strong>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
