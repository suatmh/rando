package com.servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.pojo.User;
import com.util.HibernateUtil;
public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            session.save(user);
            transaction.commit();
            response.sendRedirect("login.html");
        } catch (Exception e) {
            if (transaction != null) {transaction.rollback();}
            e.printStackTrace();
            response.getWriter().println("Exception: " + e.getMessage());
        } finally {session.close();}
    }
}

