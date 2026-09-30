import json


student = {
    "name": "Rahim",
    "age": 20,
    "department": "CSE"
}

result = json.dumps(student)

print(result)
