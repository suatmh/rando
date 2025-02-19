package com.dao;
import org.hibernate.Session;
import org.hibernate.query.Query;
import com.pojo.User;
import com.util.HibernateUtil;
public class UserDAO {
    public User getUserByUsername(String username) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        User user = null;
        try {
            String hql = "FROM User WHERE username = :username";
            Query<User> query = session.createQuery(hql, User.class);
            query.setParameter("username", username);
            user = query.uniqueResult();
        } finally {session.close();}
        return user;
    }
    public int getUserIdByUsername(String username) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        int userId = -1; // Default to -1 if no user is found
        try {
            String hql = "SELECT u.id FROM User u WHERE u.username = :username";
            Query<Integer> query = session.createQuery(hql, Integer.class);
            query.setParameter("username", username);
            userId = query.uniqueResult(); // Retrieve the user ID
        } finally {
            session.close();
        }
        return userId;
    }
}
