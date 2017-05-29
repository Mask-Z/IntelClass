package com.aixuexiao.service;

import com.aixuexiao.dao.AnswerDao;
import com.aixuexiao.model.Answer;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Mr丶周 on 2017/5/29.
 */
@Service("answerService")
public class AnswerService {
	@Resource(name = "answerDao")
	private AnswerDao answerDao;
	public void saveAnswer(Answer answer) {
		answerDao.saveAnswer(answer);
	}

	public List<Answer> findAnswerByQuestionId(int questionid) {
		return answerDao.findAnswerByQuestionId(questionid);
	}
}
