package com.aixuexiao.dao;

import com.aixuexiao.model.SigninDetail;
import org.springframework.stereotype.Component;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
@Component("signinDetailDao")
public class SigninDetailDao extends BaseDao{

	public int saveSigninDetail(SigninDetail signinDetail) {
		return this.writerSqlSession.insert("com.aixuexiao.dao.SigninDetailDao.saveSigninDetail", signinDetail);
	}
}
