<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pojo.MovieDetails, com.pojo.Places" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="display.css"><title>Movie Summary</title>
</head>
<body>
    <nav style="background-color: 040404; padding: 10px; text-align: center;">
        <a href="UserProfile.jsp" style="margin: 0 15px; text-decoration: none; color: #fff;">Profile</a>
        <a href="MovieServlet" style="margin: 0 15px; text-decoration: none; color: #fff;">Movies</a>
        
    </nav>
    <div class="container">
        <%
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.html");
            return;
        }
        MovieDetails movieDetails = (MovieDetails) request.getAttribute("movieDetails");
            if (movieDetails != null) {
                Places places = movieDetails.getPlaces();
                int maxSeats = places.getMaxSeats();%>
        <div>
            <h1 style=" text-align: left;"><%= movieDetails.getTitle() %></h1><br>
            <pre><b><%= movieDetails.getDescription() %></b></pre>
            <p><b>RS <%= movieDetails.getPrice() %> </b></p><br>
            <form action="booking_confirmation.jsp" method="POST">
                <input type="hidden" name="price" value="<%= movieDetails.getPrice() %>">
                <input type="hidden" name="movie" value="<%= movieDetails.getTitle() %>">
                 <input type="hidden" name="movieId" value="<%= movieDetails.getMovie().getId() %>">
                <p><b>Number of seats</b></p>
                <input type="number" name="seats" id="seats" onblur="checkSeats(<%= maxSeats %>)">
                <p id="seatError" style="color: red; display: none;">Seats not available</p>
                <p><b>Time</b></p>
                <div style="display: flex; justify-content: space-between;">
                    <div><input type="radio" id="time1" value="<%= places.getTime1() %>" name="time"><label for="time1"><%= places.getTime1() %></label></div>
                    <div><input type="radio" id="time2" value="<%= places.getTime2() %>" name="time"><label for="time2"><%= places.getTime2() %></label></div>
                    <div><input type="radio" id="time3" value="<%= places.getTime3() %>" name="time"><label for="time3"><%= places.getTime3() %></label></div>
                    <div><input type="radio" id="time4" value="<%= places.getTime4() %>" name="time"><label for="time4"><%= places.getTime4() %></label></div>
                </div>
                <p><b>Place</b></p>
                <div style="display: flex; justify-content: space-between;">
                    <div><input type="radio" id="place1" value="<%= places.getPlace1() %>" name="place"><label for="place1"><%= places.getPlace1() %></label></div>
                    <div><input type="radio" id="place2" value="<%= places.getPlace2() %>" name="place"><label for="place2"><%= places.getPlace2() %></label></div>
                    <div><input type="radio" id="place3" value="<%= places.getPlace3() %>" name="place"><label for="place3"><%= places.getPlace3() %></label></div>
                    <div><input type="radio" id="place4" value="<%= places.getPlace4() %>" name="place"><label for="place4"><%= places.getPlace4() %></label></div>
                </div><br>
                <button type="submit" id="submitButton" disabled>Next</button>
            </form><br>
            <button onclick=window.history.back()>Go Back</button>
        </div>
        <img src="<%= movieDetails.getImagePath() %>" alt="Movie Image">
        <%} else {out.println("Movie details not found.");}%>
    </div>
    <script>
        function checkSeats(maxSeats) {
            var seats = document.getElementById("seats").value;
            var seatError = document.getElementById("seatError");
            var submitButton = document.getElementById("submitButton");
            if (parseInt(seats) > maxSeats) {
                seatError.style.display = "block";
                submitButton.disabled = true;
            } else {seatError.style.display = "none";submitButton.disabled = false;}
        }
    </script>
</body></html>
