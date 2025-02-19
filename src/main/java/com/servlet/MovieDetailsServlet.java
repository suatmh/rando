package com.servlet;
import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import com.dao.MovieDetailsDAO;
import com.pojo.MovieDetails;
public class MovieDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        MovieDetailsDAO movieDetailsDAO = new MovieDetailsDAO();
        MovieDetails movieDetails = movieDetailsDAO.getMovieDetailsByMovieId(movieId);
        request.setAttribute("movieDetails", movieDetails);
        RequestDispatcher dispatcher = request.getRequestDispatcher("movie_summary.jsp");
        dispatcher.forward(request, response);
    }
}


