package com.aixuexiao.dao;

import com.aixuexiao.model.SigninDetail;
import com.aixuexiao.model.Student;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
@Component("signinDetailDao")
public class SigninDetailDao extends BaseDao{

	public int saveSigninDetail(SigninDetail signinDetail) {
		return this.writerSqlSession.insert("com.aixuexiao.dao.SigninDetailDao.saveSigninDetail", signinDetail);
	}

	public List<SigninDetail> findSigninDetail(int start, int size, String key,String classid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("size", size);
		map.put("key", key);
		map.put("classid", classid);
		return this.readSqlSession.selectList("com.aixuexiao.dao.SigninDetailDao.selectSigninDetail",map);
	}
	public int getItemsByStudentId(int studentid){
		return this.readSqlSession.selectOne("com.aixuexiao.dao.SigninDetailDao.getItemsByStudentId",studentid);
	}
}
