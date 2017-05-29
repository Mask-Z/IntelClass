package com.aixuexiao.dao;

import com.aixuexiao.model.Exam;
import com.aixuexiao.model.Question;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Mr丶周 on 2017/5/29.
 */
@Component("questionDao")
public class QuestionDao extends BaseDao {
	public List<Question> findQuestion(int start, int size, Question question){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("size", size);
		map.put("question", question);
		return this.readSqlSession.selectList("com.aixuexiao.dao.QuestionDao.selectQuestion",map);
	}

	public void saveQuestion(Question question) {
		writerSqlSession.insert("com.aixuexiao.dao.QuestionDao.addQuestion", question);
	}

	public Question findLatestQuestionByClassId(int classid) {
		return this.readSqlSession.selectOne("com.aixuexiao.dao.QuestionDao.findLatestQuestionByClassId",classid);
	}

	public Question findQuestionByQuestionId(int questionid) {
		return this.readSqlSession.selectOne("com.aixuexiao.dao.QuestionDao.findQuestionByQuestionId",questionid);
	}
}
