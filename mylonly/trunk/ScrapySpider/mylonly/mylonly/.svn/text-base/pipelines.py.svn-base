# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
import MySQLdb


class MylonlyPipeline(object):
    def process_item(self, item, spider):
        return item

class wallpaperPipeline(object):
	def process_item(self,item,spider):
		print 'imgSrc:',item['imgSrc']
		db = MySQLdb.connect("rdsauvva2auvva2.mysql.rds.aliyuncs.com","mylonly","703003659txg","wallpaper")
		cursor = db.cursor()
		db.set_character_set('utf8')
		cursor.execute('SET NAMES utf8;') 
		cursor.execute('SET CHARACTER SET utf8;')
		cursor.execute('SET character_set_connection=utf8;')

		sql ="INSERT INTO mobile_download(wallpaper_size,wallpaper_info,wallpaper_src) VALUES('%s','%s','%s')"%(item['size'],item['altInfo'],item['imgSrc'])
		try:
			print sql
			cursor.execute(sql)
			db.commit()
		except MySQLdb.Error,e:
			print "Mysql Error %d: %s" % (e.args[0], e.args[1])
		db.close()
		return item
