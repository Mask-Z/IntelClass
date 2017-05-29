package com.aixuexiao.dao;

import com.aixuexiao.model.Answer;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by Mr丶周 on 2017/5/29.
 */
@Component("answerDao")
public class AnswerDao extends BaseDao {
	public void saveAnswer(Answer answer) {
		writerSqlSession.insert("com.aixuexiao.dao.AnswerDao.addAnswer", answer);
	}

	public List<Answer> findAnswerByQuestionId(int questionid) {
		return this.readSqlSession.selectList("com.aixuexiao.dao.AnswerDao.findAnswerByQuestionId",questionid);
	}
}
