import mysql.connector

mydb = mysql.connector.connect(
    host='db4free.net',
    user='marwaneltoukhy',
    passwd='mirotarek7',
    database='project1_auc'
)

cursor = mydb.cursor(buffered=True)


def main():
    tuple_arr = []
    while 1:
        first = int(input('Do you want to Add(1) or View(2)? '))
        if first == 1:
            flag = int(input('If you want to add a new review on a course click on 1, '
                             'add a student record click 2, '
                             'add a course to student history click on 3: '))
            if flag == 1:
                rating = input('Rating: ')
                Review = input('Review: ')
                AUC = check_AUC()
                Course_Number = check_course()
                Dept_Code = check_Dept()
                cursor.execute(
                    "SELECT Course_Number, Dept_Code FROM CourseStudent\n WHERE AUC_ID = " + AUC + "\nAND Course_Number = " + Course_Number + "\nAND Dept_Code = '" + Dept_Code + "'")
                data = cursor.fetchall()
                if not data:
                    cursor.execute("insert into StudentReview values (%s,%s,%s,%s,%s, 0)",
                                   (rating, Review, AUC, Course_Number, Dept_Code))
                    print("You submitted a review!\n Note: it is not verified as you did not take the course before")
                else:
                    cursor.execute("insert into StudentReview values (%s,%s,%s,%s,%s,1)",
                                   (rating, Review, AUC, Course_Number, Dept_Code))
                    print("Review Submitted And verified!")
                    mydb.commit()
            elif flag == 2:
                AUC = input('AUC ID: ')
                Grade = input('Student Standing: ')
                Fname = input('Student First Name: ')
                Mname = input('Student Middle Name: ')
                Lname = input('Student Last Name: ')
                cursor.execute("insert into student values (%s,%s,%s,%s,%s)", (AUC, Grade, Fname, Mname, Lname))
                print("Done!")
                mydb.commit()
            elif flag == 3:
                LetterGrade = input('Letter Grade: ')
                year = input('Year: ')
                semester = input('Semester: ')
                AUC = check_AUC()
                Course_Number = check_course()
                Dept_Code = check_Dept()
                cursor.execute("insert into CourseStudent values (%s,%s,%s,%s,%s,%s)",
                               (LetterGrade, year, semester, Dept_Code, Course_Number, AUC))
                print("Done!")
                mydb.commit()
        else:
            flag = int(input('View existing reviews on a given course (1), '
                             'Show all available courses for a given Semester (2), '
                             'View Courses information (3) '))
            if flag == 1:
                course = check_course()
                Dept_code = check_Dept()
                cursor.execute("SELECT TextReview FROM StudentReview "
                               "WHERE Course_Number= " + course + " "
                                                                  "AND Dept_Code= '" + Dept_code + "';")
                data = cursor.fetchone()
                print(data[0])
            elif flag == 2:
                AUC = check_AUC()
                sem = input("Semester you are planning: ")
                cursor.execute("SELECT Course_Name "
                               "FROM CourseOffering s,  CourseStudent c WHERE " + AUC + " = c.AUC_ID "
                                                                                        "AND LOCATE(c.Dept_Code, s.prereq) AND LOCATE(c.Course_Number, s.prereq) "
                                                                                        "AND LOCATE('" + sem + "', LCASE(s.SemesterOffered)) "
                                                                                                               "AND LetterGrade != 'D' AND LetterGrade != 'D-' AND LetterGrade != 'F';")
                data = cursor.fetchall()
                for a_tuple in data:
                    tuple_arr.append(a_tuple[0])
                print("Courses that you took their prerequisites: ", tuple_arr)
                cursor.execute(
                    "SELECT distinct Course_Name FROM CourseOffering s,  CourseStudent c WHERE " + AUC + " = c.AUC_ID "
                                                                                                         "AND s.Course_Number != c.Course_Number AND s.Dept_Code != c.Dept_Code AND s.prereq IS NULL;")
                data = cursor.fetchall()
                tuple_arr.clear()
                for a_tuple in data:
                    tuple_arr.append(a_tuple[0])
                print("Courses that Doesn't need prerequisites: ", tuple_arr)
            elif flag == 3:
                course = check_course()
                Dept_code = check_Dept()
                cursor.execute("SELECT * FROM CourseOffering\n"
                               "WHERE Course_Number= " + course + "\nAND Dept_Code= '" + Dept_code + "'")
                data = cursor.fetchone()
                print("Name: ", data[0])
                print("Number: ", data[1])
                print("Department: ", data[2])
                print("Description: ", data[3])
                print("Notes: ", data[4])
                print("Number Of Credits: ", data[5])
                print("Semester Offered: ", data[6])
                print("prerequisite: ", data[7])
                print("CrossListed: ", data[8])
        if input("Do you want to continue or exit? (please type 'continue' or 'exit'): ").lower() == 'exit':
            break


def check_AUC():
    AUC = input('AUC ID: ')
    while 1:
        cursor.execute(
            "SELECT AUC_ID FROM student\n WHERE AUC_ID = " + AUC)
        data = cursor.fetchall()
        if not data:
            AUC = input('AUC ID is wrong. Please type the right AUC ID: ')
        else:
            break
    return AUC


def check_course():
    Course_Number = input('Course Number: ')
    while 1:
        cursor.execute(
            "SELECT Course_Number FROM CourseOffering\n WHERE Course_Number = " + Course_Number)
        data = cursor.fetchall()
        if not data:
            Course_Number = input('Course Number is wrong, no such Course. Please type the right Course '
                                  'Number: ')
        else:
            break
    return Course_Number


def check_Dept():
    Dept_Code = input('Department Code: ')
    while 1:
        cursor.execute(
            "SELECT Dept_Code FROM CourseOffering\n WHERE Dept_code = '" + Dept_Code + "'")
        data = cursor.fetchall()
        if not data:
            Dept_Code = input("Department code is wrong, no such department. Please type the right department code")
        else:
            break
    return Dept_Code


main()

