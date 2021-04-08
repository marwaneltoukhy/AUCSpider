# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class AucspiderItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    Course_Name = scrapy.Field()
    Course_Number = scrapy.Field()
    description = scrapy.Field()
    department = scrapy.Field()
    departments = scrapy.Field()
    creditHour = scrapy.Field()
    prereq = scrapy.Field()
    offering = scrapy.Field()
    notes = scrapy.Field()
    cross_list = scrapy.Field()
    pass
