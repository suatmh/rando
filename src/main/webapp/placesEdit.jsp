<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="com.util.HibernateUtil" %>
<%@ page import="com.pojo.Places" %>
<%@ page import="com.pojo.MovieDetails" %>

<%
    SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    Session s = sessionFactory.openSession();
    Transaction transaction = null;

    String action = request.getParameter("action");

    if (action != null) {
        transaction = s.beginTransaction();

        if (action.equals("add")) {
            String place1 = request.getParameter("place1");
            String place2 = request.getParameter("place2");
            String place3 = request.getParameter("place3");
            String place4 = request.getParameter("place4");
            String time1 = request.getParameter("time1");
            String time2 = request.getParameter("time2");
            String time3 = request.getParameter("time3");
            String time4 = request.getParameter("time4");
            int maxSeats = Integer.parseInt(request.getParameter("maxSeats"));
            int movieId = Integer.parseInt(request.getParameter("movie_id"));

            MovieDetails movie = s.get(MovieDetails.class, movieId);

            Places place = new Places();
            place.setPlace1(place1);
            place.setPlace2(place2);
            place.setPlace3(place3);
            place.setPlace4(place4);
            place.setTime1(time1);
            place.setTime2(time2);
            place.setTime3(time3);
            place.setTime4(time4);
            place.setMaxSeats(maxSeats);
            place.setMovieDetails(movie);

            s.save(place);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Places place = s.get(Places.class, id);
            if (place != null) {
                s.delete(place);
            }
        } else if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String place1 = request.getParameter("place1");
            String place2 = request.getParameter("place2");
            String place3 = request.getParameter("place3");
            String place4 = request.getParameter("place4");
            String time1 = request.getParameter("time1");
            String time2 = request.getParameter("time2");
            String time3 = request.getParameter("time3");
            String time4 = request.getParameter("time4");
            int maxSeats = Integer.parseInt(request.getParameter("maxSeats"));
            int movieId = Integer.parseInt(request.getParameter("movie_id"));

            MovieDetails movie = s.get(MovieDetails.class, movieId);
            Places place = s.get(Places.class, id);
            if (place != null) {
                place.setPlace1(place1);
                place.setPlace2(place2);
                place.setPlace3(place3);
                place.setPlace4(place4);
                place.setTime1(time1);
                place.setTime2(time2);
                place.setTime3(time3);
                place.setTime4(time4);
                place.setMaxSeats(maxSeats);
                place.setMovieDetails(movie);
                s.update(place);
            }
        }

        transaction.commit();
    }

    List<Places> placesList = s.createQuery("FROM Places", Places.class).list();
    s.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Places Management</title>
    <link rel="stylesheet" type="text/css" href="adminstyle.css">
</head>
<body>
    <h1>Places List</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Place 1</th>
            <th>Place 2</th>
            <th>Place 3</th>
            <th>Place 4</th>
            <th>Time 1</th>
            <th>Time 2</th>
            <th>Time 3</th>
            <th>Time 4</th>
            <th>Max Seats</th>
            <th>Movie ID</th>
            <th>Actions</th>
        </tr>
        <%
            for (Places place : placesList) {
        %>
        <tr>
            <td><%= place.getId() %></td>
            <td><%= place.getPlace1() %></td>
            <td><%= place.getPlace2() %></td>
            <td><%= place.getPlace3() %></td>
            <td><%= place.getPlace4() %></td>
            <td><%= place.getTime1() %></td>
            <td><%= place.getTime2() %></td>
            <td><%= place.getTime3() %></td>
            <td><%= place.getTime4() %></td>
            <td><%= place.getMaxSeats() %></td>
            <td><%= place.getMovieDetails().getId() %></td>
            <td>
                <a href="placesEdit.jsp?action=delete&id=<%= place.getId() %>">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <h2>Add Place</h2>
    <form action="placesEdit.jsp" method="post">
        <input type="hidden" name="action" value="add">
        Place 1: <input type="text" name="place1" required>
        Place 2: <input type="text" name="place2" required>
        Place 3: <input type="text" name="place3" required>
        Place 4: <input type="text" name="place4" required>
        Time 1: <input type="text" name="time1" required>
        Time 2: <input type="text" name="time2" required>
        Time 3: <input type="text" name="time3" required>
        Time 4: <input type="text" name="time4" required>
        Max Seats: <input type="number" name="maxSeats" required>
        Movie ID: <input type="number" name="movie_id" required>
        <input type="submit" value="Add Place">
    </form>

    <h2>Update Place</h2>
    <form action="placesEdit.jsp" method="post">
        <input type="hidden" name="action" value="update">
        ID: <input type="number" name="id" required>
        Place 1: <input type="text" name="place1" required>
        Place 2: <input type="text" name="place2" required>
        Place 3: <input type="text" name="place3" required>
        Place 4: <input type="text" name="place4" required>
        Time 1: <input type="text" name="time1" required>
        Time 2: <input type="text" name="time2" required>
        Time 3: <input type="text" name="time3" required>
        Time 4: <input type="text" name="time4" required>
        Max Seats: <input type="number" name="maxSeats" required>
        Movie ID: <input type="number" name="movie_id" required>
        <input type="submit" value="Update Place">
    </form>
</body>
</html>
