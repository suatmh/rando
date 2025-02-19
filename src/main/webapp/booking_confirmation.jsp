<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="display.css"><title>Booking Confirmation</title>
</head>
<body>
    <nav style="background-color: 040404; padding: 10px; text-align: center;">
        <a href="UserProfile.jsp" style="margin: 0 15px; text-decoration: none; color: #fff;">Profile</a>
        <a href="MovieServlet" style="margin: 0 15px; text-decoration: none; color: #fff;">Movies</a>
        
    </nav>
    <div class="lcontainer">
        <h1 style=" text-align: center;">Booking Confirmation</h1>
        <%
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.html");
            return;
        }
        
        int movieId = Integer.parseInt(request.getParameter("movieId"));    
            String movie = request.getParameter("movie");
            String seats = request.getParameter("seats");
            String time = request.getParameter("time");
            String place = request.getParameter("place");
            double price = Double.parseDouble(request.getParameter("price"));
            int numSeats = Integer.parseInt(seats);
            double totalPrice = price * numSeats;%>
        <p><b>Movie:</b> <%= movie %></p>
        <p><b>Time:</b> <%= time %></p>
        <p><b>Place:</b> <%= place %></p>
        <p><b>Number of Seats:</b> <%= seats %></p>
        <p><b>Total:</b> <%= totalPrice %></p>
        <form action="Payment.jsp" method="POST">
        <input type="hidden" name="movieId" value="<%= movieId %>">
            <input type="hidden" name="movie" value="<%= movie %>">
            <input type="hidden" name="seats" value="<%= seats %>">
            <input type="hidden" name="time" value="<%= time %>">
            <input type="hidden" name="place" value="<%= place %>">
            <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
            <button type="submit">Proceed to Payment</button></form><br>
    </div>
</body></html>
