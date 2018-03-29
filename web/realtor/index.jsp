<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<jsp:include page="/shared/navBar.jsp" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<jsp:include page="/shared/basicSearch.jsp">
    <jsp:param name="formAction" value="/realtor/realtorListing.jsp"/>
</jsp:include>

<sql:query var="sqlMaxAggregate" dataSource="jdbc/RentalSite">
    SELECT MAX(AvgPrices.avg_price) AS max_avg_price
    FROM (SELECT AVG(S.price) AS avg_price
    FROM Property P, ForSale S, PostalCode PC
    WHERE S.property_id = P.property_id AND P.postal_code = PC.postal_code
    GROUP BY PC.province) AS AvgPrices;
</sql:query>

<sql:query var="sqlMinAggregate" dataSource="jdbc/RentalSite">
    SELECT MIN(AvgPrices.avg_price) AS min_avg_price
    FROM (SELECT AVG(S.price) AS avg_price
    FROM Property P, ForSale S, PostalCode PC
    WHERE S.property_id = P.property_id AND P.postal_code = PC.postal_code
    GROUP BY PC.province) AS AvgPrices;
</sql:query>

<!--Report Queries-->
<sql:query var="divisionQuery" dataSource="jdbc/RentalSite">
    SELECT DISTINCT CCR1.customer_id
    FROM CustomerContactRealtor CCR1
    WHERE NOT EXISTS(
    SELECT CCR2.realtor_id
    FROM CustomerContactRealtor CCR2
    WHERE CCR2.realtor_id NOT IN
    (SELECT CCR3.realtor_id
    FROM CustomerContactRealtor CCR3
    WHERE CCR3.customer_id = CCR1.customer_id)
    );
</sql:query>

<sql:query var="totalSalesQuery" dataSource="jdbc/RentalSite">
    SELECT COUNT(property_id) AS num_properties
    FROM RentalDatabase.Sold
    WHERE YEAR(date_sold) = YEAR(CURDATE());
</sql:query>

<c:set var="maxAggregateDetails" value="${sqlMaxAggregate.rows[0]}"/>
<c:set var="minAggregateDetails" value="${sqlMinAggregate.rows[0]}"/>
<%--<c:set var="divisionDetails" value="${divisionQuery.rows[0]}"/>
<c:set var="salesDetails" value="${totalSalesQuery.rows[0]}"/>--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Bootstrap Example</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-body">
                    <strong>Find the highest/lowest average price of all ForSale properties</strong>

                    <br></br>

                    <strong>Choose the aggregate function</strong>

                    <br></br>

                    <select id="aggregate_input">
                        <option value="min">MIN</option>
                        <option value="max">MAX</option>
                    </select>


                    <button class="btn btn-info aggregateButton" type="button">Search Value</button>
                    <br></br>


                    <table class="table table-hover aggregateTable ">
                        <tr><th></th></tr>
                    </table>

                </div>
            </div>
        </div>

        <div>
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <strong>Reports</strong>

                        <br></br>

                        <table class="table table-hover divisionReportTable ">
                            <c:forEach var="row" items="${divisionQuery.rowsByIndex}">
                                <tr>
                                    <td>Number of customers who have contacted all realtors:</td>
                                    <c:forEach var="column" items="${row}">
                                        <td><c:out value="${column}"/></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </table>
                        <br></br>
                        <table class="table table-hover salesReportTable ">
                            <c:forEach var="row" items="${totalSalesQuery.rowsByIndex}">
                                <tr>
                                    <td>Total number of sales this year:                 </td>
                                    <c:forEach var="column" items="${row}">
                                        <td><c:out value="${column}"/></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </table>

                    </div>
                </div>
            </div>
        </div>

    </body>
</html>

<script type="text/javascript">
    $(function () {
        var html = '';
        $(".aggregateButton").on("click", function () {
            $(".aggregateTable").find("tr:gt(0)").remove();
            if ($("#aggregate_input").find(":selected").text() == "MAX") {
                $(".aggregateTable tr>th:first").html("Maximum Average Price");
                $(".aggregateTable").append('<tr><td>"${sqlMaxAggregate.rowsByIndex[0][0]}"</td></tr>');
            } else {
                $(".aggregateTable tr>th:first").html("Minimum Average Price");
                $(".aggregateTable").append('<tr><td>"${sqlMinAggregate.rowsByIndex[0][0]}"</td></tr>');
            }
        });
    });
</script>
