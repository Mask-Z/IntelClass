package com.aixuexiao.service;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.aixuexiao.model.*;
import com.aixuexiao.resopnseMessage.MyArticle;
import org.springframework.stereotype.Service;

import com.aixuexiao.dao.ClassesNewsDao;
import com.aixuexiao.dao.ExamDao;
import com.aixuexiao.dao.MessageDao;
import com.aixuexiao.dao.ReplyDao;
import com.aixuexiao.dao.StudentDao;
import com.aixuexiao.dao.StudentMessageDao;

@Service("weixinService")
public class WeixinService {

    @Resource(name = "messageDao")
    private MessageDao messageDao;

    @Resource(name = "replyDao")
    private ReplyDao replyDao;

    @Resource(name = "examDao")
    private ExamDao examDao;

    @Resource(name = "studentDao")
    private StudentDao studentDao;

    @Resource(name = "studentMessageDao")
    private StudentMessageDao studentMessageDao;

    @Resource(name = "classesNewsDao")
    private ClassesNewsDao classesNewsDao;

    //	public static void main(String[] args) {
//		Student student=new StudentDao().findStudentById(3022);
//		System.out.println(student);
//	}
    @Resource(name = "classesService")
    private ClassesService classesService;
    @Resource(name = "studentService")
    private StudentService studentService;
    @Resource(name = "questionService")
    private QuestionService questionService;

    public String getQuestions(int studentid) {
        Student student=studentService.findStudentById(studentid);
        Question question=questionService.findLatestQuestionByClassId(student.getClassid());
        StringBuilder sb = new StringBuilder();
        if (null != question) {
            sb.append("格式答题（题号.解_答案)\n").append("本次题目如下\ue301\n");
            sb.append(question.getTitle()).append(": \n").append(question.getContent()).append("\n");
        }else {
            sb.append("暂时没有题目！");
        }
        return sb.toString();
    }
    /**
     * 班级考试成绩排名并展现
     *
     * @return 根据班级id查出该班级所有学生信息
     */

    public String test(int classid) {
        List<Student> stlist = classesService.findStudentByClassesId(classid);
        StringBuilder sb = new StringBuilder();
        if (null != stlist) {
            sb.append("该班成绩如下:\n");
        }
        for (Student student : stlist) {
            sb.append(student.getName() + " : " + examDao.findExamMarkByStudentId(student.getId(), 1).get(0).getMark() + "\n");
        }
        return sb.toString();
    }

    public Map<String, BigDecimal> test2(int classid) {
        List<Student> stlist = classesService.findStudentByClassesId(classid);
        HashMap<String, BigDecimal> map = new HashMap<>();
        if (null != stlist) {
            for (Student student : stlist) {
                map.put(student.getName(), examDao.findExamMarkByStudentId(student.getId(), 1).get(0).getMark());
            }
        }
        return map;
    }

    /**
     * 查询学生最近一次考试情况
     *
     * @param studentid 学生编号
     * @return 返回考试情况字符串
     */
    public String getSingleExamMarkStringByStudentId(int studentid) {
        StringBuilder sb = new StringBuilder();
        Student student = studentDao.findStudentById(studentid);
        if (student == null) {
            sb.append("您好，未找到编号为").append(studentid).append("的学生！");
        } else {
            List<ExamMark> list = examDao.findExamMarkByStudentId(studentid, 1);
            sb.append("您好，编号为").append(studentid).append("的学生(").append(student.getName());
            if (list == null || list.size() < 1 || list.get(0).getExam() == null) {
                sb.append(")无考试记录！");
            } else {
                ExamMark em = list.get(0);
                Exam e = em.getExam();
                DateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
                sb.append(")最近一次考试记录如下:\n").append("科目：").append(e.getCourse())
                        .append("\n分数：").append(em.getMark())
                        .append("\n班级排名：").append(em.getRank())
                        .append("\n考试时间：").append(sf.format(em.getExamtime()))
                        .append("\n老师备注：").append(em.getRemark())
                        .append("\n试卷满分：").append(e.getFullmarks())
                        .append("\n班级均分：").append(e.getAverage())
                        .append("\n班级最高分：").append(e.getTopmark())
                        .append("\n班级最低分：").append(e.getLowestmark())
                        .append("\n考试说明：").append(e.getRemark());
            }
        }
        return sb.toString();
    }

    /**
     * 查询学生历次考试情况(最近10次)
     *
     * @param studentid 学生编号
     * @return 返回考试情况字符串
     */
    public String getExamMarkHistoryStringByStudentId(int studentid) {
        StringBuilder sb = new StringBuilder();
        Student student = studentDao.findStudentById(studentid);
        if (student == null) {
            sb.append("您好，未找到编号为").append(studentid).append("的学生！");
        } else {
            sb.append("您好，编号为").append(studentid).append("的学生(").append(student.getName());
            List<ExamMark> list = examDao.findExamMarkByStudentId(studentid, 10);
            if (list == null || list.size() < 1 || list.get(0).getExam() == null) {
                sb.append(")无考试记录！");
            } else {
                DateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
                Exam e = null;
                sb.append(")最近10次考试情况如下:");
                for (ExamMark em : list) {
                    e = em.getExam();
                    sb.append("\n考试时间：").append(sf.format(em.getExamtime()))
                            .append("\n科目：").append(e.getCourse())
                            .append("\n分数：").append(em.getMark())
                            .append("\n班级排名：").append(em.getRank())
                            .append("\n老师备注：").append(em.getRemark())
                            .append("\n试卷满分：").append(e.getFullmarks())
                            .append("\n班级均分：").append(e.getAverage())
                            .append("\n班级最高分：").append(e.getTopmark())
                            .append("\n班级最低分：").append(e.getLowestmark())
                            .append("\n考试说明：").append(e.getRemark())
                            .append("\n------分割线-------");
                }
            }
        }
        return sb.toString();
    }

    /**
     * 根据学生编号查询学生最近的老师留言信息
     *
     * @param studentid 学生编号
     * @return 以字符串形式返回老师留言信息
     */
    public String getSingleStudentMessageByStudentId(int studentid) {
        StringBuilder sb = new StringBuilder();
        Student student = studentDao.findStudentById(studentid);
        if (student == null) {
            sb.append("您好，未找到编号为").append(studentid).append("的学生！");
        } else {
            sb.append("您好，编号为").append(studentid).append("的学生(").append(student.getName());
            List<StudentMessage> list = studentMessageDao.findStudentMessageByStudentId(studentid, 1);
            if (list == null || list.size() < 1) {
                sb.append(")无老师留言！");
            } else {
                sb.append(")最近老师留言如下:");
                DateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
                StudentMessage sm = list.get(0);
                sb.append("\n留言时间：").append(sf.format(sm.getInserttime()))
                        .append("\n留言内容：").append(sm.getContent());
            }
        }
        return sb.toString();
    }

    /**
     * 根据学生编号查询学生的老师留言信息记录（最近10次）
     *
     * @param studentid 学生编号
     * @return 以字符串形式返回老师留言信息
     */
    public String getStudentMessageHistoryByStudentId(int studentid) {
        StringBuilder sb = new StringBuilder();
        Student student = studentDao.findStudentById(studentid);
        if (student == null) {
            sb.append("您好，未找到编号为").append(studentid).append("的学生！");
        } else {
            sb.append("您好，编号为").append(studentid).append("的学生(").append(student.getName());
            List<StudentMessage> list = studentMessageDao.findStudentMessageByStudentId(studentid, 10);
            if (list == null || list.size() < 1) {
                sb.append(")无老师留言！");
            } else {
                sb.append(")最近(10次)老师留言如下:");
                DateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
                for (StudentMessage sm : list) {
                    sb.append("\n留言时间：").append(sf.format(sm.getInserttime()))
                            .append("\n留言内容：").append(sm.getContent())
                            .append("\n------分割线-------");
                }
            }
        }
        return sb.toString();
    }

    /**
     * 根据学生编号查询学生所在班级的班级动态
     *
     * @param studentid 学生编号
     * @return 以字符串形式返回学生所在班级的班级动态
     */
    public String getSingleClassesNewsByStudentId(int studentid) {
        StringBuilder sb = new StringBuilder();
        Student student = studentDao.findStudentById(studentid);
        if (student == null) {
            sb.append("您好，未找到编号为").append(studentid).append("的学生！");
        } else {
            sb.append("您好，编号为").append(studentid).append("的学生(").append(student.getName());
            List<ClassesNews> list = classesNewsDao.findClassesNewsByClassId(student.getClassid(), 1);
            if (list == null || list.size() < 1) {
                sb.append(")所在班级无班级动态！");
            } else {
                sb.append(")最近班级动态如下:");
                DateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
                ClassesNews cn = list.get(0);
                sb.append("\n动态时间：").append(sf.format(cn.getInserttime()))
                        .append("\n动态内容：").append(cn.getContent());
            }
        }
        return sb.toString();
    }

    /**
     * 根据学生编号查询学生所在班级的班级动态
     *
     * @param studentid 学生编号
     * @return 以字符串形式返回学生所在班级的班级动态
     */
    public String getClassesNewsHistoryByStudentId(int studentid) {
        StringBuilder sb = new StringBuilder();
        Student student = studentDao.findStudentById(studentid);
        if (student == null) {
            sb.append("您好，未找到编号为").append(studentid).append("的学生！");
        } else {
            sb.append("您好，编号为").append(studentid).append("的学生(").append(student.getName());
            List<ClassesNews> list = classesNewsDao.findClassesNewsByClassId(student.getClassid(), 10);
            if (list == null || list.size() < 1) {
                sb.append(")所在班级无班级动态！");
            } else {
                sb.append(")最近班级动态如下:");
                DateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
                for (ClassesNews cn : list) {
                    sb.append("\n动态时间：").append(sf.format(cn.getInserttime()))
                            .append("\n动态内容：").append(cn.getContent())
                            .append("\n------分割线-------");
                }
            }
        }
        return sb.toString();
    }

    /**
     * 新增Message对象到数据库中
     */
    public void addMessage(Message message) {
        messageDao.addMessage(message);
    }


    /**
     * 将数据库中Message数据分页查出
     *
     * @param start 其实数据条数
     * @param size  展示数据每页的大小
     */
    public List<Message> listMessage(int start, int size) {
        return messageDao.findMessage(start, size);
    }

    /**
     * 将数据库中Message数据分页查出
     *
     * @param start 其实数据条数
     * @param size  展示数据每页的大小
     */
    public List<Reply> listReply(int start, int size) {
        return replyDao.findReply(start, size);
    }


    /**
     * 保存回复消息至数据库中，如果为news类型消息将article一并保存
     */
    public void addReply(Reply reply) {
        replyDao.addReply(reply);
        if (Reply.NEWS.equals(reply.getMsgType()) && null != reply.getArticles()) {
            List<Article> articles = reply.getArticles();
            for (Article a : articles) {
                a.setReplyId(reply.getId());
                replyDao.addArticle(a);
            }
        }
    }

}
