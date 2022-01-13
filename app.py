from tkinter.constants import BOTTOM
import mysql.connector
from mysql.connector import Error
import tkinter as tk
from tkinter import StringVar, messagebox
import datetime
import random
from mysql.connector.errorcode import CR_NULL_POINTER

# Creation of required datatypes
entries = []
second_entries=[]
entriesDict = {}
# Creation of required labels
attributes=["First Name:","Last Name:","Phone:","Email:","Check-in Date:","Check-out Date:","Number of people:","Equipment:"]
second_attr=["Camping Key:","Position:"]

# Main Menu Window / Opens first
def menuGuiTk():
    # Create tkinter instance
    root = tk.Tk()
    # Set window title
    root.title("Camping Database")
    # Set window size
    root.geometry("400x100")
    # Set Label and pack it in the window
    title = tk.Label(root,text="Choose:",font=("Arial",24))
    title.pack()

    # Create Menu Frame
    grid_menu_frame = tk.Frame(root)

    # Add button for Booking that calls the function inside of it and pack it
    buttonAddBooking = tk.Button(grid_menu_frame, text="Make Booking", command=addBookingResponse)
    buttonAddBooking.grid(row=0, column=0, pady=(20, 0), padx=(0, 10))

    # Add button for Data that calls the function inside of it and pack it
    buttonShowData = tk.Button(grid_menu_frame, text="Show Existing Data", command=showDataResponse)
    buttonShowData.grid(row=0, column=1, pady=(20, 0), padx=(10, 0))

    # Pack the Menu Frame
    grid_menu_frame.pack(side="top",anchor="center")
    root.mainloop()

# Booking Respose from button in line 35
def addBookingResponse():
    # Call function
    guitk()

# Data Repsonse from button in line 39
def showDataResponse():
    # Call function
    showDataGuiTk()

# Show Data function that is called from line 54
def showDataGuiTk():
    # Create tkinter instance
    data = tk.Tk()
    # Set window title
    data.title("Camping database")
    # Set window size
    data.geometry("400x100")

    # Create label and pack it
    title=tk.Label(data, text="Data to show:",font=("Arial",24))
    title.pack()

    # Create Data Frame
    grid_data_frame = tk.Frame(data)

    # Create button for Customers that calls the function inside of it and pack it
    buttonAddBooking = tk.Button(grid_data_frame, text="Customers", command=showCustomers)
    buttonAddBooking.grid(row=0, column=0, pady=(20, 0), padx=(0, 10))

    # Create button for Bookings that calls the function inside of it and pack it
    buttonShowData = tk.Button(grid_data_frame, text="Bookings", command=showBookings)
    buttonShowData.grid(row=0, column=1, pady=(20, 0), padx=(10, 0))

    # Pack the Data Frame
    grid_data_frame.pack(side="top",anchor="center")
    data.mainloop()

# Function to show the existing customers from the database
def showCustomers():
    # Create tkinter instance
    customers = tk.Tk()
    # Set window title
    customers.title("Camping database")
    # Set titles for window as variable
    labels=["First Name","Last Name","Phone","Email","Camping Key"]

    # Create label and pack it
    title=tk.Label(customers, text="Customers:",font=("Arial",24))
    title.pack()

    # Create Customer Frame
    grid_customers_frame = tk.Frame(customers)

    # Make database request
    cursor.execute("SELECT fname, lname, phoneNumber, email, campingKey FROM customer;")
    # Get all the data from the response
    result = cursor.fetchall()
    # For Loop for setting the titles from the labels
    for i in range(len(labels)):
        # Create the label and pack it
        data_label = tk.Label(grid_customers_frame,text="{}".format(labels[i]),font=("Arial",14))
        data_label.grid(row=0, column=i)

    # For Loop for setting the data from the database response
    for i in range(len(result)):
        for j in range(len(result[i])):
            # Create the label with data from the database response and pack it
            data_label = tk.Label(grid_customers_frame,text="{}".format(result[i][j]),font=("Arial",14))
            data_label.grid(row=i+1, column=j)

    # Pack Customer Frame
    grid_customers_frame.pack(side="top",anchor="center")
    customers.mainloop()

# Function for showing already existing Bookings from the database
def showBookings():
    # Create tkinter instance
    bookings = tk.Tk()
    # Set window title
    bookings.title("Camping database")
    # Set the labels to be used
    labels=["First Name","Last Name","Check-in Date","Check-out Date","Number of people","Equipment"]

    # Create label and pack it
    title=tk.Label(bookings, text="Bookings:",font=("Arial",24))
    title.pack()

    # Create Bookings Frame
    grid_bookings_frame = tk.Frame(bookings)

    # Make database request
    cursor.execute("SELECT fname, lname, arrival_date, departure_date, num_of_people, equipment.name FROM customer,visit,equipment,connected WHERE customer.id = visit.id_customer AND visit.id = connected.id_visit AND connected.id_equipment = equipment.id ORDER BY lname;")
    # Get all data from database response
    result = cursor.fetchall()
    # For Loop for setting the titles from labels
    for i in range(len(labels)):
        # Create label and pack it
        data_label = tk.Label(grid_bookings_frame,text="{}".format(labels[i]),font=("Arial",14))
        data_label.grid(row=0, column=i)
    
    # For Loop for setting the data from the database response
    for i in range(len(result)):
        for j in range(len(result[i])):
            # Create the label with data from the database response and pack it
            data_label = tk.Label(grid_bookings_frame,text="{}".format(result[i][j]),font=("Arial",14))
            data_label.grid(row=i+1, column=j)

    # Pack Bookings Frame
    grid_bookings_frame.pack(side="top",anchor="center")
    bookings.mainloop()

# Tkinter Function for Bookings
def guitk():
    # Create tkinter instance
    window = tk.Tk()
    # Set window title
    window.title("Camping database")
    # Set window size
    window.geometry("500x475")

    # Get Image from files
    filename = tk.PhotoImage(master=window, file="camp.png")
    # Create label for background with the image and place it
    bg=tk.Label(window,image = filename)    
    bg.place(x=0,y=0,relwidth=1,relheight=1)

    # Create label and pack it
    title=tk.Label(window,text="Camp Booking",font=("Arial",24), bg= "#E38876")
    title.pack()

    # Create Grid Frame
    grid_frame=tk.Frame(window, bg="#E38876") 

    # For Loop for creating the text fields and entry fields
    for i in range(len(attributes)):
        for j in range(2):
            if (j==0):
                # Create label for text and pack it
                first_label=tk.Label(grid_frame,text="{}".format(attributes[i]),font=("Arial",14), bg="#E38876")
                first_label.grid(row=i,column=j, padx=(50,5), pady=5, sticky="e")
            else:
                # Create Entry Fields and pack them
                second_label=tk.Entry(grid_frame, bg="white")
                second_label.grid(row=i,column=j, padx=(5,50), pady=5, sticky="w")
                entries.append(second_label)

    # Create Label and pack it
    first_label=tk.Label(grid_frame,text="Camping Key:",font=("Arial",14), bg="#E38876")
    first_label.grid(row=8,column=0, padx=(50,5), pady=5, sticky="e")
    
    # Create StringVar variable
    var1=StringVar(grid_frame)
    # Set it as empty
    var1.set('')
    # Set possible values
    values=['Yes','No']
    # Create dropdown option menu with above values and grid it
    w=tk.OptionMenu(grid_frame,var1,*values,command=callback)
    w.grid(row=8,column=1,padx=(50,5),pady=5,sticky="w")
    
    # Create StringVar variable 
    var2=StringVar(grid_frame)
    # Set it as empty
    var2.set('')
    # Set possible values
    values=['Campsite Spot','Room']
    # Create label and pack it
    first_label=tk.Label(grid_frame,text="Position:",font=("Arial",14), bg="#E38876")
    first_label.grid(row=9,column=0, padx=(50,5), pady=5, sticky="e")
    # Create dropdown option menu with above values and grid it
    w=tk.OptionMenu(grid_frame,var2,*values,command=callback)
    w.grid(row=9,column=1,padx=(50,5),pady=5,sticky="w")
    

    # Create Button for adding the booking to the database by calling getResponse function
    button = tk.Button(window, text="Add Booking", command=getResponse)
    # Pack it
    button.pack(side="bottom", pady=(0,10))
    # Pack Grid Frame
    grid_frame.pack(side="top",anchor="center")
    window.mainloop()

# Show that booking was completed
def addBooking():
    # Pop up window with text
    return messagebox.showinfo("Booking Complete", "Booking was successful!")

# Get user response to camp position and camping key
def callback(var):
    # Append values to array
    second_entries.append(var)

# Get user inputs from entry fields in tkinter
def getData():
    i = 0
    # Loop through the user entries and add them to dictionary
    for entry in entries:
        entriesDict[attributes[i]] = entry.get()
        i += 1
    i=0
    # Loop through the user entries and add them to dictionary
    for entry in second_entries:
        entriesDict[second_attr[i]] = entry
        i += 1

    # Set the user response to suitable data type
    if (entriesDict["Camping Key:"] == "No"):
        entriesDict["Camping Key:"] = False
    else:
        entriesDict["Camping Key:"] = True

    # Set the user response to suitable data type
    entriesDict["Number of people:"] = int(entriesDict["Number of people:"])

# Response to when Add Booking button is clicked
def getResponse():
    # Call following functions in order
    # Function to get user inputs
    getData()
    # Function to add user inputs to database
    addData()
    # Function for pop up window
    addBooking()

# Compute Booking Price
def computePrice(equipmentPrice, numOfDays, peoplePrice):
    total = 0
    # Check equipment price, compute final and return it
    for price in equipmentPrice:
        total += price
    return (total + peoplePrice)*numOfDays

# Get all possible camp positions
def allPositions():
    # Database request for camp positions
    cursor.execute("SELECT id FROM campPosition;")
    # Get response and change it to suitable data type
    result = [x[0] for x in cursor.fetchall()]

    # Choose a position randomly based on user choice
    if (entriesDict["Position:"]=="campsite"):
        position=result[random.randint(1,30)]
    else:
        position=result[random.randint(31,len(result))]
        
    return position

# Function which adds the booking to database
def addData():
    # Check if database is connected
    if connection.is_connected():
        # Make database request to add data to customer table
        req = "INSERT INTO customer(fname, lname, phoneNumber, email, campingKey) VALUES ('{}','{}','{}','{}',{});".format(entriesDict["First Name:"],
            entriesDict["Last Name:"],
            entriesDict["Phone:"],
            entriesDict["Email:"],
            entriesDict["Camping Key:"])
        cursor.execute(req)

        # Make database request to find the user id from the creation above
        cursor.execute("SELECT id FROM customer WHERE fname = '{}' AND lname = '{}' AND phoneNumber='{}';".format(entriesDict["First Name:"], entriesDict["Last Name:"], entriesDict["Phone:"]))
        # Get database response
        customerId = cursor.fetchall()
        # Remodel to usable data type
        for i in customerId:
            customerId = i[0]

        # Get user selected dates and remodel to usable data type
        # Split day, month, year
        startDate = [int(x) for x in entriesDict["Check-in Date:"].split("-")]
        # Set variable date
        startDate = datetime.date(startDate[0], startDate[1], startDate[2])
        # Split day, month, year
        endDate = [int(x) for x in entriesDict["Check-out Date:"].split("-")]
        # Set variable date
        endDate = datetime.date(endDate[0], endDate[1], endDate[2])
        # Compute how many days the booking will be
        daysNumber = endDate - startDate
        # Get number of days
        numOfDays = daysNumber.days

        # Set arrays to be used
        equipmentPrice = []
        equipmentId = []
        # Get the user equipment inputs and remodel to usable data type
        equipmentName = [x.strip(" ") for x in entriesDict["Equipment:"].split(",")]
        # Loop for adding the user equipment to database
        for name in equipmentName:
            # Database request to get equipment info
            cursor.execute("SELECT id, low_period_price, high_period_price FROM equipment WHERE name = '{}';".format(name))
            # Database response
            equipmentInfo = cursor.fetchall()
            equipmentId.append(equipmentInfo[0][0])
            # Check if specified dates are high season or low season
            if (endDate.month == 7 or endDate.month == 8):
                # Set suitable equipment price
                equipmentPrice.append(equipmentInfo[0][2])
                # Set suitable people per night price
                peoplePrice = entriesDict["Number of people:"]*7
            else:
                # Set suitable equipment price
                equipmentPrice.append(equipmentInfo[0][1])
                # Set suitable people per night price
                peoplePrice = entriesDict["Number of people:"]*5

        # Function to call computePrice
        price = computePrice(equipmentPrice, numOfDays, peoplePrice)
        # Pick discount id
        discountId = random.randint(1,20)

        # Database request to insert data into payment table
        req = "INSERT INTO payment(paymentDate, price, customerId, discountId) VALUES ('{}',{},{},{});".format(
            entriesDict["Check-out Date:"],
            price,
            customerId,
            discountId
        )
        cursor.execute(req)

        # Database request to retrieve id from the above creation of tuple
        cursor.execute("SELECT id FROM payment WHERE customerId = {};".format(customerId))
        # Database response
        paymentId = cursor.fetchone()
        paymentId = paymentId[0]
        # Call function to pick positions
        position=allPositions()

        # Database request to insert data into visit
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

        # Database request to get newly created visit id from above creation
        cursor.execute("SELECT id FROM visit WHERE id_customer = {};".format(customerId))
        # Database response
        visitId = cursor.fetchone()
        visitId = visitId[0]

        # Loop for adding data into below tables
        for id in equipmentId:
            cursor.execute("INSERT INTO connected (id_equipment, id_visit) VALUES ('{}',{})".format(id, visitId))
            cursor.execute("INSERT INTO associated_with (equipmentId ,paymentId) VALUES ('{}',{})".format(id, paymentId))
        
        # Commit the changes to the database
        connection.commit()


if __name__ == "__main__":
    try:
        # Create connection with database
        connection = mysql.connector.connect(host='localhost',
                                            database='camping_database',
                                            user='root',
                                            password='12345')
        # Create cursor
        cursor = connection.cursor(buffered=True)
        # Check if is connected
        if connection.is_connected():
            # Call menu tkinter
            menuGuiTk()

    # If error pops up, print it
    except Error as e:
        print("Error while connecting to MySQL", e)

    # Once finished, close database connection and cursor
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection is closed")