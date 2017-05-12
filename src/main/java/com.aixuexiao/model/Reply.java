package com.aixuexiao.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.aixuexiao.resopnseMessage.MyArticle;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamOmitField;

/**
 * 回复用户的消息
 */
public class Reply implements Serializable {

	public static final String TEXT = "text";
	public static final String MUSIC = "music";
	public static final String NEWS = "news";
	// 位0x0001被标志时，星标刚收到的消息
	@XStreamAlias("FuncFlag")
	private int FuncFlag;

	public int getFuncFlag() {
		return FuncFlag;
	}

	public void setFuncFlag(int funcFlag) {
		FuncFlag = funcFlag;
	}

	public static final String ERROR_CONTENT = "查询失败，请检查你的回复是否正确" +
			"。\n查询最近考试情况请回复：考试\n 查询最近最近10次考试情况请回复：" +
			"考试历史\n 查询老师留言情况请回复：" +
			"留言\n查询老师留言记录（最近10次）情况请回复：" +
			"留言历史\n查询班级动态情况请回复：" +
			"动态\n查询班级动态记录（最近10次）情况请回复：" +
			"动态历史\n查询班级成绩上次考试排名请回复：图文\n";
	public static final String WELCOME_CONTENT = "欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，" +
			"老师留言和班级动态。\n查询最近考试情况请回复：考试\n 查询最近最近10次考试情况请回复：" +
			"考试历史\n 查询老师留言情况请回复：" +
			"留言\n查询老师留言记录（最近10次）情况请回复：" +
			"留言历史\n查询班级动态情况请回复：" +
			"动态\n查询班级动态记录（最近10次）情况请回复：" +
			"动态历史\n查询班级成绩上次考试排名请回复：图文\n";
	
	@XStreamOmitField
	private int id;//数据库存储id
	
	// 开发者微信号  
	@XStreamAlias("ToUserName")
    private String toUserName;  
    // 发送方帐号（一个OpenID）  
	@XStreamAlias("FromUserName")
    private String fromUserName;  
    // 消息创建时间 
	@XStreamAlias("CreateTime")
    private Date createTime;  
    // 消息类型（text/music/news）
	@XStreamAlias("MsgType")
    private String msgType;  
    
    //回复的消息内容,长度不超过2048字节 (文本消息专有)
	@XStreamAlias("Content")
    private String content;
    
    //音乐链接 (音乐消息专有)
	@XStreamAlias("MusicUrl")
    private String musicUrl;
    //高质量音乐链接，WIFI环境优先使用该链接播放音乐 (音乐消息专有)
	@XStreamAlias("HQMusicUrl")
    private String hQMusicUrl;
    
    //图文消息个数，限制为10条以内  (图文消息专有) 
	@XStreamAlias("ArticleCount")
    private int articleCount; 
    
    //多条图文消息信息，默认第一个item为大图
	@XStreamAlias("Articles")
    private List<Article> articles;

//	public static void main(String[] args) {
//		System.out.println("http://mmsns.qpic.cn/mmsns/UKMLIAeREF9IyZGhfvF8f0CAKDzEvXwCibLKUM4kmsfGnZvFM7EJlrg/0".length());
//	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getToUserName() {
		return toUserName;
	}

	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}

	public String getFromUserName() {
		return fromUserName;
	}

	public void setFromUserName(String fromUserName) {
		this.fromUserName = fromUserName;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getMsgType() {
		return msgType;
	}

	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}


	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMusicUrl() {
		return musicUrl;
	}

	public void setMusicUrl(String musicUrl) {
		this.musicUrl = musicUrl;
	}

	public String gethQMusicUrl() {
		return hQMusicUrl;
	}

	public void sethQMusicUrl(String hQMusicUrl) {
		this.hQMusicUrl = hQMusicUrl;
	}

	public int getArticleCount() {
		return articleCount;
	}

	public void setArticleCount(int articleCount) {
		this.articleCount = articleCount;
	}

	public List<Article> getArticles() {
		return articles;
	}

	public void setArticles(List<Article> articles) {
		this.articles = articles;
	}

    
	
	
}
