<%@ page import="java.io.IOException" %>
<%@ page session="true" %>
<%
    if (session != null) {
        session.invalidate();
    }
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setDateHeader("Expires", 0); 
    response.setHeader("Cache-Control", "private, no-cache, no-store, must-revalidate");
    response.sendRedirect("login.html");
%>
