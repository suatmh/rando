package com.servlet;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import com.dao.MovieDAO;
import com.pojo.Movie;
public class MovieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MovieDAO movieDAO = new MovieDAO();
        List<Movie> movies = movieDAO.getAllMovies();
        if (movies != null) {System.out.println("Movies retrieved: " + movies.size());
            request.setAttribute("movies", movies);
            RequestDispatcher dispatcher = request.getRequestDispatcher("movies.jsp");
            dispatcher.forward(request, response);
        } else {System.out.println("No movies found.");}  
    }
}

