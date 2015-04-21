package com.cheng.pkeeper.data;

import java.util.List;

public class BusinessData {
	private String attachAddr;
	private String filename;
	private String pic;
	private int docid;
	private int id;
	
	private String author;
	private int channel;
	private String content;
	private int deletestatus;
	private String docabstract;
	
	private int publishstatus;
	private String publishtime;
	private String title;
	private List<AttachmentsData> attachments;
	public String getAttachAddr() {
		return attachAddr;
	}
	public void setAttachAddr(String attachAddr) {
		this.attachAddr = attachAddr;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public int getDocid() {
		return docid;
	}
	public void setDocid(int docid) {
		this.docid = docid;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getChannel() {
		return channel;
	}
	public void setChannel(int channel) {
		this.channel = channel;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getDeletestatus() {
		return deletestatus;
	}
	public void setDeletestatus(int deletestatus) {
		this.deletestatus = deletestatus;
	}
	public String getDocabstract() {
		return docabstract;
	}
	public void setDocabstract(String docabstract) {
		this.docabstract = docabstract;
	}
	public int getPublishstatus() {
		return publishstatus;
	}
	public void setPublishstatus(int publishstatus) {
		this.publishstatus = publishstatus;
	}
	public String getPublishtime() {
		return publishtime;
	}
	public void setPublishtime(String publishtime) {
		this.publishtime = publishtime;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public List<AttachmentsData> getAttachments() {
		return attachments;
	}
	public void setAttachments(List<AttachmentsData> attachments) {
		this.attachments = attachments;
	}
}
