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
    pageContext.setAttribute("propertyTypeTable", tableToJoin);
%>

<sql:query var="propertyQuery" dataSource="jdbc/RentalSite">
    <c:out value="${propertyDetailsSql}"/>
</sql:query>

<sql:query var="rooms" dataSource="jdbc/RentalSite">
    <c:out value="${roomsSql}"/>
</sql:query>

<c:set var="propertyDetails" value="${propertyQuery.rows[0]}"/>


<script>
    $(function () {
        'use strict';

        var submitButtonHandler = function () {
            var $updateDeleteForm = $(".realtor-update-delete-form");
            var toDelete = $updateDeleteForm.find("#delete_input").val() === "yes";
            var propertyId = $updateDeleteForm.attr("property_id");
            var typeId = $updateDeleteForm.attr("type_id");
            var url;
            var uriParams = {};

            if (toDelete) {
                url = [location.protocol, '//', location.host, "/RentalSite/realtor/deleteProperty.jsp?"].join('');

                uriParams = {
                    "property_id": propertyId
                };
            } else {
                url = [location.protocol, '//', location.host, "/RentalSite/realtor/updateProperty.jsp?"].join('');

                uriParams = {
                    "property_id": propertyId,
                    "type_id": typeId === "rental" ? "ForRent" : "ForSale",
                    "sq_ft": $updateDeleteForm.find("#sqft_input").val(),
                    "address": $updateDeleteForm.find("#address_input").val(),
                    "num_beds": $updateDeleteForm.find("#bed_input").val(),
                    "num_baths": $updateDeleteForm.find("#bath_input").val(),
                    "price": $updateDeleteForm.find("#price_input").val(),
                };
            }

            var uri = Object.keys(uriParams).map(key => {
                return [key, uriParams[key]].map(encodeURIComponent).join("=");
            }).join("&");

            $.ajax(url + uri, {
                success: result => {
                    console.log(result);
                    $updateDeleteForm.find(".submit-button").addClass("disabled");
                    $updateDeleteForm.find(".submit-button").attr("disabled", "disabled");
                    $updateDeleteForm.find(".alert-success").removeAttr("hidden");
                    window.setTimeout(function(){location.reload()},3000)
                },
                error: err => {
                    alert("Something went wrong");
                    console.log(err);
                }
            });
        }

        var $form = $(".realtor-update-delete-form");
        $form.on("submit", function (event) {
            var isValid = $form[0].checkValidity()
            if (isValid === false) {
                event.preventDefault();
                event.stopPropagation();
            }
            $form.addClass('was-validated');
            if (isValid === true) {
                submitButtonHandler();
            }
            return false;
        });
    });
</script>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<body>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <div class="upside-down-nav">
                    <form id="search_form" class="realtor-update-delete-form" property_id="${param.property_id}" type_id="${param.type_id}" novalidate>
                        <strong>Edit Property Values</strong>
                        <br></br>
                        <div class="alert alert-success" role="alert" hidden>
                            Success! Refreshing page in a few seconds, <a class="alert-link" href="javascript:window.location.href=window.location.href">click here</a> to refresh the page now.
                        </div>

                        <div class="form-group">
                            <label for="delete_input">Delete this property?</label>
                            <select class="form-control" id="delete_input" required>
                                <option value="no">No</option>
                                <option value="yes">Yes</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="price_input">Price</label>
                            <input class="form-control" type="text" id="price_input" value="${propertyDetails.price}" required/>
                        </div>

                        <div class="form-group">
                            <label for="sqft_input">Square Footage</label>
                            <input class="int_val form-control" type="text" id="sqft_input" value="${propertyDetails.sq_ft}" required/>
                        </div>

                        <div class="form-group">
                            <label for="address_input">Address</label>
                            <input class="form-control" type="text" id="address_input" value="${propertyDetails.address}" required disabled/>
                        </div>

                        <div class="form-group">
                            <label for="bed_input">Number of beds</label>
                            <input class="form-control" type="text" id="bed_input" value="${propertyDetails.num_beds}" required/>
                        </div>

                        <div class="form-group">
                            <label for="bath_input">Number of baths</label>
                            <input class="form-control" type="text" id="bath_input" value="${propertyDetails.num_baths}" required/>
                        </div>

                        <button type="submit" class="btn btn-primary submit-button">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>