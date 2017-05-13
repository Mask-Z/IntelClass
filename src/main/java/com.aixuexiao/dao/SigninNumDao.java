package com.aixuexiao.dao;

import com.aixuexiao.model.SigninNum;
import com.aixuexiao.model.Student;
import org.springframework.stereotype.Component;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
@Component("signinNumDao")
public class SigninNumDao extends BaseDao {
	public int saveSigninNum(SigninNum signinNum) {
		return this.writerSqlSession.insert("com.aixuexiao.dao.SigninNumDao.saveSigninNum", signinNum);
	}

	public SigninNum findLatestSigninNum(){
		return this.writerSqlSession.selectOne("com.aixuexiao.dao.SigninNumDao.findLatestSigninNum");
	}

}
