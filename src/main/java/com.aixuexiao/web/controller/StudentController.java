package com.aixuexiao.web.controller;


import java.math.BigDecimal;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.aixuexiao.model.*;
import com.aixuexiao.service.SigninDetailService;
import com.aixuexiao.service.SigninNumService;
import com.aixuexiao.service.WeixinService;
import com.aixuexiao.util.MyLogger;
import com.aixuexiao.util.WeixinUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.aixuexiao.service.StudentService;

/**
 * 包含学生列表菜单内的所有操作
 */
@Controller
public class StudentController {
	
	public static final int pagesize = 8;
	
	@Resource(name="studentService")
	private StudentService studentService;

	@Resource(name="weixinService")
	private WeixinService weixinService;

	@Resource(name="signinDetailService")
	private SigninDetailService signinDetailService;

	@Resource(name="signinNumService")
	private SigninNumService signinNumService;
	/**
	 * 生成图文消息
	 * @param student
	 * @param message
	 * @return
	 */
	public  String getImgResponse(Student student,Message message){
		String back="";
		int classid = student.getClassid();
		MyLogger.info("classid  "+classid + "");
		Reply reply = new Reply();
		reply.setToUserName(message.getFromUserName());
		reply.setFromUserName(message.getToUserName());
		reply.setCreateTime(new Date());
		reply.setMsgType(Reply.NEWS);
		List<Article> articleList = new ArrayList<>();
		Article article = new Article();
		article.setTitle("考试成绩");
		article.setDescription(classid + "班英语成绩");
		article.setPicUrl("http://localhost:8080/aixuexiao/assets/img/bg301.jpg");
		article.setUrl("http://localhost:8080/aixuexiao/changda/echats?classid=" + classid);
		articleList.add(article);
		reply.setArticleCount(articleList.size());
		reply.setArticles(articleList);
		reply.setContent("");
		reply.setFuncFlag(0);
		//weixinService.addReply(reply);//保存回复消息到数据库
		back = WeixinUtil.replyNewsToXml(reply);
//		back = WeixinUtil.replyToXml(reply);
//        back= MessageUtil.newsMessageToXml(reply);
//        }
		MyLogger.info(back);
		return back;
	}


	@RequestMapping(value="/manager/students",method=RequestMethod.GET)
	public ModelAndView listStudent(String pagenum,Student student){
		ModelAndView mv=new ModelAndView();
		mv.setViewName("students");
		mv.addObject("sidebar","students");
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

	
	@RequestMapping(value="/manager/leavemessage",method=RequestMethod.GET)
	public ModelAndView leavemessage(int studentid){
		ModelAndView mv=new ModelAndView();
		Student student = studentService.findStudentById(studentid);
		if(null == student){
			mv.setViewName("redirect:/manager/students");
		}else{
			mv.setViewName("addstudentmessage");
			mv.addObject("sidebar","students");
			mv.addObject("student",student);
			List<StudentMessage> list = studentService.listMessageByStudentId(studentid, 100);
			mv.addObject("studentMessageList", list);
		}
		return mv;
	}
	
	@RequestMapping(value="/manager/examdetail",method=RequestMethod.GET)
	public ModelAndView examdetail(int studentid){
		ModelAndView mv=new ModelAndView();
		Student student = studentService.findStudentById(studentid);
		if(null == student){
			mv.setViewName("redirect:/manager/students");
		}else{
			mv.setViewName("examdetail");
			mv.addObject("sidebar","students");
			mv.addObject("student",student);
			List<ExamMark> list = studentService.findExamMarkByStudentId(studentid, 100);
			mv.addObject("emlist", list);
		}
		return mv;
	}
	
	@RequestMapping(value="/manager/addmessage",method=RequestMethod.POST)
	public ModelAndView addmessage(StudentMessage studentMessage){
		ModelAndView mv=new ModelAndView();
		mv.setViewName("redirect:/manager/leavemessage");
		mv.addObject("studentid",studentMessage.getStudentid());
		studentMessage.setInserttime(new Date());
		studentService.addStudentMessage(studentMessage);
		mv.addObject("notice","留言成功");
		return mv;
	}
	
	@RequestMapping(value="/manager/deletemessage",method=RequestMethod.GET)
	public ModelAndView deletemessage(int studentid,int messageid){
		ModelAndView mv=new ModelAndView();
		mv.setViewName("redirect:/manager/leavemessage");
		mv.addObject("studentid",studentid);
		studentService.deleteStudentMessageById(messageid);
		mv.addObject("notice","删除成功");
		return mv;
	}

	/**
	 * 测试echats
	 * @param
	 * @param
	 * @return
	 */
	@RequestMapping(value="/changda/echats",method=RequestMethod.GET)
	public ModelAndView echats(HttpServletRequest request){
		String  classid=request.getParameter("classid");
//		MyLogger.info(classid);
		ModelAndView mv=new ModelAndView();
		Map<String,BigDecimal> map = weixinService.test2(Integer.valueOf(classid));
		List<Map.Entry<String,BigDecimal>> list=new ArrayList<>(map.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String, BigDecimal>>() {
			@Override
			public int compare(Map.Entry<String, BigDecimal> o1, Map.Entry<String, BigDecimal> o2) {
				return o1.getValue().intValue()-o2.getValue().intValue();
			}
		});
		MyLogger.info("排序后");
		List<String> listName=new ArrayList<>();
		List<BigDecimal> listMark=new ArrayList<>();
		for (Map.Entry<String,BigDecimal> mapping:list){
			MyLogger.info(mapping.getKey()+":"+mapping.getValue());
			listName.add(mapping.getKey());
			listMark.add(mapping.getValue());
		}
		mv.addObject("listName",listName);
		mv.addObject("listMark",listMark);
		mv.setViewName("echats");
		return mv;
	}

	@RequestMapping(value = "/changda/signEcharts",method = RequestMethod.GET)
	public ModelAndView signEcharts(int studentid){
		ModelAndView mv=new ModelAndView();
		Student student=studentService.findStudentById(studentid);
		int succeed=signinDetailService.getItemsByStudentId(studentid);
		int all=signinNumService.getItems(student.getClassid());
		mv.setViewName("signEcharts");
		mv.addObject("succeed",succeed);
		mv.addObject("failure",all-succeed);
		return mv;
	}
}
