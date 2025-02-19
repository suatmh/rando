<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="display.css"><title>Payment Information</title>
</head>
<body>
    <nav style="background-color: 040404; padding: 10px; text-align: center;">
        <a href="UserProfile.jsp" style="margin: 0 15px; text-decoration: none; color: #fff;">Profile</a>
        <a href="MovieServlet" style="margin: 0 15px; text-decoration: none; color: #fff;">Movies</a>
        
    </nav>
    <div class="lcontainer">
        <h1 style=" text-align: center;">Payment Information</h1>
        <form action="ticket.jsp" method="POST">
            <p><b>Card Number:</b></p>
            <input type="text" name="cardNumber" required>
            <p><b>Expiry Date:</b></p>
            <input type="text" name="expiryDate" required>
            <p><b>CVV:</b></p>
            <input type="text" name="cvv" required><br><br>
            <input type="hidden" name="movieId" value="<%= request.getParameter("movieId") %>">
            <input type="hidden" name="seats" value="<%= request.getParameter("seats") %>">
            <input type="hidden" name="time" value="<%= request.getParameter("time") %>">
            <input type="hidden" name="place" value="<%= request.getParameter("place") %>">
            <input type="hidden" name="totalPrice" value="<%= request.getParameter("totalPrice") %>">
            <button type="submit">Pay</button></form><br>
    </div>
</body></html>
