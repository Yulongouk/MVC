/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import DBOperation.DBOperation;
import DBOperation.Users;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author meass
 */
public class dashboard extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        RequestDispatcher d = request.getRequestDispatcher("dashboard.jsp");
        String user = request.getParameter("user");
//        String pass = request.getParameter("pw");
        HttpSession hs = request.getSession();
        hs.setAttribute("user", user);
//        hs.setAttribute("pass",pass);
        d.forward(request, response);
    }
}
