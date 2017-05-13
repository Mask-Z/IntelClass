package com.aixuexiao.model;

import java.util.Date;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
public class SigninNum {
	private int id;
	private String signnum;
	private Date signtime;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSignnum() {
		return signnum;
	}

	public void setSignnum(String signnum) {
		this.signnum = signnum;
	}

	public Date getSigntime() {
		return signtime;
	}

	public void setSigntime(Date signtime) {
		this.signtime = signtime;
	}
}
