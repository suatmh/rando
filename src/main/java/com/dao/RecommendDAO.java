package com.dao;

import com.pojo.Movie;
import com.pojo.Booking;
import com.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class RecommendDAO {

    public List<Movie> getRecommendations(int userId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<Movie> recommendedMovies = new ArrayList<>();

        try {
            // Step 1: Fetch all previously booked movies by the user
            String bookingsHQL = "FROM Booking WHERE user.id = :userId";
            Query<Booking> bookingsQuery = session.createQuery(bookingsHQL, Booking.class);
            bookingsQuery.setParameter("userId", userId);
            List<Booking> bookings = bookingsQuery.list();

            if (!bookings.isEmpty()) {
                // Step 2: Collect genres of the previously booked movies
                Set<String> userPreferredGenres = new HashSet<>();
                for (Booking booking : bookings) {
                    Movie movie = booking.getMovie();
                    String movieDetailsHQL = "FROM MovieDetails WHERE movie.id = :movieId";
                    Query<com.pojo.MovieDetails> movieDetailsQuery = session.createQuery(movieDetailsHQL, com.pojo.MovieDetails.class);
                    movieDetailsQuery.setParameter("movieId", movie.getId());
                    com.pojo.MovieDetails movieDetails = movieDetailsQuery.uniqueResult();

                    if (movieDetails != null) {
                        if (movieDetails.getGenre1() != null) userPreferredGenres.add(movieDetails.getGenre1());
                        if (movieDetails.getGenre2() != null) userPreferredGenres.add(movieDetails.getGenre2());
                        if (movieDetails.getGenre3() != null) userPreferredGenres.add(movieDetails.getGenre3());
                    }
                }

                // Step 3: Fetch movies matching the user's preferred genres
                if (!userPreferredGenres.isEmpty()) {
                    String genreMatchHQL = "SELECT DISTINCT md.movie FROM MovieDetails md WHERE md.genre1 IN (:genres) " +
                                           "OR md.genre2 IN (:genres) OR md.genre3 IN (:genres)";
                    Query<Movie> genreQuery = session.createQuery(genreMatchHQL, Movie.class);
                    genreQuery.setParameter("genres", userPreferredGenres);
                    recommendedMovies = genreQuery.list();
                }
            }

        } finally {
            session.close();
        }

        return recommendedMovies;
    }
}
