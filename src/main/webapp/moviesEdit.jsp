<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="com.util.HibernateUtil" %>
<%@ page import="com.pojo.Movie" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>

<%
    SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    Session s = sessionFactory.openSession();
    Transaction transaction = null;
    
    String action = request.getParameter("action");
    if (action != null) {
        transaction = s.beginTransaction();
        
        if (action.equals("add")) {
            String title = request.getParameter("title");
            String imagePath = request.getParameter("imagePath");
            Movie movie = new Movie();
            movie.setTitle(title);
            movie.setImagePath(imagePath);
            s.save(movie);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Movie movie = s.get(Movie.class, id);
            if (movie != null) {
                s.delete(movie);
            }
        } else if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String imagePath = request.getParameter("imagePath");
            Movie movie = s.get(Movie.class, id);
            if (movie != null) {
                movie.setTitle(title);
                movie.setImagePath(imagePath);
                s.update(movie);
            }
        }
        
        transaction.commit();
    }
    
    List<Movie> movies = s.createQuery("FROM Movie", Movie.class).list();
    s.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Movies Management</title>
    <link rel="stylesheet" type="text/css" href="adminstyle.css">
</head>
<body>
    <div class="container">
        <h1>Movies List</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Image Path</th>
                <th>Actions</th>
            </tr>
            <%
                for (Movie movie : movies) {
            %>
            <tr>
                <td><%= movie.getId() %></td>
                <td><%= movie.getTitle() %></td>
                <td><%= movie.getImagePath() %></td>
                <td>
                    <a href="moviesEdit.jsp?action=delete&id=<%= movie.getId() %>" class="delete-btn">Delete</a>
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <h2>Add Movie</h2>
        <form action="moviesEdit.jsp" method="post">
            <input type="hidden" name="action" value="add">
            <label for="title">Title:</label>
            <input type="text" name="title" id="title" required>
            
            <label for="imagePath">Image Path:</label>
            <input type="text" name="imagePath" id="imagePath" required>

            <input type="submit" value="Add Movie" class="btn">
        </form>

        <h2>Update Movie</h2>
        <form action="moviesEdit.jsp" method="post">
            <input type="hidden" name="action" value="update">
            <label for="id">ID:</label>
            <input type="number" name="id" id="id" required>

            <label for="newTitle">New Title:</label>
            <input type="text" name="title" id="newTitle" required>

            <label for="newImagePath">New Image Path:</label>
            <input type="text" name="imagePath" id="newImagePath" required>

            <input type="submit" value="Update Movie" class="btn">
        </form>
    </div>
</body>
</html>
