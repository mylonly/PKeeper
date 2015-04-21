#coding: utf-8 #############################################################
# File Name: spiders/paiba.py
# Author: mylonly
# mail: mylonly@gmail.com
#Blog:www.mylonly.com
# Created Time: 2014年09月02日 星期二 23时30分07秒
#########################################################################
#!/usr/bin/python
import urllib2
import os
import re

from scrapy.contrib.spiders import CrawlSpider,Rule
from scrapy.contrib.linkextractors.sgml import SgmlLinkExtractor
from scrapy.selector import Selector
from mylonly.items import wallpaperItem
from scrapy.http import Request

class paiba(CrawlSpider):
	name = "paibaSpider"
	allowed_domains = ['www.p8848.com']
	start_urls = ['http://www.p8848.com/qingchun/',
				  'http://www.p8848.com/idea/',
				  'http://www.p8848.com/sexy/',
				  'http://www.p8848.com/siwa/',
				  'http://www.p8848.com/stars/',
				  'http://www.p8848.com/net/',
				  'http://www.p8848.com/fzl/',
				  'http://www.p8848.com/model/']
	number = 0
	rules = (
			#Rule(SgmlLinkExtractor(allow = ('http://www.p8848.com/[a-z]+$'))),
			Rule(SgmlLinkExtractor(allow = ('http://www.p8848.com/[a-z]+/\d+.html')),callback = 'parse_image'),
			)
	def parse_type(self,response):
		self.log('find a Type url:%s'% response.url)
		

	def parse_image(self,response):
		self.number += 1
		self.log('number:%d,find a Image url:%s'%(self.number,response.url))
