package com.entity;

import java.sql.Timestamp;

public class Book_Order {

	private int id;

	private String orderId;
	private int bid;

	private String userName;
	private String email;
	private String phno;
	private String fulladd;
	private String bookName;
	private String author;
	private String price;
	private String totalPrice;
	private String paymentType;
	private String address;
	private String Landmark;
	private String city;
	private String state;
	private String pincode;
	private Timestamp date;
	private Timestamp cancleDate;
	private Timestamp dispatcheDate;
	private Timestamp shipDate;

	public boolean dispatched;
	public boolean shipped;
	public boolean cancel;
	private int quantity;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhno() {
		return phno;
	}

	public void setPhno(String phno) {
		this.phno = phno;
	}

	public String getFulladd() {
		return fulladd;
	}

	public void setFulladd(String fulladd) {
		this.fulladd = fulladd;
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

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLandmark() {
		return Landmark;
	}

	public void setLandmark(String landmark) {
		Landmark = landmark;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public boolean isDispatched() {
		return dispatched;
	}

	public void setDispatched(boolean dispatched) {
		this.dispatched = dispatched;
	}

	public boolean isShipped() {
		return shipped;
	}

	public void setShipped(boolean shipped) {
		this.shipped = shipped;
	}

	public boolean isCancel() {
		return cancel;
	}

	public void setCancle(boolean cancle) {
		this.cancel = cancle;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Timestamp getCancleDate() {
		return cancleDate;
	}

	public void setCancleDate(Timestamp cancleDate) {
		this.cancleDate = cancleDate;
	}

	public Timestamp getDispatcheDate() {
		return dispatcheDate;
	}

	public void setDispatcheDate(Timestamp dispatcheDate) {
		this.dispatcheDate = dispatcheDate;
	}

	public Timestamp getShipDate() {
		return shipDate;
	}

	public void setShipDate(Timestamp shipDate) {
		this.shipDate = shipDate;
	}

	public void setCancel(boolean cancel) {
		this.cancel = cancel;
	}

	@Override
	public String toString() {
		return "Book_Order [id=" + id + ", userName=" + userName + ", email=" + email + ", phno=" + phno + ", fulladd="
				+ fulladd + ", paymentType=" + paymentType + "]";
	}

}
