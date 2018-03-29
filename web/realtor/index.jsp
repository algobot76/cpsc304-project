<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<jsp:include page="/shared/navBar.jsp" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

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

<sql:query var="messagesQuery" dataSource="jdbc/RentalSite">
    SELECT * FROM CustomerContactRealtor 
    WHERE realtor_id = YEAR(CURDATE());
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
        <title>Rental Site</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light">
                    <div class="side-nav">
                        <ul class="nav flex-column" id="realtor-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="search-tab" data-toggle="tab" href="#search" role="tab" aria-controls="search" aria-selected="true">Search</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="messages-tab" data-toggle="tab" href="#messages" role="tab" aria-controls="messages" aria-selected="false">Messages</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="reports-tab" data-toggle="tab" href="#reports" role="tab" aria-controls="reports" aria-selected="false">Reports</a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <div class="content col-md-9 ml-sm-auto col-lg-10">
                    <div class="tab-content" id="realtor-tabs-content">
                        <div class="tab-pane fade show active" id="search" role="tabpanel" aria-labelledby="search-tab">
                            <jsp:include page="/shared/basicSearch.jsp">
                                <jsp:param name="formAction" value="/realtor/realtorListing.jsp"/>
                            </jsp:include>
                        </div>
                        <div class="tab-pane fade" id="messages" role="tabpanel" aria-labelledby="messages-tab">
                            <h2>View Messages</h2>
                            <br></br>
                            <strong>Enter your ID</strong>
                            <input class="realtor_id" type="text" name="realtor_id" value="" />
                            <br></br>
                            <h3>Select what you'd like to view</h3>
                            <br></br>
                            <label for='message_box'>Message</label> <input type="checkbox" id="message_box" />
                            <br></br>
                            <label for='customer_name'></label>Customer Name<input type="checkbox" id="customer_name" />
                            <br></br>
                            <label for='customer_email'>Customer Email</label> <input type="checkbox" id="customer_email" />
                            <br></br>
                            <label for='customer_phone'>Customer Phone</label> <input type="checkbox" id="customer_phone" />
                            <br></br>
                            <label for='date_box'></label>Date<input type="checkbox" id="date_box" id="ON" />
                            <br></br>

                            <button class="btn btn-info realtorLogin" value="Login"/>Submit</button>                    

                            <div id="messages_table" class="table table-striped"> 
                            </div>
                        </div>
                        <div class="tab-pane fade" id="reports" role="tabpanel" aria-labelledby="reports-tab">
                            <div class="card">
                                <div class="card-body">
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
                            <div class="card">
                                <div class="card-body">
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
