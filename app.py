from tkinter.constants import BOTTOM
from mysql import connector
import mysql.connector
from mysql.connector import Error
import tkinter as tk
from tkinter import PhotoImage, StringVar, Variable, messagebox
import datetime
import random

from mysql.connector.errorcode import CR_NULL_POINTER

entries = []
second_entries=[]
entriesDict = {}
attributes=["First Name:","Last Name:","Phone:","Email:","Check-in Date:","Check-out Date:","Number of people:","Equipment:"]
second_attr=["Camping Key:","Position:"]

def menuGuiTk():
    root = tk.Tk()
    root.title("Camping Database")
    root.geometry("400x100")
    title = tk.Label(root,text="Choose:",font=("Arial",24))
    title.pack()

    def quitRoot():
        root.destroy()

    grid_menu_frame = tk.Frame(root)

    buttonAddBooking = tk.Button(grid_menu_frame, text="Make Booking", command=addBookingResponse)
    buttonAddBooking.grid(row=0, column=0, pady=(20, 0), padx=(0, 10))

    buttonShowData = tk.Button(grid_menu_frame, text="Show Existing Data", command=showDataResponse)
    buttonShowData.grid(row=0, column=1, pady=(20, 0), padx=(10, 0))

    grid_menu_frame.pack(side="top",anchor="center")
    root.mainloop()

def addBookingResponse():
    guitk()

def showDataResponse():
    showDataGuiTk()

def showDataGuiTk():
    data = tk.Tk()
    data.title("Camping database")
    data.geometry("400x100")

    title=tk.Label(data, text="Data to show:",font=("Arial",24))
    title.pack()

    grid_data_frame = tk.Frame(data)

    buttonAddBooking = tk.Button(grid_data_frame, text="Customers", command=showCustomers)
    buttonAddBooking.grid(row=0, column=0, pady=(20, 0), padx=(0, 10))

    buttonShowData = tk.Button(grid_data_frame, text="Bookings", command=showBookings)
    buttonShowData.grid(row=0, column=1, pady=(20, 0), padx=(10, 0))

    grid_data_frame.pack(side="top",anchor="center")
    data.mainloop()

def showCustomers():
    customers = tk.Tk()
    customers.title("Camping database")
    labels=["First Name","Last Name","Phone","Email","Camping Key"]

    title=tk.Label(customers, text="Customers:",font=("Arial",24))
    title.pack()

    grid_customers_frame = tk.Frame(customers)

    cursor.execute("SELECT fname, lname, phoneNumber, email, campingKey FROM customer;")
    result = cursor.fetchall()
    for i in range(len(labels)):
        data_label = tk.Label(grid_customers_frame,text="{}".format(labels[i]),font=("Arial",14))
        data_label.grid(row=0, column=i)

    for i in range(len(result)):
        for j in range(len(result[i])):
            data_label = tk.Label(grid_customers_frame,text="{}".format(result[i][j]),font=("Arial",14))
            data_label.grid(row=i+1, column=j)

    grid_customers_frame.pack(side="top",anchor="center")
    customers.mainloop()

def showBookings():
    bookings = tk.Tk()
    bookings.title("Camping database")
    labels=["First Name","Last Name","Check-in Date","Check-out Date","Number of people","Equipment"]

    title=tk.Label(bookings, text="Bookings:",font=("Arial",24))
    title.pack()

    grid_bookings_frame = tk.Frame(bookings)

    cursor.execute("SELECT fname, lname, arrival_date, departure_date, num_of_people, equipment.name FROM customer,visit,equipment,connected WHERE customer.id = visit.id_customer AND visit.id = connected.id_visit AND connected.id_equipment = equipment.id ORDER BY lname;")
    result = cursor.fetchall()
    for i in range(len(labels)):
        data_label = tk.Label(grid_bookings_frame,text="{}".format(labels[i]),font=("Arial",14))
        data_label.grid(row=0, column=i)
        
    for i in range(len(result)):
        for j in range(len(result[i])):
            data_label = tk.Label(grid_bookings_frame,text="{}".format(result[i][j]),font=("Arial",14))
            data_label.grid(row=i+1, column=j)

    grid_bookings_frame.pack(side="top",anchor="center")
    bookings.mainloop()


def guitk():

    window = tk.Tk()
    window.title("Camping database")
    window.geometry("500x475")

    filename = tk.PhotoImage(master=window, file="camp.png")
    bg=tk.Label(window,image = filename)    
    bg.place(x=0,y=0,relwidth=1,relheight=1)


    def quit():
        window.destroy()

    title=tk.Label(window,text="Camp Booking",font=("Arial",24), bg= "#E38876")
    title.pack()

    grid_frame=tk.Frame(window, bg="#E38876") 


    for i in range(len(attributes)):
        for j in range(2):
            if (j==0):
                first_label=tk.Label(grid_frame,text="{}".format(attributes[i]),font=("Arial",14), bg="#E38876")
                first_label.grid(row=i,column=j, padx=(50,5), pady=5, sticky="e")
            else:
                second_label=tk.Entry(grid_frame, bg="white")
                second_label.grid(row=i,column=j, padx=(5,50), pady=5, sticky="w")
                entries.append(second_label)

    first_label=tk.Label(grid_frame,text="Camping Key:",font=("Arial",14), bg="#E38876")
    first_label.grid(row=8,column=0, padx=(50,5), pady=5, sticky="e")
    
    var1=StringVar(grid_frame)
    var1.set('')
    values=['Yes','No']
    w=tk.OptionMenu(grid_frame,var1,*values,command=callback)
    w.grid(row=8,column=1,padx=(50,5),pady=5,sticky="w")
    

    var2=StringVar(grid_frame)
    var2.set('')
    values=['Campsite Spot','Room']
    first_label=tk.Label(grid_frame,text="Position:",font=("Arial",14), bg="#E38876")
    first_label.grid(row=9,column=0, padx=(50,5), pady=5, sticky="e")
    w=tk.OptionMenu(grid_frame,var2,*values,command=callback)
    w.grid(row=9,column=1,padx=(50,5),pady=5,sticky="w")
    


    button = tk.Button(window, text="Add Booking", command=getResponse)
    button.pack(side="bottom", pady=(0,10))
    grid_frame.pack(side="top",anchor="center")
    window.mainloop()

def addBooking():
    return messagebox.showinfo("Booking Complete", "Booking was successful!")


def callback(var):
    second_entries.append(var)


def getData():
    i = 0
    for entry in entries:
        entriesDict[attributes[i]] = entry.get()
        i += 1
    i=0
    for entry in second_entries:
        entriesDict[second_attr[i]] = entry
        i += 1
    if (entriesDict["Camping Key:"] == "No"):
        entriesDict["Camping Key:"] = False
    else:
        entriesDict["Camping Key:"] = True
    entriesDict["Number of people:"] = int(entriesDict["Number of people:"])

def getResponse():
    getData()
    addData()
    addBooking()

def computePrice(equipmentPrice, numOfDays, peoplePrice):
    total = 0
    for price in equipmentPrice:
        total += price
    return (total + peoplePrice)*numOfDays

def allPositions():
    cursor.execute("SELECT id FROM campPosition;")
    result = [x[0] for x in cursor.fetchall()]

    if (entriesDict["Position:"]=="campsite"):
        position=result[random.randint(1,30)]
    else:
        position=result[random.randint(31,len(result))]
        

    return position


def addData():
    if connection.is_connected():
        req = "INSERT INTO customer(fname, lname, phoneNumber, email, campingKey) VALUES ('{}','{}','{}','{}',{});".format(entriesDict["First Name:"],
            entriesDict["Last Name:"],
            entriesDict["Phone:"],
            entriesDict["Email:"],
            entriesDict["Camping Key:"])
        cursor.execute(req)

        cursor.execute("SELECT id FROM customer WHERE fname = '{}' AND lname = '{}' AND phoneNumber='{}';".format(entriesDict["First Name:"], entriesDict["Last Name:"], entriesDict["Phone:"]))
        customerId = cursor.fetchall()
        for i in customerId:
            customerId = i[0]

        startDate = [int(x) for x in entriesDict["Check-in Date:"].split("-")]
        startDate = datetime.date(startDate[0], startDate[1], startDate[2])
        endDate = [int(x) for x in entriesDict["Check-out Date:"].split("-")]
        endDate = datetime.date(endDate[0], endDate[1], endDate[2])
        daysNumber = endDate - startDate
        numOfDays = daysNumber.days

        equipmentPrice = []
        equipmentId = []
        equipmentName = [x.strip(" ") for x in entriesDict["Equipment:"].split(",")]
        for name in equipmentName:
            cursor.execute("SELECT id, low_period_price, high_period_price FROM equipment WHERE name = '{}';".format(name))
            equipmentInfo = cursor.fetchall()
            equipmentId.append(equipmentInfo[0][0])
            if (endDate.month == 7 or endDate.month == 8):
                equipmentPrice.append(equipmentInfo[0][2])
                peoplePrice = entriesDict["Number of people:"]*7
            else:
                equipmentPrice.append(equipmentInfo[0][1])
                peoplePrice = entriesDict["Number of people:"]*5

        price = computePrice(equipmentPrice, numOfDays, peoplePrice)
        discountId = random.randint(1,20)

        req = "INSERT INTO payment(paymentDate, price, customerId, discountId) VALUES ('{}',{},{},{});".format(
            entriesDict["Check-out Date:"],
            price,
            customerId,
            discountId
        )
        cursor.execute(req)

        cursor.execute("SELECT id FROM payment WHERE customerId = {};".format(customerId))
        paymentId = cursor.fetchone()
        paymentId = paymentId[0]
        position=allPositions()

        req = "INSERT INTO visit(cancel, arrival_date, departure_date, num_of_people, id_discount, id_payment, id_customer, id_position) VALUES ({},'{}','{}',{},{},{},{},'{}');".format(
            False,
            entriesDict["Check-in Date:"],
            entriesDict["Check-out Date:"],
            entriesDict["Number of people:"],
            discountId,
            paymentId,
            customerId,
            position)
        cursor.execute(req)

        cursor.execute("SELECT id FROM visit WHERE id_customer = {};".format(customerId))
        visitId = cursor.fetchone()
        visitId = visitId[0]

        for id in equipmentId:
            cursor.execute("INSERT INTO connected (id_equipment, id_visit) VALUES ('{}',{})".format(id, visitId))
            cursor.execute("INSERT INTO associated_with (equipmentId ,paymentId) VALUES ('{}',{})".format(id, paymentId))
        
        connection.commit()


if __name__ == "__main__":
    try:
        connection = mysql.connector.connect(host='localhost',
                                            database='camping_database',
                                            user='root',
                                            password='12345')
        cursor = connection.cursor(buffered=True)
        if connection.is_connected():
            menuGuiTk()

    except Error as e:
        print("Error while connecting to MySQL", e)

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection is closed")