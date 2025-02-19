<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="com.pojo.Movie" %>
<%@ page import="com.pojo.Booking" %>
<%@ page import="com.pojo.MovieDetails" %>
<%@ page import="com.dao.MovieDetailsDAO" %>
<%@ page import="com.dao.UserDAO" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="com.util.HibernateUtil" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="r.css">
    <title>Movies Available</title>
</head>
<body>
    <video autoplay muted loop id="bgVideo">
        <source src="images/moives(background).mp4" type="video/mp4">
    </video>
    
    <nav class="navbar">
        <a href="UserProfile.jsp">Profile</a>
        <a href="MovieServlet">Movies</a>
    </nav>

    <div class="content">
        <div class="section-title">
            <h2>RECOMMENDED MOVIES</h2>
        </div>
        
        <table>
            <tr>
                <td colspan="3">
                    <div class="movie-container">
                        <%  
                            String username = (String) session.getAttribute("username");
                            if (username == null) {
                                response.sendRedirect("login.html");
                                return;
                            }

                            int userId = -1;
                            Session s = HibernateUtil.getSessionFactory().openSession();
                            try {
                                String userHQL = "SELECT u.id FROM User u WHERE u.username = :username";
                                Query<Integer> userQuery = s.createQuery(userHQL, Integer.class);
                                userQuery.setParameter("username", username);
                                userId = userQuery.uniqueResult();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }

                            List<Movie> recommendedMovies = null;
                            if (userId != -1) {
                                try {
                                    String bookingsHQL = "FROM Booking WHERE user.id = :userId";
                                    Query<Booking> bookingsQuery = s.createQuery(bookingsHQL, Booking.class);
                                    bookingsQuery.setParameter("userId", userId);
                                    List<Booking> bookings = bookingsQuery.list();

                                    if (!bookings.isEmpty()) {
                                        Set<String> userPreferredGenres = new HashSet<>();
                                        for (Booking booking : bookings) {
                                            Movie movie = booking.getMovie();
                                            String movieDetailsHQL = "FROM MovieDetails WHERE movie.id = :movieId";
                                            Query<MovieDetails> movieDetailsQuery = s.createQuery(movieDetailsHQL, MovieDetails.class);
                                            movieDetailsQuery.setParameter("movieId", movie.getId());
                                            MovieDetails movieDetails = movieDetailsQuery.uniqueResult();

                                            if (movieDetails != null) {
                                                if (movieDetails.getGenre1() != null) userPreferredGenres.add(movieDetails.getGenre1());
                                                if (movieDetails.getGenre2() != null) userPreferredGenres.add(movieDetails.getGenre2());
                                                if (movieDetails.getGenre3() != null) userPreferredGenres.add(movieDetails.getGenre3());
                                            }
                                        }

                                        if (!userPreferredGenres.isEmpty()) {
                                            String genreMatchHQL = "SELECT DISTINCT md.movie FROM MovieDetails md WHERE md.genre1 IN (:genres) " +
                                                               "OR md.genre2 IN (:genres) OR md.genre3 IN (:genres)";
                                            Query<Movie> genreQuery = s.createQuery(genreMatchHQL, Movie.class);
                                            genreQuery.setParameter("genres", userPreferredGenres);
                                            recommendedMovies = genreQuery.list();
                                        }
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                            s.close();

                            if (recommendedMovies != null && !recommendedMovies.isEmpty()) {
                                for (int i = 0; i < recommendedMovies.size(); i++) {
                                    Movie movie = recommendedMovies.get(i);
                        %>
                            <div class="movie-item">
                                <img src="<%= movie.getImagePath() %>" alt="<%= movie.getTitle() %>" height="250">
                                <br>
                                <a href="MovieDetailsServlet?movieId=<%= movie.getId() %>"><%= movie.getTitle() %></a>
                            </div>
                        <%
                                }
                            } else {
                                out.print("<p style='color:white;'>No recommendations available</p>");
                            }
                        %>
                    </div>
                </td>
            </tr>
        </table>
    
        <hr>

        <div class="section-title">
            <h2>ALL MOVIES</h2>
        </div>
        
        <table>
            <tr>
                <td colspan="3">
                    <div class="movie-container">
                        <%  
                            List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                            if (movies != null && !movies.isEmpty()) {
                                for (int i = 0; i < movies.size(); i++) {
                                    Movie movie = movies.get(i);
                        %>
                            <div class="movie-item">
                                <img src="<%= movie.getImagePath() %>" alt="<%= movie.getTitle() %>" height="250">
                                <br>
                                <a href="MovieDetailsServlet?movieId=<%= movie.getId() %>"><%= movie.getTitle() %></a>
                            </div>
                        <%
                                }
                            } else {
                                out.print("<p>No movies available</p>");
                            }
                        %>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
