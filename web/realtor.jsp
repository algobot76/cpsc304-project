<%-- 
    Document   : realtor.jsp
    Created on : 27-Mar-2018, 6:04:14 PM
    Author     : Adi
--%>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<jsp:include page= "index.jsp">
    <jsp:param name="submit" value="submit"/>
</jsp:include>

<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
    document.forms[0].action = 'realtorListing.jsp';    
</script>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>        
    </body>
</html>
