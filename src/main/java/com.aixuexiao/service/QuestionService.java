package com.aixuexiao.service;

import com.aixuexiao.dao.QuestionDao;
import com.aixuexiao.model.Exam;
import com.aixuexiao.model.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Mr丶周 on 2017/5/29.
 */
@Service("questionService")
public class QuestionService {
	@Resource(name = "questionDao")
	private QuestionDao questionDao;
	public List<Question> listQuestion(int start, int size, Question question){
		return questionDao.findQuestion(start,size,question);
	}

	public void addQuestion(Question question) {
		questionDao.saveQuestion(question);
	}

	public Question findLatestQuestionByClassId(int classid) {
		return questionDao.findLatestQuestionByClassId(classid);
	}

	public Question findQuestionByQuestionId(int questionid) {
		return questionDao.findQuestionByQuestionId(questionid);
	}
}
