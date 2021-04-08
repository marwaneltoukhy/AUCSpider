import scrapy
from ..items import AucspiderItem
import re


class AUCSpider(scrapy.Spider):
    name = 'auc'
    page = 1
    departments = None
    start_urls = [
        'http://catalog.aucegypt.edu/content.php?catoid=36&navoid=1738'
    ]

    def parse(self, response):
        items = AucspiderItem()
        for p in response.xpath('//select[@id="courseprefix"]/option/text()').getall():
            if p != "All prefixes\u2026":
                AUCSpider.departments = p
                items['departments'] = AUCSpider.departments
                yield items
        descrip_url = response.css(".block_content tr .width a::attr(href)").extract()
        for i in range(len(descrip_url)):
            descrip_url[i] = 'http://catalog.aucegypt.edu/' + descrip_url[i]
            if descrip_url[i] is not None:
                flag = 1
                yield response.follow(descrip_url[i], callback=self.parse2)


    def parse2(self, response):
        items = AucspiderItem()

        description1 = response.css(".block_content strong::text").extract()
        if description1[2] == "Cross-listed":
            cross_list = response.css(".block_content a::text").extract()
            cross_list = cross_list[2]
        else:
            cross_list = None
        prereq = response.css(".block_content div a::text").extract()
        if prereq[0] != "Back to Top":
            prereq = prereq[0]
        else:
            prereq = None
        offering = response.xpath('//*[@class="block_content"]/strong[contains(text(),"When Offered")]/following-sibling::text()').get()
        notes = response.xpath('//*[@class="block_content"]/strong[contains(text(),"Notes")]/following-sibling::text()').get()
        description = response.xpath('//*[@class="block_content"]/strong[contains(text(),"Description")]/following-sibling::text()').get()
        Course_Name = response.css(".block_content h1::text").extract()
        x = Course_Name[0].split()
        department = x[0]
        Course_Number = int(x[1][4:8])
        c = Course_Name[0].find('(')
        m = Course_Name[0].find('-')
        Course_Name = Course_Name[0][m + 1:c]
        creditHour = int(x[len(x) - 2][1])

        items['Course_Name'] = Course_Name
        items['Course_Number'] = Course_Number
        items['department'] = department
        items['creditHour'] = creditHour
        items['description'] = description
        items['prereq'] = prereq
        items['offering'] = offering
        items['notes'] = notes
        items['cross_list'] = cross_list

        # items['departments'] = AUCSpider.departments

        yield items

        pages_url = "http://catalog.aucegypt.edu/content.php?catoid=36&catoid=36&navoid=1738&filter%5Bitem_type%5D=3&filter%5Bonly_active%5D=1&filter%5B3%5D=1&filter%5Bcpage%5D=" + str(
            AUCSpider.page) + "#acalog_template_course_filter"
        if AUCSpider.page <= 25:
            AUCSpider.page += 1
            yield response.follow(pages_url, callback=self.parse)
