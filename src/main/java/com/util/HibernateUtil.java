package com.util;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import java.util.Properties;
public class HibernateUtil {
    private static final SessionFactory sessionFactory;
    static {try {Configuration configuration = new Configuration();
            Properties settings = new Properties();
            settings.put(Environment.DRIVER, "com.mysql.jdbc.Driver");
            settings.put(Environment.URL, "jdbc:mysql://@localhost:3306/cacopy");
            settings.put(Environment.USER, "root");
            settings.put(Environment.PASS, "root");
            settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQL5Dialect");
            settings.put(Environment.SHOW_SQL, "true");
            settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, "thread");
            settings.put(Environment.HBM2DDL_AUTO, "update");           
            configuration.setProperties(settings);
            configuration.addAnnotatedClass(com.pojo.User.class); 
            configuration.addAnnotatedClass(com.pojo.Movie.class);
            configuration.addAnnotatedClass(com.pojo.MovieDetails.class);
            configuration.addAnnotatedClass(com.pojo.Places.class);
            configuration.addAnnotatedClass(com.pojo.Booking.class);
            configuration.addAnnotatedClass(com.pojo.Payment.class);
            sessionFactory = configuration.buildSessionFactory();
        } catch (Throwable ex) { System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);}
    }
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}

