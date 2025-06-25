package com.spring.biz.common;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("boardVO")
public class BoardDTO {  // DB - 테이블
	
	private int    seq;
    private String title;
    private String writer;
    private String content;
    private Date   regDate;
    private int    cnt;
    
    
    
    //검색속성추가
    private String searchCondition;   // 메뉴
    private String searchKeyword;     // 검색어
    
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	//*****************************************************
	
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
    
    @Override
    public String toString() {
        return "BoardDTO [seq=" + seq + ", title=" + title + ", writer=" + writer + ", content=" + content
                + ", regDate=" + regDate + ", cnt=" + cnt + ", searchCondition=" + searchCondition
                + ", searchKeyword=" + searchKeyword + "]";
    }
}
