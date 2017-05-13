package com.aixuexiao.service;

import com.aixuexiao.dao.SigninNumDao;
import com.aixuexiao.model.SigninNum;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
@Service
public class SigninNumService {
	@Resource(name = "signinNumDao")
	private SigninNumDao signinNumDao;

	/**
	 * 保存签到信息
	 * @param signinNum
	 */
	public void saveSigninNum(SigninNum signinNum){
		signinNumDao.saveSigninNum(signinNum);
	}

	public SigninNum getLatestSigninNum(){
		return  signinNumDao.findLatestSigninNum();
	}

}
