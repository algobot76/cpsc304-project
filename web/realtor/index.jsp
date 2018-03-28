<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<jsp:include page="/shared/navBar.jsp" />

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
                              
                                        
                    <c:set var="maxAggregateDetails" value="${sqlMaxAggregate.rows[0]}"/>
                    <c:set var="minAggregateDetails" value="${sqlMinAggregate.rows[0]}"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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


                    <button class="aggregateButton" type="button">Search Value</button>
                    <br></br>

                   
                    <table class="aggregateTable table-striped">
                        <tr>
                            <th></th>
                        </tr>
                        <tbody>
                            <tr>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </body>
</html>

<script type="text/javascript">
$( function() { 
    var html = '';
    
    $( ".aggregateButton" ).on( "click", function() {
      // $(".aggregateTable > tbody").remove();
      if($( "#aggregate_input" ).find(":selected").text() == "MAX"){
          $(".aggregateTable tr>th:first").html("Maximum Average Price");
          $(".aggregateTable").after('<tr><td>"${sqlMaxAggregate.rowsByIndex[0][0]}"</td></tr>');
      } else {
          $(".aggregateTable tr>th:first").html("Minimum Average Price");
          $(".aggregateTable").after('<tr><td>"${sqlMinAggregate.rowsByIndex[0][0]}"</td></tr>');
      }
    });
  } );
</script>
