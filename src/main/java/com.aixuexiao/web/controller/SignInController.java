package com.aixuexiao.web.controller;

import com.aixuexiao.model.Classes;
import com.aixuexiao.model.SigninDetail;
import com.aixuexiao.model.SigninNum;
import com.aixuexiao.model.Student;
import com.aixuexiao.service.ClassesService;
import com.aixuexiao.service.SigninDetailService;
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
import java.util.*;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
@Controller
public class SignInController {
	public static final int pagesize = 8;

	@Resource(name = "studentService")
	private StudentService studentService;

	@Resource(name = "signinNumService")
	private SigninNumService signinNumService;

	@Resource(name = "signinDetailService")
	private SigninDetailService signinDetailService;

	@Resource(name = "classesService")
	private ClassesService classesService;


	@RequestMapping(value = "/manager/signInStudents", method = RequestMethod.GET)
	public ModelAndView getsignInStudents(String pagenum, String  signnumkey) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("signInStudents");
		mv.addObject("sidebar", "signInStudents");
		int num = 1;
		if (null != pagenum) {
			num = Integer.parseInt(pagenum);
		}
//		int signid = 0;
//		if (null != signinNum&&0!=signinNum.getId()) {
//			signid = signinNum.getId();
//		} else {
//			signid = signinNumService.getLatestSigninNum().getId();
//		}

		String key;
		if (null != signnumkey&& !Objects.equals("", signnumkey)) {
			key=signnumkey;
		} else {
			key=signinNumService.getLatestSigninNum().getSignnum();
		}



//		List<SigninDetail> list = studentService.listStudent((num-1)*pagesize, pagesize,student);
		List<SigninDetail> signinDetailList = signinDetailService.listSigninDetail((num - 1) * pagesize, pagesize, key);
		//根据签到信息获取学生姓名,班级,签到码
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> list = new ArrayList<>();
		if (null != signinDetailList && signinDetailList.size() > 0) {
			for (SigninDetail signinDetail : signinDetailList) {
//				MyLogger.info("标记: "+signinDetail.getFlag());
				String studentname = studentService.findStudentById(signinDetail.getStudentid()).getName();
				String classname = classesService.findClassesById(signinDetail.getClassid()).getName();
				String signnum = signinNumService.findSigninNumById(signinDetail.getSignid()).getSignnum();
				map.put("signindetail", signinDetail);
				map.put("studentname", studentname);
				map.put("classname", classname);
				map.put("signnum", signnum);
				list.add(map);
			}
		}
//		MyLogger.info("infoList大小: " + list.size());
//		List<Classes> clslist = studentService.findAllClasses();
		mv.addObject("infoList", list);
//		mv.addObject("clsList", clslist);
		mv.addObject("length", list.size());
		mv.addObject("pagenum", num);
		mv.addObject("signnumkey", signnumkey);
		return mv;


	}

	@RequestMapping(value = "/manager/signIn", method = RequestMethod.GET)
	public ModelAndView listStudent(@ModelAttribute("signnum") String signnum, String pagenum, Student student) {
		ModelAndView mv = new ModelAndView();
		if (null != signnum && !Objects.equals("", signnum))
			mv.addObject("signnum", signnum);
		mv.setViewName("signIn");
		mv.addObject("sidebar", "signIn");
		int num = 1;
		if (null != pagenum) {
			num = Integer.parseInt(pagenum);
		}
		List<Student> list = studentService.listStudent((num - 1) * pagesize, pagesize, student);
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
	 *
	 * @return
	 */
	@RequestMapping(value = "/manager/getSignInNum", method = RequestMethod.GET)
	public ModelAndView getSignInNum(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		String result = GetChars.getRandomString(6);
		SigninNum signinNum = new SigninNum();
		signinNum.setSignnum(result);
//		MyLogger.info("存放前: "+new Date().getTime());
		signinNum.setSigntime(new Date(new Date().getTime() + 60000));
//		MyLogger.info("存放后: "+signinNum.getSigntime().getTime());
		signinNumService.saveSigninNum(signinNum);
		mv.addObject("signnum", result);
		mv.setViewName("redirect:/manager/signIn");
		return mv;
	}

//	public static void main(String[] args) {
//		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		System.out.println(simpleDateFormat.format(new Date(1494614222373l)));
//		System.out.println(simpleDateFormat.format(new Date(1494614282434l)));
//	}

}
