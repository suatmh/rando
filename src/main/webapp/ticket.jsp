<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pojo.Payment, com.pojo.Booking, com.pojo.User, com.pojo.Movie, com.pojo.Places, com.util.HibernateUtil, org.hibernate.*,java.io.*,com.dao.UserDAO, com.dao.PlacesDAO" %>
<%@ page session="true" %>
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
        <h1 style=" text-align: center;">Booking Confirmed</h1>
        <%     
        String username = (String) session.getAttribute("username");
       if (username == null) {
            response.sendRedirect("login.html");
            return;
        }
        if ("POST".equalsIgnoreCase(request.getMethod())) {
                String cardNumber = request.getParameter("cardNumber");
                String expiryDate = request.getParameter("expiryDate");
                String cvv = request.getParameter("cvv");
                double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
                int movieId = Integer.parseInt(request.getParameter("movieId"));
                int seats = Integer.parseInt(request.getParameter("seats"));
                String time = request.getParameter("time");
                String place = request.getParameter("place");
                //String username = (String) session.getAttribute("username");
                Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByUsername(username);
                Movie movie = hibernateSession.get(Movie.class, movieId);          
                int placeId = movieId;
                PlacesDAO placesDAO = new PlacesDAO();
                placesDAO.updateMaxSeats(placeId, seats);
                Payment payment = new Payment();
                payment.setCardNumber(cardNumber);
                payment.setExpiryDate(expiryDate);
                payment.setCvv(cvv);
                payment.setTotalPrice(totalPrice);
                Booking booking = new Booking();
                booking.setUser(user);
                booking.setMovie(movie);
                booking.setSeats(seats);
                booking.setTime(time);
                booking.setPlace(place);
                booking.setPayment(payment);
                hibernateSession.beginTransaction();
                hibernateSession.save(payment);
                hibernateSession.save(booking);
                hibernateSession.getTransaction().commit();
                hibernateSession.close();
                String email = user.getEmail();
                out.println("<p>Payment successful! Your booking has been confirmed. A ticket has been sent to your email (" + email + ").</p>");
                out.println("<p><b>Movie:</b> " + movie.getTitle() + "</p>");
                out.println("<p><b>Time:</b> " + time + "</p>");
                out.println("<p><b>Place:</b> " + place + "</p>");
                out.println("<p><b>Number of Seats:</b> " + seats + "</p>");
                out.println("<p><b>Total Price:</b> RS " + totalPrice + "</p>");}
        %>
        <br>
    </div>
</body></html>
