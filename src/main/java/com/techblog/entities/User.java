package com.techblog.entities;

import java.sql.Timestamp;

public class User {
	private int id;
	private String username;
	private String email;
	private String userpassword;
	private String gender;
	private String about;
	private Timestamp rdate;
	private String profile;

	public User() {
	}

	public User(int id, String username, String email, String userpassword, String gender, String about,
			Timestamp rdate) {
		this.id = id;
		this.username = username;
		this.email = email;
		this.userpassword = userpassword;
		this.gender = gender;
		this.about = about;
		this.rdate = rdate;
	}

	public User(String username, String email, String userpassword, String gender, String about) {
		this.username = username;
		this.email = email;
		this.userpassword = userpassword;
		this.gender = gender;
		this.about = about;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserpassword() {
		return userpassword;
	}

	public void setUserpassword(String userpassword) {
		this.userpassword = userpassword;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}

	public Timestamp getRdate() {
		return rdate;
	}

	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}
	
	
}
