<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="com.util.HibernateUtil" %>
<%@ page import="com.pojo.MovieDetails" %>
<%@ page import="com.pojo.Movie" %>

<%
    SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    Session s = sessionFactory.openSession();
    Transaction transaction = null;

    String action = request.getParameter("action");
    if (action != null) {
        transaction = s.beginTransaction();

        if (action.equals("add")) {
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int movieId = Integer.parseInt(request.getParameter("movieId"));
            String genre1 = request.getParameter("genre1");
            String genre2 = request.getParameter("genre2");
            String genre3 = request.getParameter("genre3");

            Movie movie = s.get(Movie.class, movieId);
            if (movie != null) {
                MovieDetails movieDetails = new MovieDetails();
                movieDetails.setDescription(description);
                movieDetails.setPrice(price);
                movieDetails.setMovie(movie);
                movieDetails.setGenre1(genre1);
                movieDetails.setGenre2(genre2);
                movieDetails.setGenre3(genre3);
                s.save(movieDetails);
            }
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            MovieDetails movieDetails = s.get(MovieDetails.class, id);
            if (movieDetails != null) {
                s.delete(movieDetails);
            }
        } else if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String genre1 = request.getParameter("genre1");
            String genre2 = request.getParameter("genre2");
            String genre3 = request.getParameter("genre3");

            MovieDetails movieDetails = s.get(MovieDetails.class, id);
            if (movieDetails != null) {
                movieDetails.setDescription(description);
                movieDetails.setPrice(price);
                movieDetails.setGenre1(genre1);
                movieDetails.setGenre2(genre2);
                movieDetails.setGenre3(genre3);
                s.update(movieDetails);
            }
        }

        transaction.commit();
    }

    List<MovieDetails> movieDetailsList = s.createQuery("FROM MovieDetails", MovieDetails.class).list();
    s.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Movie Details Management</title>
    <link rel="stylesheet" type="text/css" href="adminstyle.css">
</head>
<body>
    <h1>Movie Details List</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Description</th>
            <th>Price</th>
            <th>Movie Title</th>
            <th>Genre 1</th>
            <th>Genre 2</th>
            <th>Genre 3</th>
            <th>Actions</th>
        </tr>
        <%
            for (MovieDetails md : movieDetailsList) {
        %>
        <tr>
            <td><%= md.getId() %></td>
            <td><%= md.getDescription() %></td>
            <td><%= md.getPrice() %></td>
            <td><%= md.getMovie().getTitle() %></td>
            <td><%= md.getGenre1() %></td>
            <td><%= md.getGenre2() %></td>
            <td><%= md.getGenre3() %></td>
            <td>
                <a href="moviesDetailsEdit.jsp?action=delete&id=<%= md.getId() %>">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <h2>Add Movie Details</h2>
    <form action="moviesDetailsEdit.jsp" method="post">
        <input type="hidden" name="action" value="add">
        Description: <input type="text" name="description" required>
        Price: <input type="number" name="price" step="0.01" required>
        Movie ID: <input type="number" name="movieId" required>
        Genre 1: <input type="text" name="genre1" required>
        Genre 2: <input type="text" name="genre2">
        Genre 3: <input type="text" name="genre3">
        <input type="submit" value="Add Movie Details">
    </form>

    <h2>Update Movie Details</h2>
    <form action="moviesDetailsEdit.jsp" method="post">
        <input type="hidden" name="action" value="update">
        ID: <input type="number" name="id" required>
        New Description: <input type="text" name="description" required>
        New Price: <input type="number" name="price" step="0.01" required>
        Genre 1: <input type="text" name="genre1" required>
        Genre 2: <input type="text" name="genre2">
        Genre 3: <input type="text" name="genre3">
        <input type="submit" value="Update Movie Details">
    </form>
</body>
</html>
