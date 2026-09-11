#  Ask the user to enter their name.
# ● Open a file named name.txt.
# ● Write the name into the file.
# ● Close the file

name = str(input("Enter your Name : "))
with open("name.txt","w") as file:
    file.write(name)
    print("Name Saved Successfully")