<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String)request.getAttribute("error");
    if(error != null){
%>
<div class="alert-div">
    <%= error%>
</div>
<%
    }
%>