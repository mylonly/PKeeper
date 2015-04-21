# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class MylonlyItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    pass
class DoubanImageItem(scrapy.Item):
	address = scrapy.Field()

class wallpaperItem(scrapy.Item):
	size = scrapy.Field()
	altInfo = scrapy.Field()
	imgSrc = scrapy.Field()

class paibaItem(scrapy.Item):
	type = scrapy.Field()
	size = scrapy.Field()
	altInfo = scrapy.Field()
	imgSrc = scrapy.Field()

class localhostItem(scrapy.Item):
	title = scrapy.Field()
	link = scrapy.Field()
