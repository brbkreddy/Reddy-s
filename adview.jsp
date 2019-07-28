<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html" import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
	 <%  
			
		    String sender=(String)session.getAttribute("b");
		    //out.println(sender);
		    String message=null;
		    String a =null;
		    String ty=request.getParameter("type");
		    //out.println(ty);
		    
            String[] rval = request.getParameterValues("chem_check");
		    long millis=System.currentTimeMillis();
			java.sql.Date date=new java.sql.Date(millis);
			//out.print(date);
			DateFormat dateFormat = new SimpleDateFormat("YY");
            String date_st = dateFormat.format(date);
		    //out.println(date_st);
		    String num=null;
		    
	        
    try {
		
        Class.forName("oracle.jdbc.driver.OracleDriver");  
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","bharath");
		PreparedStatement ps2=con.prepareStatement("select max(message_num) from message");
		ResultSet rs=ps2.executeQuery();
		if(rs.next())
		{
		 num=(String)rs.getString(1);
		 //out.print(num);
		}
		
		message="gvpce(a)/"+date_st+"/"+ty+"/"+num;
		out.println(message);
		
        PreparedStatement ps = con.prepareStatement("Insert into messagereceiver values(?,?)");
        for (String val : rval) 
		{
		 //out.print(val);
         ps.setString(1,message);
		 ps.setString(2, val);
		 ps.execute();
		 //out.print("succesfully send");
        }
		
		 PreparedStatement ps1 = con.prepareStatement("Insert into messagesender values(?,?)");
 
		 
         ps1.setString(1,message);
		 ps1.setString(2,sender);
		 ps1.execute();
		 out.print("successfully send by"+sender );
		 
        
  con.close();
	   }
	   catch(Exception e)
			  {
				  e.printStackTrace();
	            }
		%>  
