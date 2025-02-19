<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pojo.User, com.pojo.Booking, com.pojo.Movie, com.util.HibernateUtil, org.hibernate.*, java.util.List" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="display.css">
    <title>User Profile</title>
    <style>
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #1a1a1a;
            border-radius: 8px;
            color: #fff;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
            display: block; /* Ensure the container is block-level */
        }

        h1, h2 {
            text-align: center;
            color: #f0f0f0;
        }

        .profile-details, .booking-history {
            margin-bottom: 30px;
            width: 100%; /* Ensure they take the full width */
        }

        .profile-details p, .booking-history p {
            font-size: 18px;
            line-height: 1.6;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #444;
        }

        table th {
            background-color: #333;
        }

        table tr:nth-child(even) {
            background-color: #333;
        }

        table td {
            color: #f0f0f0;
        }
    </style>
</head>
<body>
    <nav style="background-color: 040404; padding: 10px; text-align: center;">
        <a href="UserProfile.jsp" style="margin: 0 15px; text-decoration: none; color: #fff;">Profile</a>
        <a href="MovieServlet" style="margin: 0 15px; text-decoration: none; color: #fff;">Movies</a>
        <a href="logout.jsp" style="margin: 0 15px; text-decoration: none; color: #fff;">Logout</a>
    </nav>

    <div class="container">
        <h1>User Profile</h1>
        <%
            String username = (String) session.getAttribute("username");
            if (username == null) {
                response.sendRedirect("login.html");
                return;
            }

            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            Transaction transaction = null;
            User user = null;
            List<Booking> bookings = null;

            try {
                transaction = hibernateSession.beginTransaction();

                String userHQL = "FROM User WHERE username = :username";
                Query<User> userQuery = hibernateSession.createQuery(userHQL, User.class);
                userQuery.setParameter("username", username);
                user = userQuery.uniqueResult();

                if (user != null) {
                    String bookingHQL = "FROM Booking WHERE user.id = :userId";
                    Query<Booking> bookingQuery = hibernateSession.createQuery(bookingHQL, Booking.class);
                    bookingQuery.setParameter("userId", user.getId());
                    bookings = bookingQuery.list();
                }

                transaction.commit();
            } catch (Exception e) {
                if (transaction != null) transaction.rollback();
                e.printStackTrace();
            } finally {
                hibernateSession.close();
            }

            if (user != null) {
        %>

        <div class="profile-details">
            <h2>Profile Details</h2>
            <p><b>Username:</b> <%= user.getUsername() %></p>
            <p><b>Email:</b> <%= user.getEmail() %></p>
        </div>

        <div class="booking-history">
            <h2>Booking History</h2>
            <% if (bookings != null && !bookings.isEmpty()) { %>
            <table>
                <tr>
                    <th>Movie</th>
                    <th>Time</th>
                    <th>Place</th>
                    <th>Seats</th>
                    <th>Total Price</th>
                </tr>
                <%
                    for (Booking booking : bookings) {
                %>
                <tr>
                    <td><%= booking.getMovie().getTitle() %></td>
                    <td><%= booking.getTime() %></td>
                    <td><%= booking.getPlace() %></td>
                    <td><%= booking.getSeats() %></td>
                    <td>RS <%= booking.getPayment().getTotalPrice() %></td>
                </tr>
                <% } %>
            </table>
            <% } else { %>
            <p>No bookings found.</p>
            <% } %>
        </div>

        <% } else { %>
        <p style="color: red;">User not found. Please log in again.</p>
        <a href="login.html">Go to Login</a>
        <% } %>
    </div>
</body>
</html>
