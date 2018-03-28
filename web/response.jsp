<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBuqQSkoLK_yz9xEqNR5y2W6zsIdhlrygg"></script>

  
<script type="text/javascript">
$( function() {
    var geocoder;
    var map;
    function initialize(address) {
      geocoder = new google.maps.Geocoder();
      var latlng = new google.maps.LatLng(-34.397, 150.644);
      var myOptions = {
        zoom: 15,
        center: latlng,
      mapTypeControl: true,
      mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
      navigationControl: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      
      if (geocoder) {
        geocoder.geocode( { 'address': address }, function(results, status) {
          var infowindow;
          var marker;
          if (status == google.maps.GeocoderStatus.OK) {
            if (status != google.maps.GeocoderStatus.ZERO_RESULTS) {
                myOptions.center = results[0].geometry.location;

                infowindow = new google.maps.InfoWindow(
                    { content: '<b>'+address+'</b>',
                        size: new google.maps.Size(150,50)
                    });

                marker = new google.maps.Marker({
                    position: results[0].geometry.location,
                    title:address
                }); 

                map = new google.maps.Map(document.getElementById("map-canvas"), myOptions);
                marker.setMap(map);
                google.maps.event.addListener(marker, 'click', function() {
                    infowindow.open(map,marker);
                });
            } else {
              alert("No results found");
            }
          } else {
            alert("Geocode was not successful for the following reason: " + status);
          }
        });
      }
    }
 
    $( ".listing_item" ).on( "click", function() {
      var url = [location.protocol, '//', location.host, "/cpsc304-project/detailedView.jsp?"].join('');
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
             var modal = $(".detailedView");
             modal.html(result);
             var $result = $(result);
             var $navMap = $result.find("#nav-map");
             var address = $navMap.attr("address");
             initialize(address);
         } 
      });
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
    
    Integer priceFrom = Integer.parseInt(request.getParameter("price_from"));
    Integer priceTo = Integer.parseInt(request.getParameter("price_to"));
    
    Integer sqftFrom = Integer.parseInt(request.getParameter("sqft_from"));
    Integer sqftTo = Integer.parseInt(request.getParameter("sqft_to"));
    
    String sqlString = "select Property.*, Postalcode.*, {{tableName}}.price "
                        + "from Property, PostalCode, {{tableName}} "
                        + "WHERE Property.postal_code = PostalCode.postal_code "
                        + "AND {{tableName}}.property_id = Property.property_id "
                        + "AND ( {{tableName}}.price BETWEEN " + priceFrom + " AND " + priceTo + ") "
                        + "AND ( Property.sq_ft BETWEEN " + sqftFrom + " AND " + sqftTo + ") ";
    
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
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <div style="width:100%; height:100%;">
            <c:choose>
                <c:when test="${fn:length(propertyQuery.rows) > 0}"> 
                    <div class="row">
                        <c:forEach var="row" items="${propertyQuery.rows}">
                            <div class="card listing_item col-md-5" property_id="${row.property_id}" type_id="${param.type_id}" data-toggle="modal" data-target="#detailedViewModal">
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
                    <div class="no-results"></div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="modal detailedView" id="detailedViewModal" role="dialog"></div>
    </body>
</html>
