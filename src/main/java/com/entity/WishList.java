package com.entity;

import java.sql.Timestamp;

public class WishList {
	private int wid;
	private int bid;
	private int userId;
	private String bookName;
	private String author;
	private double price;
	private Timestamp date;
	private String photoName;
	private int quantity;



	public WishList() {
		super();

	}

	public WishList(int bid, int userId, String bookName, String author, double price, String photoName) {
		super();
		this.bid = bid;
		this.userId = userId;
		this.bookName = bookName;
		this.author = author;
		this.price = price;
		this.photoName = photoName;
	}

	public WishList(int wid, int bid, int userId, String bookName, String author, double price, Timestamp date,
			String photoName) {
		super();
		this.wid = wid;
		this.bid = bid;
		this.userId = userId;
		this.bookName = bookName;
		this.author = author;
		this.price = price;
		this.date = date;
		this.photoName = photoName;
	}

	public int getWid() {
		return wid;
	}

	public void setWid(int wid) {
		this.wid = wid;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getPhotoName() {
		return photoName;
	}

	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	
	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

}
