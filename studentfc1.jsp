<%@ page language="java" contentType="text/html" import="java.sql.*" %>
<%!
		Connection conn;
		Statement stmtRoll,stmtArray;
		ResultSet rs1,rs2;
		String ro,names[],marks[];
		int i;
		public void doConnect(){
			try{
				Class.forName("com.mysql.jdbc.Driver");
			}
			catch(ClassNotFoundException ex){
				System.out.println("Unable to load driver");
			}
			try{
			  conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/studydb","root","root");
		  }
		  catch(SQLException ex2){
			  System.out.println("Unable to connect"+ex2);
		  }
		}
	%>
	<%
	 doConnect();
	 names=new String[20];
	 marks=new String[20];
	 try{
		 stmtArray=conn.createStatement();
		 rs2=stmtArray.executeQuery("select * from tblstudent");
		 i=0;
		 while(rs2.next()){
			 names[i]=rs2.getString("name");
			 marks[i]=rs2.getString("mark");
			 i++;
		 }
	 }
		 catch(SQLException se){
			 out.println("unable to create array");
		 }
	 
		%>
	
<html>
	<head>
		<title>Find page</title>
	<script language="javascript">
	function showstudent(){
		//alert("ok");
		var jsnames=new Array();
		var jsmarks=new Array();
		var j,k;
		j=0;
		<%
		 i=0;
		 while(i<names.length){
		%>
		jsnames[j]="<%=names[i]%>";
		jsmarks[j]="<%=marks[i]%>";
		j=j+1;
		<%
		i=i+1;
		 }
		%>
		k=document.f1.cmbroll.selectedIndex;
		document.f1.txtName.value=jsnames[k-1];
		document.f1.txtMark.value=jsmarks[k-1];
	}
	function goback(){
			window.location="studentmkc.html";
		}

	</script>
	<style>
	td{
	  font-size:20px;
	}
	.btup{
		width:57px;
		height:30px;
		background-color:orange;
	}
	.btdel{
		width:57px;
		height:30px;
		background-color:magenta;
	}
	.btback{
		width:57px;
		height:30px;
		background-color:yellow;
	}
	h2{
		color:blue;
	}
	.tborder{
			    border-style:solid;
				border-width:thick;
				border-color:green;
				}
	</style>
	</head>
	<body bgcolor="pink">
	<center>
	<h2><u>STUDENT MARK ENTRY INTERFACE</u></h2>
			<form name="f1" action="studentfs.jsp" method="post">
			<table class="tborder"><br>
				<tr>
					<td>Roll</td>
					 <td><select name="cmbroll" onchange="showstudent()">
					    <option value=" ">--select--</option>
					<%
					doConnect();
					  try{
						  
						  stmtRoll=conn.createStatement();
						  rs1=stmtRoll.executeQuery("select * from tblstudent");
						  while(rs1.next()){
							  ro=rs1.getString("roll");
					%>
					<option value="<%=ro%>"><%=ro%></option>
					<%
						  }
					  }
					  catch(SQLException ex2){
						  out.println("unable to create combo");
					  }
					%>
					
					 </select>
					</td>
				</tr>
				<tr>
					<td>Name:</td>
					<td><input type="text" name="txtName" autocomplete="on" placeholder="Enter updated name"></td>
				</tr>
				<tr>
					<td>Mark:</td>
					<td><input type="text" name="txtMark" autocomplete="on" placeholder="Enter updated mark"></td>
				</td>
			</table><br>
			<input type="submit" name="btnUpdate" value="Update" class="btup">
			<input type="submit"  name="btnDelete" value="Delete" class="btdel">
			<input type="button" name="btnback" value="back" class="btback" onclick="goback()">
			</center>
		</form>
	</body>
</html>