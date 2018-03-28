<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<%-- 
    Document   : realtorEdit
    Created on : 26-Mar-2018, 2:34:54 AM
    Author     : Darren
--%>

<%
    String propertyId = request.getParameter("property_id");
    String typeId = request.getParameter("type_id");
    String tableToJoin = typeId.equals("rental") ? "ForRent" : "ForSale";
    String typeString = typeId.equals("rental") ? "For Rent" : "For Sale";
    
    String propertyDetailsSql = "select Property.*, Postalcode.*, {{tableName}}.price "
                        + "from Property, PostalCode, {{tableName}} "
                        + "WHERE Property.postal_code = PostalCode.postal_code "
                        + "AND {{tableName}}.property_id = Property.property_id "
                        + "AND " + propertyId + " = Property.property_id";
    
    propertyDetailsSql = propertyDetailsSql.replace("{{tableName}}", tableToJoin);
    System.out.println("propertyDetailsSql string: " + propertyDetailsSql);
    
    String roomsSql = "select Room.* from Room INNER JOIN Property ON Property.property_id = Room.property_id "
                       + "WHERE " + propertyId + " = Property.property_id";
    
    pageContext.setAttribute("propertyDetailsSql", propertyDetailsSql);
    pageContext.setAttribute("roomsSql", roomsSql);
    pageContext.setAttribute("typeString", typeString);
%>

<sql:query var="propertyQuery" dataSource="jdbc/RentalSite">
    <c:out value="${propertyDetailsSql}"/>
</sql:query>

<sql:query var="rooms" dataSource="jdbc/RentalSite">
    <c:out value="${roomsSql}"/>
</sql:query>

<c:set var="propertyDetails" value="${propertyQuery.rows[0]}"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <body>
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    
                    <button type="button" class="btn btn-danger">Remove</button>
                    
                    <div class="upside-down-nav">
                        
                        <form id="search_form" action="realtorEdit.jsp">
                            
                            <strong>Edit Property Values</strong>
                            
                            <br></br>
                            
                            <strong>Property ID:</strong>
                            <input class="int_val" type="text" readonly="true" name="id_input" value="${propertyDetails.property_id}" />
                            
                            <br></br>

                            <strong>Property Type</strong>
                            <select name="type_id">
                                    <option value="rental">Rental</option>
                                    <option value="sale">Sale</option>
                            </select>
                            
                            <br></br>
                            
                            <strong>Price:</strong>
                            <input class="int_val" type="text" name="price_input" value="${propertyDetails.price}" />
                            
                            <br></br>

                            <strong>Square Footage:</strong>
                            <input class="int_val" type="text" name="sqft_input" value="${propertyDetails.sq_ft}" />
                            
                            <br></br>
                            
                            <strong>Address:</strong>
                            <input type="text" name="address_input" value="${propertyDetails.address}" />
                            
                            <br></br>
                            
                            <strong>Number of beds</strong>
                            <input type="text" name="bed_input" value="${propertyDetails.num_beds}" />
                            
                            <br></br>
                            
                            <strong>Number of baths</strong>
                            <input type="text" name="bath_input" value="${propertyDetails.num_baths}" />  
                           
                            <br></br>
                               
                            <input type="submit" value="Update" name="submit" class="btn btn-primary"/>
                        </form>
                </div>
            </div>
        </div>
        </div>
    
    <%
        String priceVal = request.getParameter("price_input");
        String sqFtVal = request.getParameter("sqft_input");
        String addressVal = request.getParameter("address_input");
        String bedVal = request.getParameter("bed_input");
        String bathVal = request.getParameter("bath_input");
        
        if (priceVal == null && sqFtVal == null && addressVal == null && bedVal == null && bathVal == null) {
        // All are null when the page is first requested, 
        // so do nothing
        } else { 
            if (priceVal.length() == 0 && sqFtVal.length() == 0 && addressVal.length() == 0 && bedVal.length() == 0 && bathVal.length() == 0) {
                // There was a querystring like ?myText=
                // but no text, so myText is not null, but 
                // a zero length string instead.
        %>
        <%  } else {
        %>
            <sql:update var="sqlUpdate" dataSource="jdbc/RentalSite">
                UPDATE Property p 
                SET p.address = '${param.address_input}',
                p.sq_ft = ${param.sqft_input},
                p.num_beds = ${param.bed_input},
                p.num_baths = ${param.bath_input}
                WHERE p.property_id = ${param.id_input}
            </sql:update>
            
            <script type="text/javascript">
                location.reload();
            </script>
        <%
            }
        }
        %>
    </body>
    
    
     
