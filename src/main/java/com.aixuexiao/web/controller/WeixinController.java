package com.aixuexiao.web.controller;


import com.aixuexiao.dao.StudentDao;
import com.aixuexiao.dao.StudentMessageDao;
import com.aixuexiao.model.*;
import com.aixuexiao.service.*;
import com.aixuexiao.util.MyLogger;
import com.aixuexiao.util.WeixinUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller()
public class WeixinController {

	private static final String TOKEN = "weixinCourse";

	public static int pagesize = 10;

	@Resource(name = "weixinService")
	private WeixinService weixinService;

	@Resource(name = "studentService")
	private StudentService studentService;

	@Resource(name = "studentMessageDao")
	private StudentMessageDao studentMessageDao;

	@Resource(name = "studentDao")
	private StudentDao studentDao;

	@Resource(name = "signinNumService")
	private SigninNumService signinNumService;

	@Resource(name = "signinDetailService")
	private SigninDetailService signinDetailService;

	@RequestMapping(value = "/test", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String test(HttpServletRequest request) {
		return weixinService.getStudentMessageHistoryByStudentId(30202);
	}

	/**
	 * 获取签到信息
	 *
	 * @param signnum
	 * @return
	 */
	public String getSignInfo(String fromUserName,String signnum) {
		SigninNum signinNum = signinNumService.getLatestSigninNum();
		String dbnum = signinNum.getSignnum();
		if (null != signnum && dbnum.equals(signnum) && new Date().getTime() <= signinNum.getSigntime().getTime()) {
			//把签到成功的同学保存到数据库中
			SigninDetail signinDetail=new SigninDetail();
			Student student = isConnected2(fromUserName);
			signinDetail.setFlag(1);
			signinDetail.setSigntime(new Date());
			signinDetail.setClassid(student.getClassid());
			signinDetail.setSignid(signinNum.getId());
			signinDetail.setStudentid(student.getId());
			signinDetailService.saveSigninDetail(signinDetail);
			return "签到成功!";
		} else {
			return "签到失败";
		}
	}
	public String getBindInfo(String fromUserName, String str1) {
		String back = "";

		Student student1 = isConnected2(fromUserName);
		try {
			int studentid = Integer.valueOf(str1);
			Student student2 = studentDao.findStudentById(studentid);
			if (null != student1) {
				back = "该微信已绑定学号!";
//                return back;
			}
			if (null == student2) {
				back = "请输入正确的学号!";
//                return back;
			} else {
				student2.setFromusername(fromUserName);
				student2.setFlag(1);
				studentDao.updateStudent(student2);
				back = "微信绑定成功!";
//                return "微信绑定成功!";
			}
		} catch (NumberFormatException e) {
			back = Reply.ERROR_CONTENT;

		}
		return back;
	}
	/**
	 * 根据微信号判断是否关联过学号
	 *
	 * @param fromUserName
	 * @param studentid
	 * @param process
	 * @return
	 */

	public boolean isConnected(String fromUserName, int studentid, String process) {
		Student student = studentDao.findStudentById(studentid);
		if (null != student.getFromusername() && student.getFromusername().equals(fromUserName)) {
			MyLogger.info("恭喜!😄遍历到微信号: " + student.getFromusername());
			return true;
		}
		if (process.equals("绑定")) {
			student.setFromusername(fromUserName);
			student.setFlag(1);
			studentDao.updateStudent(student);
		}
		MyLogger.info("未遍历到该微信号");
		return false;
	}

	public Student isConnected2(String fromUserName) {
		return studentDao.findStudentByFromUserName(fromUserName);
	}

	public String connId(String fromUserName, int studentid, String process) {
		String back = "";
		if (!process.equals("绑定")) {
			return "请按指示命令操作!";
		}
		Student student1 = isConnected2(fromUserName);
		Student student2 = studentDao.findStudentById(studentid);
		if (null != student1) {
			back = "该微信已绑定学号!";
			return back;
		}
		if (null == student2) {
			back = "请输入正确的学号!";
			return back;
		} else {
			student2.setFromusername(fromUserName);
			student2.setFlag(1);
			studentDao.updateStudent(student2);
			return "微信绑定成功!";
		}

	}



	//接收微信公众号接收的消息，处理后再做相应的回复
	@RequestMapping(value = "/weixin", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String replyMessage(HttpServletRequest request) {
		//仅处理微信服务端发的请求
		if (checkWeixinReques(request)) {
			Map<String, String> requestMap = WeixinUtil.parseXml(request);
			Message message = WeixinUtil.mapToMessage(requestMap);
			weixinService.addMessage(message);//保存接受消息到数据库
			String replyContent = Reply.WELCOME_CONTENT;
			String type = message.getMsgType();
			//获取微信用户唯一标识
			String fromUserName = message.getFromUserName();

			if (type.equals(Message.TEXT)) {
				String content = message.getContent();//消息内容
				String[] cs = content.split("_");//消息内容都以下划线_分隔
				//消息长度为2 时,判断是否为绑定学号
				//            /**
				if (cs.length == 2) {//绑定学号
					String info = "";
					switch (cs[1]) {
						case "签到":
							info = getSignInfo(fromUserName,cs[0]);
							break;
						case "绑定":
							info = getBindInfo(fromUserName, cs[0]);
							break;
						default:
							info = Reply.ERROR_CONTENT;
							break;

					}
					return getTextResponse(info, message);
//                    if ("签到".equals(cs[1])){
//                        String info=getSignInfo(cs[0]);
//                        return ;
//                    }
//                    if ("绑定".equals(cs[1])){
//
//                    }
//                    try {
//                        int studentid = Integer.valueOf(cs[0]);
//                        String process = cs[1];
//                        //  2
//                        return getTextResponse(connId(fromUserName, studentid, process), message);
//                    } catch (NumberFormatException e) {
//                        // 1
//                        replyContent = Reply.ERROR_CONTENT;
//                        return getTextResponse(replyContent, message);
//                    }
				}
//**/

				Student student = isConnected2(fromUserName);
				if (null == student) {
					replyContent = "你还未绑定学号,请回复以下格式消息绑定学号 : 学号_绑定(如:3011_绑定)\n\n注意 : 一个微信号只能绑定一个学号! 且不可解绑!!!";
					// 3
					return getTextResponse(replyContent, message);
				}

				if ("图文".equals(message.getContent())) {
//                    return new StudentController().getImgResponse(student,message);
					return new ImageMessageService().createPic(student, message);
				} else {
					return getTextResponse(getProcess(student.getId(), message.getContent()), message);
//                    return  getTextResponse(replyContent,message);
				}
			} else {
				// 4
				return getTextResponse(replyContent, message);
			}

		} else {
			return "error";
		}
	}

	/**
	 * 控制逻辑重构
	 *
	 * @param studentid
	 * @param process
	 * @return
	 */
	public String getProcess(int studentid, String process) {
		String replyContent = "";
		if ("考试".equals(process)) {
			replyContent = weixinService.getSingleExamMarkStringByStudentId(studentid);
		} else if ("考试历史".equals(process)) {
			replyContent = weixinService.getExamMarkHistoryStringByStudentId(studentid);
		} else if ("留言".equals(process)) {
			replyContent = weixinService.getSingleStudentMessageByStudentId(studentid);
		} else if ("留言历史".equals(process)) {
			replyContent = weixinService.getStudentMessageHistoryByStudentId(studentid);
		} else if ("动态".equals(process)) {
			replyContent = weixinService.getSingleClassesNewsByStudentId(studentid);
		} else if ("动态历史".equals(process)) {
			replyContent = weixinService.getClassesNewsHistoryByStudentId(studentid);
		} else if ("班级成绩".equals(process)) {
			replyContent = weixinService.test(studentid);
		} else {
			replyContent = "请输入正确的指令\n" + Reply.WELCOME_CONTENT;
		}

		return replyContent;
	}

	/**
	 * 文本型消息回复
	 *
	 * @param replyContent
	 * @param message
	 * @return
	 */
	public String getTextResponse(String replyContent, Message message) {
		String back = "";
		//拼装回复消息
		Reply reply = new Reply();
		reply.setToUserName(message.getFromUserName());
		reply.setFromUserName(message.getToUserName());
		reply.setCreateTime(new Date());
		reply.setContent(replyContent);
		reply.setFuncFlag(0);
		reply.setMsgType(Reply.TEXT);
		//保存回复消息到数据库
		weixinService.addReply(reply);
		//将回复消息序列化为xml形式
//        MyLogger.info("序列化前: "+reply.getContent());
		back = WeixinUtil.replyToXml(reply);
//        back = WeixinUtil.replyTextToXml(reply);
//        back= MessageUtil.textMessageToXml(reply);
		MyLogger.info("序列化后: " + back);
		return back;
	}


	//微信公众平台验证url是否有效使用的接口
	@RequestMapping(value = "/weixin", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String initWeixinURL(HttpServletRequest request) {
		String echostr = request.getParameter("echostr");
		if (checkWeixinReques(request) && echostr != null) {
			return echostr;
		} else {
			return "error";
		}
	}


	/**
	 * 根据token计算signature验证是否为weixin服务端发送的消息
	 */
	private static boolean checkWeixinReques(HttpServletRequest request) {
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		if (signature != null && timestamp != null && nonce != null) {
			String[] strSet = new String[]{TOKEN, timestamp, nonce};
			java.util.Arrays.sort(strSet);
			String key = "";
			for (String string : strSet) {
				key = key + string;
			}
			String pwd = WeixinUtil.sha1(key);
			return pwd.equals(signature);
		} else {
			return false;
		}
	}

	/**
	 * 收到消息列表页面
	 */
	@RequestMapping(value = "/manager/messages", method = RequestMethod.GET)
	public ModelAndView listMessage(String pagenum) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("sidebar", "messages");
		mv.setViewName("messages");
		int num = 1;
		if (null != pagenum) {
			num = Integer.parseInt(pagenum);
		}
		List<Message> list = weixinService.listMessage((num - 1) * pagesize, pagesize);
		mv.addObject("messageList", list);
		mv.addObject("pagenum", num);
		mv.addObject("length", list.size());
		return mv;
	}


	/**
	 * 回复消息列表页面
	 */
	@RequestMapping(value = "/manager/replys", method = RequestMethod.GET)
	public ModelAndView listReply(String pagenum) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("sidebar", "replys");
		mv.setViewName("replys");
		int num = 1;
		if (null != pagenum) {
			num = Integer.parseInt(pagenum);
		}
		List<Reply> list = weixinService.listReply((num - 1) * pagesize, pagesize);
		mv.addObject("replyList", list);
		mv.addObject("pagenum", num);
		mv.addObject("length", list.size());
		return mv;
	}


}
