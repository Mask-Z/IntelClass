package com.aixuexiao.web.controller;

import com.aixuexiao.model.Classes;
import com.aixuexiao.model.SigninNum;
import com.aixuexiao.model.Student;
import com.aixuexiao.service.SigninNumService;
import com.aixuexiao.service.StudentService;
import com.aixuexiao.util.GetChars;
import com.aixuexiao.util.MyLogger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
@Controller
public class SignInController {
	public static final int pagesize = 8;

	@Resource(name="studentService")
	private StudentService studentService;

	@Resource(name="signinNumService")
	private SigninNumService signinNumService;

	@RequestMapping(value="/manager/signIn",method= RequestMethod.GET)
	public ModelAndView listStudent(@ModelAttribute("signnum") String signnum, String pagenum, Student student){
		ModelAndView mv=new ModelAndView();
		if (null!=signnum&&""!=signnum)
			mv.addObject("signnum",signnum);
		mv.setViewName("signIn");
		mv.addObject("sidebar","signIn");
		int num = 1;
		if(null!=pagenum){
			num = Integer.parseInt(pagenum);
		}
		List<Student> list = studentService.listStudent((num-1)*pagesize, pagesize,student);
		List<Classes> clslist = studentService.findAllClasses();
		mv.addObject("studentList", list);
		mv.addObject("clsList", clslist);
		mv.addObject("length", list.size());
		mv.addObject("pagenum", num);
		mv.addObject("student", student);
		return mv;
	}

	/**
	 * 获取随机字符串
	 * @return
	 */
	@RequestMapping(value="/manager/getSignInNum",method= RequestMethod.GET)
	public ModelAndView getSignInNum(HttpServletRequest request){
		ModelAndView mv=new ModelAndView();
		String result=GetChars.getRandomString(6);
		SigninNum signinNum=new SigninNum();
		signinNum.setSignnum(result);
//		MyLogger.info("存放前: "+new Date().getTime());
		signinNum.setSigntime(new Date(new Date().getTime()+60000));
//		MyLogger.info("存放后: "+signinNum.getSigntime().getTime());
		signinNumService.saveSigninNum(signinNum);
		mv.addObject("signnum",result);
		mv.setViewName("redirect:/manager/signIn");
		return mv;
	}

//	public static void main(String[] args) {
//		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		System.out.println(simpleDateFormat.format(new Date(1494614222373l)));
//		System.out.println(simpleDateFormat.format(new Date(1494614282434l)));
//	}

}
