package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.techblog.entities.Category;
import com.techblog.entities.Post;

public class PostDao {
	private Connection con;

	public PostDao(Connection con) {
		super();
		this.con = con;
	}
	
	public ArrayList<Category> getAllCategories(){
		ArrayList<Category> list=new ArrayList<>();
		
		try {
			String query="select * from categories";
			PreparedStatement pstmt=con.prepareStatement(query);
			ResultSet result=pstmt.executeQuery();
			
			while(result.next()) {
				int cid=result.getInt("cid");
				String cname=result.getString("cname");
				String cdescription=result.getString("cdescription");
				Category c=new Category(cid,cname,cdescription);
				list.add(c);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean savePost(Post post) {
		boolean check=false;
		try {
			String query="insert into posts(ptitle, pcontent, pcode, pimage, catid, uid) value (?,?,?,?,?,?)";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setString(1, post.getPtitle());
			pstmt.setString(2, post.getPcontent());
			pstmt.setString(3, post.getPcode());
			pstmt.setString(4, post.getPimage());
			pstmt.setInt(5, post.getCatid());
			pstmt.setInt(6, post.getUid());
			pstmt.executeUpdate();
			check=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return check;
	}
	
	public ArrayList<Post> getAllPost(){
		ArrayList<Post> list=new ArrayList<Post>();
		try {
			String query="select * from posts order by pid";
			PreparedStatement pstmt=con.prepareStatement(query);
			ResultSet result=pstmt.executeQuery();
			while(result.next()) {
				int pid=result.getInt("pid");
				String ptitle=result.getString("ptitle");
				String pcontent=result.getString("pcontent");
				String pcode=result.getString("pcode");
				String pimage=result.getString("pimage");
				Timestamp pdate=result.getTimestamp("pdate");
				int catid=result.getInt("catid");
				int uid=result.getInt("uid");
				Post post=new Post(pid, ptitle, pcontent, pcode, pimage, pdate, catid, uid);
				list.add(post);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<Post> getAllPostbycatid(int catid){
		ArrayList<Post> list=new ArrayList<Post>();
		try {
			String query="select * from posts where catid=? order by pid";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setInt(1, catid);
			ResultSet result=pstmt.executeQuery();
			
			while(result.next()) {
				int pid=result.getInt("pid");
				String ptitle=result.getString("ptitle");
				String pcontent=result.getString("pcontent");
				String pcode=result.getString("pcode");
				String pimage=result.getString("pimage");
				Timestamp pdate=result.getTimestamp("pdate");
				int uid=result.getInt("uid");
				Post post=new Post(pid, ptitle, pcontent, pcode, pimage, pdate, catid, uid);
				list.add(post);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Post getPostbyPid(int Pid) {
		Post post=null;
		try {
			String query="select * from posts where pid=?";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setInt(1, Pid);
			ResultSet result = pstmt.executeQuery();
			if(result.next()) {
				int pid=result.getInt("pid");
				String ptitle=result.getString("ptitle");
				String pcontent=result.getString("pcontent");
				String pcode=result.getString("pcode");
				String pimage=result.getString("pimage");
				Timestamp pdate=result.getTimestamp("pdate");
				int catid=result.getInt("catid");
				int uid=result.getInt("uid");
				post=new Post(pid, ptitle, pcontent, pcode, pimage, pdate, catid, uid);
			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return post;
	}
	public ArrayList<Post> getAllPostbyuid(int uid){
		ArrayList<Post> list=new ArrayList<Post>();
		try {
			String query="select * from posts where uid=? order by pid";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setInt(1, uid);
			ResultSet result=pstmt.executeQuery();
			
			while(result.next()) {
				int pid=result.getInt("pid");
				String ptitle=result.getString("ptitle");
				String pcontent=result.getString("pcontent");
				String pcode=result.getString("pcode");
				String pimage=result.getString("pimage");
				Timestamp pdate=result.getTimestamp("pdate");
				int catid=result.getInt("catid");
				Post post=new Post(pid, ptitle, pcontent, pcode, pimage, pdate, catid, uid);
				list.add(post);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
