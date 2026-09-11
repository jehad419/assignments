#Taking Input of Name
name = str(input("Enter your Name : "))

#Writing the name into name.txt
with open("name.txt","w") as file:
    file.write(name)
    print("Name Saved Successfully")