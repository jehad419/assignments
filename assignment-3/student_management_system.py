#Student Class
class Student:
    def __init__(self , name , student_id , email , age , department):
        self.name = name
        self.student_id = student_id
        self.email = email
        self.age = age
        self.department = department

    def display_info(self):
        print(f"Student Name: {self.name}\nStudent ID: {self.student_id}\nStudent Email: {self.email}\nAge: {self.age}\nDepartment: {self.department}")
        
    def calculate_result(self , marks):
        if marks >= 90:
            return "A+"
        elif marks >= 80:
            return "A"
        else:
            return "FAIL"
    
    def get_student_type(self):
        return "On-goin Student"

#UnderGraduateStudent Class
class UnderGraduateStudent(Student):
    def __init__(self , name , student_id , email , age , department , semester):
        super().__init__(name , student_id , email , age , department )
        self.semester = semester

    def display_info(self):
        super().display_info()
        print(f"Semester: {self.semester}")
    
    def calculate_result(self , marks):
        return super().calculate_result(marks)
    
    def get_student_type(self):
        return "Under Graduate Student"
    
#Graduate Student Class
class GraduateStudent(Student):
    def __init__(self , name , student_id , email , age , department , research_topic):
        super().__init__(name , student_id , email , age , department)
        self.research_topic = research_topic

    def display_info(self):
        super().display_info()
        print(f"Research Topics: {self.research_topic}")
    
    def calculate_result(self , marks):
        return super().calculate_result(marks)
    
    def get_student_type(self):
        return "Student is Graduated"


#Objects-1
u_g_s = UnderGraduateStudent(
    "Jehad Hasan",
    10,
    "jehad@example.com",
    22,
    "CSE",
    "7th"
)

#Objects-2
g_s = GraduateStudent(
    "Naminta Jerin",
    15,
    "naminta@example.com",
    21,
    "Human Resources",
    "Human Basic Needs"
)

#Print Informations
print("<-----Under Graduate Student----->")
u_g_s.display_info()
print(f"Results: {u_g_s.calculate_result(85)}")
print(f"Type: {u_g_s.get_student_type()}\n")

print("<-----Graduate Student----->")
g_s.display_info()
print(f"Results: {g_s.calculate_result(95)}")
print(f"Type: {g_s.get_student_type()}")