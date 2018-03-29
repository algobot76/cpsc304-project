<jsp:include page="/shared/navBar.jsp" />


<div class="customer-search">
    <jsp:include page="/shared/basicSearch.jsp">
        <jsp:param name="formAction" value="/customer/customerListing.jsp"/>
    </jsp:include>
</div>

