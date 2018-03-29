<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBuqQSkoLK_yz9xEqNR5y2W6zsIdhlrygg"></script>

<jsp:include page="/shared/navBar.jsp" />


<script type="text/javascript">
    $(function () {
        $(".listing_item").on("click", function () {
            var url = [location.protocol, '//', location.host, "/RentalSite/realtor/realtorEdit.jsp?"].join('');
            var $listItem = $(this);
            var uriParams = {
                "property_id": $listItem.attr("property_id"),
                "type_id": $listItem.attr("type_id")
            }

            var uri = Object.keys(uriParams).map(key => {
                return [key, uriParams[key]].map(encodeURIComponent).join("=");
            }).join("&");

            $.ajax(url + uri, {
                success: result => {
                    var modal = $(".modalView");
                    modal.html(result);
                }
            });
        });
    });
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
    String cityInput = request.getParameter("city_input");

    Float priceFrom = Float.parseFloat(request.getParameter("price_from"));
    Float priceTo = Float.parseFloat(request.getParameter("price_to"));

    Float sqftFrom = Float.parseFloat(request.getParameter("sqft_from"));
    Float sqftTo = Float.parseFloat(request.getParameter("sqft_to"));

    Float numBeds = Float.parseFloat(request.getParameter("bed_input"));
    Float numBaths = Float.parseFloat(request.getParameter("bath_input"));

    String sqlString = "select Property.*, Postalcode.*, {{tableName}}.price "
            + "from Property, PostalCode, {{tableName}} "
            + "WHERE Property.postal_code = PostalCode.postal_code "
            + "AND {{tableName}}.property_id = Property.property_id "
            + "AND ( {{tableName}}.price BETWEEN " + priceFrom + " AND " + priceTo + ") "
            + "AND ( Property.sq_ft BETWEEN " + sqftFrom + " AND " + sqftTo + ") ";

    sqlString = sqlString.replace("{{tableName}}", tableToJoin);
    System.out.println("here is the input " + priceFrom.getClass().getName() + ", " + priceTo.getClass().getName() + ", " + sqftTo.getClass().getName() + ", " + sqftFrom.getClass().getName());
    System.out.println(sqlString);

    pageContext.setAttribute("numBeds", numBeds);
    pageContext.setAttribute("numBaths", numBaths);
    pageContext.setAttribute("cityInput", cityInput);
    pageContext.setAttribute("sqlString", sqlString);
%>

<jsp:include page="/shared/listing.jsp">
    <jsp:param name="sqlString" value="${sqlString}"/>
    <jsp:param name="numBeds" value="${numBeds}"/>
    <jsp:param name="numBaths" value="${numBaths}"/>
    <jsp:param name="cityInput" value="${cityInput}"/>
</jsp:include>
