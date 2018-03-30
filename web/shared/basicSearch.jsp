<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="rentBounds" dataSource="jdbc/RentalSite">
    select MIN(price) as min_price, MAX(price) as max_price from ForRent;
</sql:query>

<sql:query var="saleBounds" dataSource="jdbc/RentalSite">
    select MIN(price) as min_price, MAX(price) as max_price from ForSale;
</sql:query>

<sql:query var="sqftBounds" dataSource="jdbc/RentalSite">
    select MIN(sq_ft) as min_sq_ft, MAX(sq_ft) as max_sq_ft from Property;
</sql:query>
<%-- 
    Document   : index
    Created on : 11-Mar-2018, 6:31:20 PM
    Author     : Adi
--%>


<script type="text/javascript">
//    This makes any input become 1 if focus is removed from it AND it contains nothing: 
//    Allows for no blank inputs to be sent
    $(document).ready(function () {
        var setPricePlaceHolders = function () {
            var $searchForm = $(".property-search");
            var isRental = $searchForm.find("#type_id").val() === "rental";
            var $fromPrice = $searchForm.find("#price_from");
            var $toPrice = $searchForm.find("#price_to");

            var fromPlaceHolderText = isRental ? $fromPrice.attr("minRent") : $fromPrice.attr("minSale");
            var toPlaceHolderText = isRental ? $toPrice.attr("maxRent") : $toPrice.attr("maxSale");
            $fromPrice.attr("placeholder", fromPlaceHolderText || "MIN");
            $toPrice.attr("placeholder", toPlaceHolderText || "MAX");
        }
        setPricePlaceHolders();

        $("#type_id").on("change", function () {
            setPricePlaceHolders();
        });

        var submitButtonHandler = function () {
            var $searchForm = $(".property-search");
            var formAction = $searchForm.attr("formAction")
            var url = [location.protocol, '//', location.host, "/RentalSite" + formAction + "?"].join('');
            var $typeId = $searchForm.find("#type_id");
            var isRental = $typeId.val() === "rental";
            var priceFrom = $searchForm.find("#price_from").val() || (isRental ? $searchForm.find("#price_from").attr("minRent") : $searchForm.find("#price_from").attr("minSale")) || 0;
            var priceTo = $searchForm.find("#price_to").val() || (isRental ? $searchForm.find("#price_to").attr("maxRent") : $searchForm.find("#price_to").attr("maxSale")) || 0;
            var uriParams = {
                "type_id": $typeId.val(),
                "price_from": priceFrom,
                "price_to": priceTo,
                "sqft_from": $searchForm.find("#sqft_from").val() || $searchForm.find("#sqft_from").attr("placeholder") || 0,
                "sqft_to": $searchForm.find("#sqft_to").val() || $searchForm.find("#sqft_to").attr("placeholder") || 0,
                "city_input": $searchForm.find("#city_input").val(),
                "bed_input": $searchForm.find("#bed_input").val(),
                "bath_input": $searchForm.find("#bath_input").val(),
            }

            var uri = Object.keys(uriParams).map(key => {
                return [key, uriParams[key]].map(encodeURIComponent).join("=");
            }).join("&");

            // navigate to this path
            window.location.href = url + uri;
        }

        var $form = $(".needs-validation");
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
<div class="container search-container">
    <div class="card panel-default">
        <div class="card-body">
            <h1>Search Properties</h1>

            <form class="property-search needs-validation" novalidation formAction="${param.formAction}">
                <div class="form-group">
                    <label for="type_id">Choose Property Type:</label>
                    <select id="type_id">
                        <option value="rental">Rental</option>
                        <option value="sale">Sale</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Search by Price Range:</label>
                    <label for="price_from">From</label>
                    <input id="price_from" value="" placeholder minRent="${rentBounds.rows[0].min_price}" minSale="${saleBounds.rows[0].min_price}"/>

                    <label for="price_to">To</label>
                    <input id="price_to" value="" placeholder maxRent="${rentBounds.rows[0].max_price}" maxSale="${saleBounds.rows[0].max_price}"/>
                </div>

                <div class="form-group">
                    <label>Search by Footage:</label>
                    <label for="sqft_from">From</label>
                    <input id="sqft_from" value="" placeholder="${sqftBounds.rows[0].min_sq_ft}"/>

                    <label for="sqft_to">To</label>
                    <input id="sqft_to" value="" placeholder="${sqftBounds.rows[0].max_sq_ft}"/>
                </div>

                <div class="form-group">
                    <label for="city_input">Search by City:</label>
                    <input id="city_input" value="" />
                </div>

                <div class="form-group">
                    <label for="bed_input">Number of Beds:</label>
                    <select id="bed_input">
                        <option value="0">0+</option>
                        <option value="1">1+</option>
                        <option value="2">2+</option>
                        <option value="3">3+</option>
                        <option value="4">4+</option>
                        <option value="5">5+</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="bath_input">Number of Baths:</label>
                    <select id="bath_input">
                        <option value="0">0+</option>
                        <option value="1">1+</option>
                        <option value="1.5">1.5+</option>
                        <option value="2">2+</option>
                        <option value="3">3+</option>
                        <option value="4">4+</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary submit-button">Submit</button>
            </form>
        </div>
    </div>
</div>

