#!/usr/bin/python
#coding: utf-8 #############################################################
# File Name: localhost.py
# Author: mylonly
# mail: tianxianggen@gmail.com
#Blog:www.mylonly.com
# Created Time: 2015年01月09日 星期五 15时38分11秒
#########################################################################

import scrapy

from scrapy.contrib.spiders import CrawlSpider,Rule
from scrapy.contrib.linkextractors.sgml import SgmlLinkExtractor
from scrapy.selector import Selector
from mylonly.items import localhostItem

class localhost(CrawlSpider):
	name = "localhostSpider"
	allowed_domains = ['mylonly.com']
	number = 0
	start_urls = ['http://www.mylonly.com']
	rules = (
			Rule(SgmlLinkExtractor(allow = ('.*')),callback = 'parseArticle',follow=True),
			Rule(SgmlLinkExtractor(allow = ('.*\.html')),callback = 'parseArticle',follow=True),
			)
	def parseArticle(self,response):
		isExsit = response.url.find('.html')
		if isExsit > 0:
			self.number +=1
			sel = Selector(response)
			item = localhostItem()
			item['title'] = sel.xpath('//head//title/text()').extract()[0].encode('utf-8')
			item['link'] = response.url
			self.log('find %d article :%s' % (self.number,item['title']))