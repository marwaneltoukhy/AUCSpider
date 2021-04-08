# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter

import mysql.connector


class AucspiderPipeline:
#     # def process_item(self, item, spider):
#     #     return item
#     def __init__(self):
#         self.create_connection()
#
#     def create_connection(self):
#         self.conn = mysql.connector.connect(
#             host='localhost',
#             user='root',
#             passwd='mirotarek7',
#             database='project1'
#         )
#         self.curr = self.conn.cursor()
#
#     def process_item(self, item, spider):
#         self.store_db2(item)
#         # self.store_db(item)
#         return item
#
#     def store_db2(self, item):
#         self.curr.execute("""insert into department values (%s)""", (
#             item['departments'],
#         ))
#         self.conn.commit()
    def __init__(self):
        self.create_connection()

    def create_connection(self):
        self.conn = mysql.connector.connect(
            host='localhost',
            user='root',
            passwd='mirotarek7',
            database='project1'
        )
        self.curr = self.conn.cursor()

    def process_item(self, item, spider):
        # self.store_db2(item)
        self.store_db(item)
        return item

    # def store_db2(self, item):
    #     self.curr.execute("""insert into department values (%s)""", (
    #         item['department'],
    #     ))
    #     self.conn.commit()

    def store_db(self, item):
        # self.curr.execute("""insert into department values (%s)""", (
        #             item['departments'],
        #         ))
        #         # self.conn.commit()

        self.curr.execute("""insert into CourseOffering values (%s,%s,%s,%s,%s,%s,%s,%s,%s)""", (
            item['Course_Name'],
            item['Course_Number'],
            item['department'],
            item['description'],
            item['notes'],
            item['creditHour'],
            item['offering'],
            item['prereq'],
            item['cross_list'],
        ))

        # self.curr.execute("""insert into StudentReview values (%s,%s,%s,%s,%s,%s,%s)""", (
        #     "Spring",
        #     4,
        #     "Good Course",
        #     1,
        #     900142353,
        #     item['Course_Name'][0],
        #     item['Course_Number'][0],
        # ))
        # self.curr.execute("""insert into DepartmentCourse values (%s,%s,%s)""", (
        #     item['department'],
        #     item['cross_list'],
        #     item['Course_Number'],
        # ))
        # self.curr.execute("""insert into DepartmentCourseStudent values (%s,%s,%s,%s)""", (
        #     item['department'],
        #     item['Course_Name'],
        #     item['Course_Number'],
        #     900142353,
        # ))
        #
        # self.curr.execute("""insert into StudentCourseReview values (%s,%s,%s,%s)""", (
        #     "A",
        #     item['Course_Name'][0],
        #     item['Course_Number'][0],
        #     900142353,
        # ))
        # self.curr.execute("""insert into student values (%s,%s,%s,%s,%s)""", (
        #     900142353,
        #     "4",
        #     "Ahmed",
        #     "Ali",
        #     "Sayed",
        # ))
        self.conn.commit()
