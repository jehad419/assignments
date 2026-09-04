#Taking input of customer name
customer_name = str(input("Customer Name: "))

#Taking product and price
product_1 = str(input("Product: "))
price_1 = int(input("Price: "))
product_2 = str(input("Product: "))
price_2 = int(input("Price: "))
product_3 = str(input("Product: "))
price_3 = int(input("Price: "))


#Subtotal
subtotal = price_1 = price_2 + price_3

#Determine discounts
def discount():
    if subtotal >= 5000:
        discount = subtotal * 20 / 100
        return discount
    
    elif 4999 >= subtotal >= 3000:
        discount = subtotal * 10 / 100
        return discount

    elif 2999 >= subtotal >= 1000:
        discount = subtotal * 5 / 100
        return discount
    else:
        discount = 0
        return discount
    
final_discount = discount()

final_total = subtotal - final_discount

#Displaying results
print(f"Customer Name: {customer_name} \n Subtotal: {subtotal} \n Discount: {final_discount} \n Final Total: {final_total}")