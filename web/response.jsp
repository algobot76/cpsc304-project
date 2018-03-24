<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  
<script type="text/javascript">
$( function() {
    $( "#dialog" ).dialog({
      autoOpen: false,
      show: {
        effect: "scale"
      }
    });
 
    $( ".list_item" ).on( "click", function() {
      $( "#dialog" ).dialog( "open" );
    });
  } );
</script>

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
    
    String sqlString = "select Property.*, Postalcode.city, {{tableName}}.{{priceType}} "
                        + "from Property, PostalCode, {{tableName}} "
                        + "WHERE Property.postal_code = PostalCode.postal_code "
                        + "AND {{tableName}}.property_id = Property.property_id "
                        + "AND ( {{tableName}}.{{priceType}} BETWEEN " + priceFrom + " AND " + priceTo + ") "
                        + "AND ( Property.sq_ft BETWEEN " + sqftFrom + " AND " + sqftTo + ") ";
    
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
                    <div class="list_item" property_id="${row.property_id}">
                        <div>
                            ${row.property_type}
                        </div>
                        <div>
                            ${row.address}
                        </div>
                        <div>
                            ${row.price}
                        </div>
                        <div>
                            ${row.city}
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
        
  
        <div id="dialog" title="Basic dialog">
          <p>This is an animated dialog which is useful for displaying information. The dialog window can be moved, resized and closed with the 'x' icon.</p>
        </div>
               
       
    </body>
</html>
