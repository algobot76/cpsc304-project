<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBuqQSkoLK_yz9xEqNR5y2W6zsIdhlrygg"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js" integrity="sha256-JG6hsuMjFnQ2spWq0UiaDRJBaarzhFbUxiUTxQDA9Lk=" crossorigin="anonymous"></script>

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
    select C.* from Customer C INNER JOIN (SELECT DISTINCT CCR1.customer_id
    FROM CustomerContactRealtor CCR1
    WHERE NOT EXISTS(
    SELECT CCR2.realtor_id
    FROM CustomerContactRealtor CCR2
    WHERE CCR2.realtor_id NOT IN (SELECT CCR3.realtor_id
    FROM CustomerContactRealtor CCR3
    WHERE CCR3.customer_id = CCR1.customer_id))) CCRD on C.customer_id=CCRD.customer_id;
</sql:query>

<sql:query var="totalSalesQuery" dataSource="jdbc/RentalSite">
    SELECT COUNT(property_id) AS num_properties
    FROM RentalDatabase.Sold
    WHERE YEAR(date_sold) = YEAR(CURDATE());
</sql:query>

<sql:query var="avgPriceByProvince" dataSource="jdbc/RentalSite">
    select AvgPrices.avg_price, AvgPrices.province 
    from (select AVG(S.price) as avg_price, 
    PC.province as province from Property P, ForSale S, PostalCode PC 
    where S.property_id=P.property_id AND P.postal_code=PC.postal_code 
    GROUP BY PC.province) as AvgPrices;
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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="/shared/navBar.jsp" />
        <div class="container-fluid realtor-page">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light sidebar">
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

                            <a href="#" class="btn btn-success" id="test" onClick="fnExcelReport();">Export to Excel</a>
                        </div>
                        <div class="tab-pane fade" id="reports" role="tabpanel" aria-labelledby="reports-tab">
                            <h2>Reports</h2>
                            <br>
                            <div id="accordion">
                                <div class="card">
                                    <div class="card-header" id="headingOne">
                                        <h5 class="mb-0">
                                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                Highest/lowest average price of ForSale properties grouped by Province
                                            </button>
                                        </h5>
                                    </div>

                                    <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
                                        <div class="card-body">
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
                                <div class="card">
                                    <div class="card-header" id="headingTwo">
                                        <h5 class="mb-0">
                                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                Customers who have contacted all realtors
                                            </button>
                                        </h5>
                                    </div>
                                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                                        <div class="card-body">
                                            <table class="table table-hover divisionReportTable">
                                                <tr>
                                                    <c:forEach var="columnName" items="${divisionQuery.columnNames}">
                                                        <th>
                                                            <c:out value="${columnName}"/>
                                                        </th>
                                                    </c:forEach>
                                                </tr>
                                                <c:forEach var="row" items="${divisionQuery.rowsByIndex}">
                                                    <tr>
                                                        <c:forEach var="column" items="${row}">
                                                            <td>
                                                                <c:out value="${column}"/>
                                                            </td>
                                                        </c:forEach>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header" id="headingThree">
                                        <h5 class="mb-0">
                                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                Total number of sales this year
                                            </button>
                                        </h5>
                                    </div>
                                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                                        <div class="card-body">
                                            <table class="table table-hover salesReportTable ">
                                                <tr>
                                                    <td>Properties sold this year</td><td><c:out value="${totalSalesQuery.rows[0].num_properties}"/></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header" id="headingFour">
                                        <h5 class="mb-0">
                                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseThree">
                                                Average property price by province
                                            </button>
                                        </h5>
                                    </div>
                                    <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordion">
                                        <div class="card-body" style="overflow:auto">
                                            <canvas id="myChart" width="100%" height="40%"></canvas>
                                        </div>
                                    </div>
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
    var realtorID;
    $(function () {
        var html = '';
        $(".aggregateButton").on("click", function () {
            var maxAggregate = (parseFloat(${sqlMaxAggregate.rowsByIndex[0][0]}) || 0).toFixed(2);
            var minAggregate = (parseFloat(${sqlMinAggregate.rowsByIndex[0][0]}) || 0).toFixed(2);
            $(".aggregateTable").find("tr:gt(0)").remove();
            if ($("#aggregate_input").find(":selected").text() == "MAX") {
                $(".aggregateTable tr>th:first").html("Maximum Average Price");
                $(".aggregateTable").append('<tr><td>$' + maxAggregate + '</td></tr>');
            } else {
                $(".aggregateTable tr>th:first").html("Minimum Average Price");
                $(".aggregateTable").append('<tr><td>$' + minAggregate + '</td></tr>');
            }
        });

        $(".realtorLogin").on("click", function () {
            realtorID = $(".realtor_id").val();
            var messageChecked = $("#message_box").is(":checked");
            var cNameChecked = $("#customer_name").is(":checked");
            var cEmailChecked = $("#customer_email").is(":checked");
            var cPhoneChecked = $("#customer_phone").is(":checked");
            var dateChecked = $("#date_box").is(":checked");
            var url = [location.protocol, '//', location.host, "/RentalSite/realtor/message.jsp?"].join('');
            var uriParams = {
                "realtor_id": realtorID,
                "message_checked": messageChecked,
                "name_checked": cNameChecked,
                "email_checked": cEmailChecked,
                "phone_checked": cPhoneChecked,
                "date_checked": dateChecked
            }
            var uri = Object.keys(uriParams).map(key => {
                return [key, uriParams[key]].map(encodeURIComponent).join("=");
            }).join("&");
            $.ajax(url + uri, {
                success: result => {
                    $("#messages_table").empty();
                    $("#messages_table").append(result);
                    $("#messages_table > table").addClass("table table-hover");
                    $("#messages_table > table").attr('id', 'myTable');
                    console.log(result);
                },
//                error: err => {
//                    alert("Sorry, the ID is invalid");
//                    console.log(err);
//                }
            });
        });
        var price = [
    <c:forEach var="responseString" items = "${avgPriceByProvince.rows}">
        <c:out value="${responseString.avg_price}" />,
    </c:forEach>
        ];

        var labels = [
    <c:forEach var="responseString" items = "${avgPriceByProvince.rows}">
            '<c:out value="${responseString.province}" />',
    </c:forEach>
        ];

        var ctx = document.getElementById("myChart");
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                        label: "Average Property Price",
                        data: price,
                        "fill":false,
                        "backgroundColor":["rgba(255, 99, 132, 0.2)","rgba(255, 159, 64, 0.2)","rgba(255, 205, 86, 0.2)","rgba(75, 192, 192, 0.2)","rgba(54, 162, 235, 0.2)","rgba(153, 102, 255, 0.2)","rgba(201, 203, 207, 0.2)"],
                        "borderColor":["rgb(255, 99, 132)","rgb(255, 159, 64)","rgb(255, 205, 86)","rgb(75, 192, 192)","rgb(54, 162, 235)","rgb(153, 102, 255)","rgb(201, 203, 207)"],
                        "borderWidth":1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                }
            }
        });
    });

    function fnExcelReport() {
        if (!$("#message_box").is(":checked") && !$("#customer_name").is(":checked") && !$("#customer_email").is(":checked") &&
                !$("#customer_phone").is(":checked") && !$("#date_box").is(":checked") && $("#messages_table").is(':empty')) {
            alert("No checkboxes selected!");
            return;
        }

        var tab_text = '<html xmlns:x="urn:schemas-microsoft-com:office:excel">';
        tab_text = tab_text + '<head><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>';

        tab_text = tab_text + '<x:Name>Test Sheet</x:Name>';

        tab_text = tab_text + '<x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions></x:ExcelWorksheet>';
        tab_text = tab_text + '</x:ExcelWorksheets></x:ExcelWorkbook></xml></head><body>';

        tab_text = tab_text + "<table border='1px'>";
        tab_text = tab_text + $('#myTable').html();
        tab_text = tab_text + '</table></body></html>';

        var data_type = 'data:application/vnd.ms-excel';

        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");

        if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
            if (window.navigator.msSaveBlob) {
                var blob = new Blob([tab_text], {
                    type: "application/csv;charset=utf-8;"
                });
                navigator.msSaveBlob(blob, 'Test file.xls');
            }
        } else {
            $('#test').attr('href', data_type + ', ' + encodeURIComponent(tab_text));
            $('#test').attr('download', 'Test file.xls');
        }

    }
</script>


