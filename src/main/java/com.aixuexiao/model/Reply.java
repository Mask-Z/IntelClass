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

	public static final String ERROR_CONTENT = "查询失败，请按照以下指令回复: \n" +
					"\ue21c考试: 最近一次考试情况\n" +
					"\ue21d考试历史: 最近十次考试信息\n" +
					"\ue21e留言: 老师留言记录\n" +
					"\ue21f留言历史: 老师最近十次留言记录\n" +
					"\ue220动态: 班级动态\n" +
					"\ue221动态历史: 班级最近十条动态\n" +
					"\ue21a签到码_签到: 课堂签到\n" +
					"\ue219图文: 上次班级考试成绩排名\n" +
					"\ue21b签到: 个人签到信息图";

	public static final String WELCOME_CONTENT = "欢迎订阅常州学校智能课堂，你可以回复指定内容来获取信息:\n" +
			"\ue21c考试: 最近一次考试情况\n" +
			"\ue21d考试历史: 最近十次考试信息\n" +
			"\ue21e留言: 老师留言记录\n" +
			"\ue21f留言历史: 老师最近十次留言记录\n" +
			"\ue220动态: 班级动态\n" +
			"\ue221动态历史: 班级最近十条动态\n" +
			"\ue21a签到码_签到: 课堂签到\n" +
			"\ue219图文: 上次班级考试成绩排名\n" +
			"\ue21b签到: 个人签到信息图";

	public static final String COMMON_CONTENT = "请您按照以下指令获取信息: \n" +
			"\ue21c考试: 最近一次考试情况\n" +
			"\ue21d考试历史: 最近十次考试信息\n" +
			"\ue21e留言: 老师留言记录\n" +
			"\ue21f留言历史: 老师最近十次留言记录\n" +
			"\ue220动态: 班级动态\n" +
			"\ue221动态历史: 班级最近十条动态\n" +
			"\ue21a签到码_签到: 课堂签到\n" +
			"\ue219图文: 上次班级考试成绩排名\n" +
			"\ue21b签到: 个人签到信息图";

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
