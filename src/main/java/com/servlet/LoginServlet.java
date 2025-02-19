package com.servlet;
import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import com.dao.UserDAO;
import com.pojo.User;
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        if ("editor".equals(name) && "admin098".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", name);
            session.setAttribute("role", "admin"); 
            response.sendRedirect("adminBoard.jsp");
            return;
        }
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByUsername(name);
        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", user.getUsername());
            session.setAttribute("email", user.getEmail());
            response.sendRedirect("MovieServlet");
        } else {if (user == null) {
                request.setAttribute("message", "User not found. Please sign up.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("index.html");
                dispatcher.include(request, response);
            } else {request.setAttribute("message", "Login failed. Please enter correct details.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.html");
                dispatcher.include(request, response);}}
    }
}
