package com.aixuexiao.web.controller;

import com.aixuexiao.model.*;
import com.aixuexiao.service.AnswerService;
import com.aixuexiao.service.ExamService;
import com.aixuexiao.service.QuestionService;
import com.aixuexiao.service.StudentService;
import com.aixuexiao.util.ExamUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Mr丶周 on 2017/5/29.
 */
@Controller
public class QuestionController {
	private static final int pagesize = 10;

	@Resource(name = "questionService")
	private QuestionService questionService;

	@Resource(name="examService")
	private ExamService examService;

	@Resource(name="answerService")
	private AnswerService answerService;

	@Resource(name="studentService")
	private StudentService studentService;

	@RequestMapping(value="/manager/questions",method= RequestMethod.GET)
	public ModelAndView listQuestions(String pagenum, Question question,String classid){
		ModelAndView mv=new ModelAndView();
		mv.setViewName("questions");
		mv.addObject("sidebar","questions");
		int num = 1;
		if(null!=pagenum){
			num = Integer.parseInt(pagenum);
		}
		List<Question> list = questionService.listQuestion((num-1)*pagesize, pagesize,question);
		List<Classes> clslist = examService.findAllClasses();
		mv.addObject("questionList", list);
		mv.addObject("clsList", clslist);
		mv.addObject("length", list.size());
		mv.addObject("pagenum", num);
		mv.addObject("question", question);
		mv.addObject("classid", classid);
		return mv;
	}

	@RequestMapping(value="/manager/addQuestion",method=RequestMethod.POST)
	public ModelAndView addExamMark(Question question){
		ModelAndView mv=new ModelAndView();
		mv.addObject("sidebar","questions");
		mv.setViewName("redirect:/manager/questions");
		question.setInserttime(new Date());
		questionService.addQuestion(question);
		return mv;
	}

	@RequestMapping(value="/manager/viewquestions",method=RequestMethod.GET)
	public ModelAndView viewExam(int questionid){
		ModelAndView mv=new ModelAndView();
		mv.setViewName("viewquestions");
		List<Answer> answerList=answerService.findAnswerByQuestionId(questionid);
		Question question=questionService.findQuestionByQuestionId(questionid);

		List<Temp> tempList=new ArrayList<>();
		for (Answer answer:answerList){
			Student student=studentService.findStudentById(answer.getStudentid());
			Temp temp=new Temp();
			temp.setName(student.getName());
			temp.setContent(answer.getContent());
			temp.setDate(answer.getInserttime());
			tempList.add(temp);
		}
		mv.addObject("sidebar","questions");
		mv.addObject("tempList",tempList);

		mv.addObject("question",question);
		return mv;
	}
}
