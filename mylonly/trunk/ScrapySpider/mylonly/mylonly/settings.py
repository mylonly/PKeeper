# -*- coding: utf-8 -*-

# Scrapy settings for mylonly project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/en/latest/topics/settings.html
#

BOT_NAME = 'mylonly'

SPIDER_MODULES = ['mylonly.spiders']
NEWSPIDER_MODULE = 'mylonly.spiders'
#禁止cookies,防止被ban  
COOKIES_ENABLED = False  
  
ITEM_PIPELINES = {  
		  'mylonly.pipelines.wallpaperPipeline':300  
		  }
# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'mylonly (+http://www.yourdomain.com)'
