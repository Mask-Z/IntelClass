package com.aixuexiao.service;

import com.aixuexiao.dao.SigninDetailDao;
import com.aixuexiao.model.SigninDetail;
import com.aixuexiao.model.Student;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
@Service
public class SigninDetailService {

	@Resource(name = "signinDetailDao")
	private SigninDetailDao signinDetailDao;

	public void saveSigninDetail(SigninDetail signinDetail){
		signinDetailDao.saveSigninDetail(signinDetail);
	}

	public List<SigninDetail> listSigninDetail(int start, int size, String key,String classid){
		return signinDetailDao.findSigninDetail(start,size,key,classid);
	}
	public int getItemsByStudentId(int studentid){
		return signinDetailDao.getItemsByStudentId(studentid);
	}
}
