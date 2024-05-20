package com.DAO;

import java.util.List;

import com.entity.User;

public interface UserDAO {

	public boolean userRegister(User us);

	public User login(String email, String password);

	public boolean checkPassword(int id, String password);

	public boolean upadteProfile(User us);

	public boolean checkUser(String email);

	public boolean changePassword(String email, String password);

	public User userProfile(String email);

	public List<User> findUserlist();
	
	public boolean upadteUserStatus(String email,String status);
	
	public boolean addAddress(User us);

}
