
import DBOperation.DBOperation;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class auth implements Filter{

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;

        String user = (String) request.getParameter("user");
        String pw = (String) request.getParameter("pw");
        DBOperation dop = new DBOperation();
        HttpSession session = req.getSession();
        String login = (String) session.getAttribute("log");
        if ( login!=null || dop.checkUser(user, pw)) {
            chain.doFilter(request, response);
        } else {
             java.io.PrintWriter out = response.getWriter();
             out.print("invalid account");
        }
    }

    @Override
    public void destroy() {
        
    }
    
}
