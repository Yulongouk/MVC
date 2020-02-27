
import DBOperation.DBOperation;
import DBOperation.Users;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class auth implements Filter{

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;

        String name = (String) req.getParameter("user");
        String pw = (String) req.getParameter("pw");
//        Users user = new Users();
//        user.setPassword(pw);
//        user.setUsername(name);
        DBOperation dop = new DBOperation();
        HttpSession session= req.getSession();
        String login = (String) session.getAttribute("user");
        if ( login!=null || dop.checkUser(name, pw)) {
            chain.doFilter(request, response);
        } else {
            PrintWriter out = response.getWriter();
            out.println("Invalid User Account");
            
        }
    }

    @Override
    public void destroy() {
        
    }
    
}
