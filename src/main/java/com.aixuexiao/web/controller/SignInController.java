package com.aixuexiao.web.controller;

import com.aixuexiao.model.*;
import com.aixuexiao.service.*;
import com.aixuexiao.util.GetChars;
import com.aixuexiao.util.MyLogger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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

	@Resource(name = "examService")
	private ExamService examService;

	@RequestMapping(value = "/manager/signInStudents", method = RequestMethod.GET)
	public ModelAndView getsignInStudents(String pagenum, String signnumkey, String classid) {

		MyLogger.info("classid: " + classid);
		if (null == classid)
			classid = "0";
		ModelAndView mv = new ModelAndView();
		mv.setViewName("signInStudents");
		mv.addObject("sidebar", "signInStudents");
		mv.addObject("classid", classid);
		int num = 1;
		if (null != pagenum) {
			num = Integer.parseInt(pagenum);
		}
		//搜索的签到码
		String key;
		if (null != signnumkey && !Objects.equals("", signnumkey)) {
			key = signnumkey;
		} else if ("0".equals(classid)) {
			key = signinNumService.getLatestSigninNum().getSignnum();
		} else {
			key = "";
		}
		int newsSignNum=0;
		if (!classid.equals("0")){
			newsSignNum=signinNumService.getLatestSigninNumByClassId(classid);
		}


//		List<SigninDetail> list = studentService.listStudent((num-1)*pagesize, pagesize,student);
		List<SigninDetail> signinDetailList = signinDetailService.listSigninDetail((num - 1) * pagesize, pagesize, key, String.valueOf(newsSignNum));
		//根据签到信息获取学生姓名,班级,签到码

		List<Map<String, Object>> list = new ArrayList<>();
		if (null != signinDetailList && signinDetailList.size() > 0) {
			for (SigninDetail signinDetail : signinDetailList) {
				Map<String, Object> map = new HashMap<>();
//				MyLogger.info("标记: "+signinDetail.getStudentid());
				Student student = studentService.findStudentById(signinDetail.getStudentid());
				String studentname = student.getName();
				int studentid = student.getId();
				String classname = classesService.findClassesById(signinDetail.getClassid()).getName();
				String signnum = signinNumService.findSigninNumById(signinDetail.getSignid()).getSignnum();
				map.put("signindetail", signinDetail);
				map.put("studentid", studentid);
				map.put("studentname", studentname);
				map.put("classname", classname);
				map.put("signnum", signnum);
				list.add(map);
			}
		}
		//查出所有班级列表
		List<Classes> clslist = examService.findAllClasses();
		mv.addObject("clsList", clslist);
//		MyLogger.info("infoList大小: " + list.size());
//		List<Classes> clslist = studentService.findAllClasses();
		mv.addObject("infoList", list);
//		mv.addObject("clsList", clslist);
		mv.addObject("length", list.size());
		mv.addObject("pagenum", num);
		mv.addObject("signnumkey", signnumkey);
		mv.addObject("classid", classid);
		return mv;


	}

	@RequestMapping(value = "/manager/signIn", method = RequestMethod.GET)
	public ModelAndView listStudent(@ModelAttribute("signnum") String signnum, String pagenum, Student student) {
		ModelAndView mv = new ModelAndView();

		if (null != signnum && !Objects.equals("", signnum)) {
			MyLogger.info(signnum);
			mv.addObject("signnum", signnum);
		}

		mv.setViewName("signIn");
		mv.addObject("sidebar", "signIn");
		//查出所有班级列表
		List<Classes> clslist = examService.findAllClasses();
		mv.addObject("clsList", clslist);
		return mv;

//		ModelAndView mv=new ModelAndView();
//		mv.setViewName("exams");
//		mv.addObject("sidebar","exams");
//		int num = 1;
//		if(null!=pagenum){
//			num = Integer.parseInt(pagenum);
//		}
//		List<Exam> list = examService.listExam((num-1)*pagesize, pagesize,exam);
//		List<Classes> clslist = examService.findAllClasses();
//		mv.addObject("examList", list);
//		mv.addObject("clsList", clslist);
//		mv.addObject("length", list.size());
//		mv.addObject("pagenum", num);
//		mv.addObject("exam", exam);
//		return mv;
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

	@ResponseBody
	@RequestMapping(value = "/manager/getOnlySignInNum", method = RequestMethod.GET)
	public String getSignInNum2(HttpServletRequest request) {
		String classid = request.getParameter("classid");

		String result = GetChars.getRandomString(6);
		SigninNum signinNum = new SigninNum();
		signinNum.setClassid(Integer.valueOf(classid));
		signinNum.setSignnum(result);
//		MyLogger.info("classid: "+classid);
//		MyLogger.info("signinNum.classid: "+signinNum.getClassid());
		signinNum.setSigntime(new Date(new Date().getTime() + 60000));
//		MyLogger.info("存放后: "+signinNum.getSigntime().getTime());
		signinNumService.saveSigninNum(signinNum);
		return result;
	}

}
