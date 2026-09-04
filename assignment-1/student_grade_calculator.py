#Taking input of students name
student_name = str(input("Enter student's name: "))

#Taking input of students marks
english_marks = int(input("Enter English Marks: "))
bangla_marks = int(input("Enter Bangla Marks: "))
math_marks = int(input("Enter Math Marks: "))

#Total marks
total_marks = english_marks + bangla_marks + math_marks

#Avegrage marks
average_marks = (total_marks)/3

#Determines the grade
def grade():
    if 100 >= average_marks >= 80:
        return "A+"
    elif 79 >= average_marks >= 70:
        return "A"
    elif 69 >= average_marks >= 60:
        return "B"
    elif 59 >= average_marks >= 50:
        return "C"
    else:
        return "F"

final_grade = grade()

#Displaying results
print(f"Student Name: {student_name} \n Total Marks: {total_marks} \n Average: {average_marks} \n Grade: {final_grade} ")
    
    


