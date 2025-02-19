<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="com.util.HibernateUtil" %>
<%@ page import="com.pojo.Booking" %>
<%@ page import="com.pojo.User" %>
<%@ page import="com.pojo.Movie" %>
<%@ page import="com.pojo.Payment" %>

<%
    // Initialize Hibernate session
    SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    Session s = sessionFactory.openSession();
    
    // Fetch all booking data
    List<Booking> bookingList = s.createQuery("FROM Booking", Booking.class).list();
    
    s.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Management</title>
    <link rel="stylesheet" type="text/css" href="adminstyle.css">
</head>
<body>
    <h1>Booking List</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Movie ID</th>
            <th>Seats</th>
            <th>Time</th>
            <th>Place</th>
            <th>Payment ID</th>
        </tr>
        <%
            for (Booking booking : bookingList) {
        %>
        <tr>
            <td><%= booking.getId() %></td>
            <td><%= booking.getUser().getId() %></td>
            <td><%= booking.getMovie().getId() %></td>
            <td><%= booking.getSeats() %></td>
            <td><%= booking.getTime() %></td>
            <td><%= booking.getPlace() %></td>
            <td><%= (booking.getPayment() != null) ? booking.getPayment().getId() : "N/A" %></td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
