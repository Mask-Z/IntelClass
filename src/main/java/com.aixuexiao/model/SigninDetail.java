package com.aixuexiao.model;

import java.util.Date;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
public class SigninDetail {
	private int id;
	private int studentid;
	private int classid;
	private int signid;
	private int flag;
	private Date signtime;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getStudentid() {
		return studentid;
	}

	public void setStudentid(int studentid) {
		this.studentid = studentid;
	}

	public int getClassid() {
		return classid;
	}

	public void setClassid(int classid) {
		this.classid = classid;
	}

	public int getSignid() {
		return signid;
	}

	public void setSignid(int signid) {
		this.signid = signid;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public Date getSigntime() {
		return signtime;
	}

	public void setSigntime(Date signtime) {
		this.signtime = signtime;
	}
}
