<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="com.util.HibernateUtil" %>
<%@ page import="com.pojo.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Users Management</title>
    <link rel="stylesheet" type="text/css" href="adminstyle.css">
</head>
<body>
    <div class="container">
        <h1>Users List</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Password</th>
            </tr>
            <%
                SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
                Session s = sessionFactory.openSession();
                List<User> users = s.createQuery("FROM User", User.class).list();
                for (User user : users) {
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getUsername() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getPassword() %></td>
            </tr>
            <%
                }
                s.close();
            %>
        </table>
    </div>
</body>
</html>
