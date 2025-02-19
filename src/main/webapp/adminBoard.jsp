<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.hibernate.Session, org.hibernate.query.Query, com.util.HibernateUtil, java.util.*, com.pojo.Booking, com.pojo.MovieDetails" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" type="text/css" href="dashboardstyle.css">
</head>
<body>
    <div class="container">
        <h1>Admin Dashboard</h1>
        <button onclick="location.href='usersEdit.jsp'">Users</button>
        <button onclick="location.href='moviesEdit.jsp'">Movies</button>
        <button onclick="location.href='moviesDetailsEdit.jsp'">Movie Details</button>
        <button onclick="location.href='placesEdit.jsp'">Places</button>
        <button onclick="location.href='bookingEdit.jsp'">Booking</button>

        <!-- Chart Container for Horizontal Alignment -->
        <div class="charts-container">
            <div class="chart-box">
                <h2>Trending Movies</h2>
                <canvas id="trendingMoviesChart"></canvas>
            </div>
            <div class="chart-box">
                <h2>Top Places People Watched Movies</h2>
                <canvas id="topPlacesChart"></canvas>
            </div>
            <div class="chart-box">
                <h2>Top Preferred Genres</h2>
                <canvas id="topGenresChart"></canvas>
            </div>
        </div>
    </div>

    <%
        Session s = HibernateUtil.getSessionFactory().openSession();

        Query<Object[]> trendingMoviesQuery = s.createQuery(
            "SELECT b.movie.title, COUNT(b.id) FROM Booking b GROUP BY b.movie ORDER BY COUNT(b.id) DESC",
            Object[].class
        );
        List<Object[]> trendingMovies = trendingMoviesQuery.setMaxResults(5).list();

        Query<Object[]> topPlacesQuery = s.createQuery(
            "SELECT b.place, COUNT(b.id) FROM Booking b GROUP BY b.place ORDER BY COUNT(b.id) DESC",
            Object[].class
        );
        List<Object[]> topPlaces = topPlacesQuery.setMaxResults(5).list();

        Query<Object[]> topGenresQuery = s.createQuery(
            "SELECT md.genre1, COUNT(b.id) FROM Booking b " +
            "JOIN MovieDetails md ON b.movie.id = md.movie.id " +
            "GROUP BY md.genre1 ORDER BY COUNT(b.id) DESC",
            Object[].class
        );
        List<Object[]> topGenres = topGenresQuery.setMaxResults(5).list();

        s.close();
    %>

    <script>
        var movieTitles = [];
        var movieCounts = [];
        <% for (Object[] movie : trendingMovies) { %>
            movieTitles.push("<%= movie[0] %>");
            movieCounts.push(<%= movie[1] %>);
        <% } %>

        var ctxMovies = document.getElementById('trendingMoviesChart').getContext('2d');
        new Chart(ctxMovies, {
            type: 'bar',
            data: {
                labels: movieTitles,
                datasets: [{
                    label: 'Bookings',
                    data: movieCounts,
                    backgroundColor: 'rgba(75, 192, 192, 0.6)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        var placeNames = [];
        var placeCounts = [];
        <% for (Object[] place : topPlaces) { %>
            placeNames.push("<%= place[0] %>");
            placeCounts.push(<%= place[1] %>);
        <% } %>

        var ctxPlaces = document.getElementById('topPlacesChart').getContext('2d');
        new Chart(ctxPlaces, {
            type: 'bar',
            data: {
                labels: placeNames,
                datasets: [{
                    label: 'Bookings',
                    data: placeCounts,
                    backgroundColor: 'rgba(255, 99, 132, 0.6)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        var genreNames = [];
        var genreCounts = [];
        <% for (Object[] genre : topGenres) { %>
            genreNames.push("<%= genre[0] %>");
            genreCounts.push(<%= genre[1] %>);
        <% } %>

        var ctxGenres = document.getElementById('topGenresChart').getContext('2d');
        new Chart(ctxGenres, {
            type: 'bar',
            data: {
                labels: genreNames,
                datasets: [{
                    label: 'Bookings',
                    data: genreCounts,
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });
    </script>
</body>
</html>
