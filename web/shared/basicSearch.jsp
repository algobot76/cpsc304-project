<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script type="text/javascript">
//    This makes any input become 1 if focus is removed from it AND it contains nothing: 
//    Allows for no blank inputs to be sent
    $(document).ready(function () {
        $(".int_val").map(function () {
            $(this).blur(function () {
                if ($(this).val() == '') {
                    $(this).val(1);
                }
            }).val(1)
        })
    });
</script>

<%-- 
    Document   : index
    Created on : 11-Mar-2018, 6:31:20 PM
    Author     : Adi
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rental Site</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-body">
                    <h1>Search Properties</h1>

                    <form action="${pageContext.request.contextPath}${param.formAction}">
                        <strong>Choose Property Type:</strong>
                        <select name="type_id">
                            <option value="rental">Rental</option>
                            <option value="sale">Sale</option>
                        </select>
                        <br></br>

                        <strong>Search by Price Range:</strong>
                        <strong>From</strong>
                        <input class="int_val" type="text" name="price_from" value="" />

                        <strong>To</strong>
                        <input class="int_val" type="text" name="price_to" value="" />

                        <br></br>

                        <strong>Search by Footage:</strong>
                        <strong>From</strong>
                        <input class="int_val" type="text" name="sqft_from" value="" />

                        <strong>To</strong>
                        <input class="int_val" type="text" name="sqft_to" value="" />

                        <br></br>

                        <strong>Search by City:</strong>
                        <input type="text" name="city_input" value="" />

                        <br></br>

                        <strong>Number of Beds:</strong>
                        <select name="bed_input">
                            <option value="0">0+</option>
                            <option value="1">1+</option>
                            <option value="2">2+</option>
                            <option value="3">3+</option>
                            <option value="4">4+</option>
                            <option value="5">5+</option>
                        </select>

                        <br></br>

                        <strong>Number of Baths:</strong>
                        <select name="bath_input">
                            <option value="0">0+</option>
                            <option value="1">1+</option>
                            <option value="1.5">1.5+</option>
                            <option value="2">2+</option>
                            <option value="3">3+</option>
                            <option value="4">4+</option>
                        </select>

                        <br></br>
                        <input class="btn btn-info" type="submit" value="Submit" name="submit" />
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>

