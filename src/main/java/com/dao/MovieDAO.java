package com.dao;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.query.Query;
import com.pojo.Movie;
import com.util.HibernateUtil;
public class MovieDAO {
    public List<Movie> getAllMovies() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<Movie> movies = null;
        try {
            String hql = "FROM Movie";
            Query<Movie> query = session.createQuery(hql, Movie.class);
            movies = query.list();
            if (movies != null) {
                System.out.println("Movies fetched from database: " + movies.size());
            } else {System.out.println("No movies found in database.");}
        } finally { session.close();}
        return movies;
    }
}
