package com.aixuexiao.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 给学生的留言
 */
public class StudentMessage implements Serializable {
	
	/**
	 * 留言编号
	 */
	private int id;
	
	/**
	 * 学生编号
	 */
	private int studentid;
	
	/**
	 * 公告内容
	 */
	private String content;
	
	/**
	 * 发布时间
	 */
	private Date inserttime;

	//添加以下2个属性
	/**
	 *唯一微信号
	 */
	private String fromusername;

	/**
	 * 微信号与学好关联标志
	 */
	private int flag;

	public String getFromusername() {
		return fromusername;
	}

	public void setFromusername(String fromusername) {
		this.fromusername = fromusername;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

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
 
	

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getInserttime() {
		return inserttime;
	}

	public void setInserttime(Date inserttime) {
		this.inserttime = inserttime;
	}
	
	
}
