package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.techblog.entities.User;

public class UserDao {
	private Connection con;

	public UserDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean saveUser(User user) {
		boolean check=false;
		try {
			String query ="insert into user(username,email,userpassword,gender,about) values(?,?,?,?,?)";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getUserpassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());

			pstmt.executeUpdate();
			check=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return check;
	}
	
	public User getUserByEmailAndPassword(String email,String password) {
		User user=null;
		
		try {
			String query="select * from user where email=? and userpassword=?";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			ResultSet rset=pstmt.executeQuery();
			if(rset.next()) {
				user=new User();
				String name=rset.getString("username");
				
				user.setUsername(name);
				user.setId(rset.getInt("id"));
				user.setEmail(rset.getString("email"));
				user.setUserpassword(rset.getString("userpassword"));;
				user.setGender(rset.getString("gender"));
				user.setAbout(rset.getString("about"));
				user.setRdate(rset.getTimestamp("rdate"));
				user.setProfile(rset.getString("profile"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	public boolean updateUser(User user) {
		boolean check=false;
		try {
			
			String query="update user set username=?, email=?, userpassword=?, about=?, profile=? where id=?";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getUserpassword());
			pstmt.setString(4, user.getAbout());
			pstmt.setString(5, user.getProfile());
			pstmt.setInt(6, user.getId());
			
			pstmt.executeUpdate();
			check=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return check;
	}
	public User getUserByid(int id) {
		User user=null;
		
		try {
			String query="select * from user where id=?";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setInt(1, id);
			ResultSet rset=pstmt.executeQuery();
			if(rset.next()) {
				user=new User();
				String name=rset.getString("username");
				
				user.setUsername(name);
				user.setId(rset.getInt("id"));
				user.setEmail(rset.getString("email"));
				user.setUserpassword(rset.getString("userpassword"));;
				user.setGender(rset.getString("gender"));
				user.setAbout(rset.getString("about"));
				user.setRdate(rset.getTimestamp("rdate"));
				user.setProfile(rset.getString("profile"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
}
