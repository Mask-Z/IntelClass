package com.aixuexiao.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.aixuexiao.model.Student;

@Component("studentDao")
public class StudentDao extends BaseDao {


	/**
	 * 根据微信标识查出学生
	 */
	public Student findStudentByFromUserName(String  fromusername) {
		return this.readSqlSession.selectOne("com.aixuexiao.dao.StudentDao.selectStudentByFromUserName",fromusername);
	}

	/**
	 * 查出所有学生信息
	 * @return
	 */
	public List<Student> findAllStudent() {
		return this.readSqlSession.selectList("com.aixuexiao.dao.StudentDao.selectAllStudent");
	}

	public Student findStudentById(int id) {
		return this.readSqlSession.selectOne("com.aixuexiao.dao.StudentDao.selectStudentById",id);
	}
	
	public List<Student> findStudent(int start,int size,Student student) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("size", size);
		map.put("student", student);
		return this.readSqlSession.selectList("com.aixuexiao.dao.StudentDao.selectStudent",map);
	}
	
	public List<Student> findStudentByClassesId(int classesid) {
		return this.readSqlSession.selectList("com.aixuexiao.dao.StudentDao.selectStudentByClassesId",classesid);
	}
	
	public int addStudent(Student student) {
		return this.writerSqlSession.insert("com.aixuexiao.dao.StudentDao.addStudent", student);
	}
	
	public int deleteStudentById(int studentid) {
		return this.writerSqlSession.delete("com.aixuexiao.dao.StudentDao.deleteStudentById", studentid);
	}
	
	public int updateStudent(Student student) {
		return this.writerSqlSession.update("com.aixuexiao.dao.StudentDao.updateStudent", student);
	}
}
