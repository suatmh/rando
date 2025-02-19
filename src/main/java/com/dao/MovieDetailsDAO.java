package com.dao;
import org.hibernate.Session;
import org.hibernate.query.Query;
import com.pojo.MovieDetails;
import com.util.HibernateUtil;
public class MovieDetailsDAO {
    public MovieDetails getMovieDetailsByMovieId(int movieId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        MovieDetails movieDetails = null;
        try {
            String hql = "FROM MovieDetails WHERE movie.id = :movieId";
            Query<MovieDetails> query = session.createQuery(hql, MovieDetails.class);
            query.setParameter("movieId", movieId);
            movieDetails = query.uniqueResult();
        } finally {session.close();}
        return movieDetails;
    }
}
