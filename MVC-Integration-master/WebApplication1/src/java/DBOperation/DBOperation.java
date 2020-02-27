/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DBOperation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author GoldOne
 */
public class DBOperation {
    Connection con =null;
    
    public Connection getCon() throws ClassNotFoundException, SQLException{
        
        if(con==null){
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kit","root","");
        }
        return con;
    }
    
    public boolean checkUser(String user, String pass) {
        try{
            getCon();
            Statement st = con.createStatement();
            Boolean res = false;
            ResultSet rs = st.executeQuery("select * from users");
            while(rs.next()){
                if (rs.getString("name").equals(user) && rs.getString("pass").equals(pass)) {
                    res = true;
                }
            }
            return res;
        }
        catch(SQLException | ClassNotFoundException e){
            return false;
        }
    }
    public boolean register(String username, String pw) {
        try{
            getCon();
            PreparedStatement ps = con.prepareStatement("insert into users values(?,?)");
            ps.setString(1, username);
            ps.setString(2, pw); 
            ps.execute();
            return true;
        }
        catch(SQLException | ClassNotFoundException e){
          return false;
        }
    }
     public boolean insertRecord(Students student){        
        try{
            getCon();
            PreparedStatement ps = con.prepareStatement("insert into students values(?,?)");
            
            ps.setInt(1, student.getId());
            ps.setString(2, student.getName()); 
            ps.execute();
            
            return true;
        }
        catch(SQLException | ClassNotFoundException e){
            System.out.println("Insert record error");
        }
        return false;
    }
     
       public boolean DeleteRecord (Students s){
        int id = s.getId();
       
        try{
            getCon();
            Statement st = con.createStatement();
            
            st.executeUpdate("delete from students where id ='"+id+"'");
           
        
        return true;
        }
        catch(SQLException | ClassNotFoundException e){
            System.out.println("Insert record error");
        }
        return false;
    }
    
        public boolean UpdateRecord (Students s){
        int id = s.getId();
        String name = s.getName();
       
        try{
            getCon();
            Statement st = con.createStatement();
            
            st.execute(" update students set name='"+name+"' where id ='"+id+"' ");
           
        
        return true;
        }
        catch(SQLException | ClassNotFoundException e){
            System.out.println("Insert record error");
        }
        return false;
    }
        
        
         public ResultSet ViewAll (){
   
            try{
                getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from students");
                return rs;
            }
            catch(SQLException | ClassNotFoundException e){
                return null;
            }
         }
        public ResultSet viewRecord(int id){
            try{
                getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from students where id =" + id);
                return rs;
            }
            catch(SQLException | ClassNotFoundException e){
                return null;
            }
    }
    
}
