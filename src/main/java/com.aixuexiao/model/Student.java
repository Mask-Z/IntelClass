package com.aixuexiao.model;

import java.io.Serializable;

/**
 * 学生实体
 */
public class Student implements Serializable {
	
	/**
	 * 学生编号
	 */
	private int id;
	
	/**
	 * 班级编号
	 */
	private int classid;
	
	/**
	 * 学生姓名
	 */
	private String name;
	
	/**
	 * 备注
	 */
	private String remark;

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

	public int getClassid() {
		return classid;
	}

	public void setClassid(int classid) {
		this.classid = classid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	
}
