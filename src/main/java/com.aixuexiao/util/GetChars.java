package com.aixuexiao.util;

/**
 * Created by Mr丶周 on 2017/5/13.
 */
public class GetChars {
	private static int getRandom(int count) {
		return (int) Math.round(Math.random() * (count));
	}
	private static final String string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIGKLMNOPQRSTUVWXYZ0123456789";

	public static String getRandomString(int length){
		StringBuffer sb = new StringBuffer();
		int len = string.length();
		for (int i = 0; i < length; i++) {
			sb.append(string.charAt(getRandom(len-1)));
		}
		return sb.toString();
	}
}
