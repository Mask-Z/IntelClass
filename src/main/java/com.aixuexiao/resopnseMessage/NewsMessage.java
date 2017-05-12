package com.aixuexiao.resopnseMessage;

import com.aixuexiao.model.Article;

import java.util.List;

/**
 * Created by Administrator on 2017/5/10 0010.
 */
public class NewsMessage extends BaseMessage {
    // 图文消息个数，限制为10条以内
    private int ArticleCount;
    // 多条图文消息信息，默认第一个item为大图
    private List<MyArticle> Articles;

    public int getArticleCount() {
        return ArticleCount;
    }

    public void setArticleCount(int articleCount) {
        ArticleCount = articleCount;
    }

    public List<MyArticle> getArticles() {
        return Articles;
    }

    public void setArticles(List<MyArticle> articles) {
        Articles = articles;
    }
}
