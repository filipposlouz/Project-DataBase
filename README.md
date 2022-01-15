# Project-DataBase

Installing MySQL-Connector:
pip install mysql-connector-python

Installing Tkinter:
pip install tk

Installing MySQL:
https://youtu.be/OM4aZJW_Ojs

Παραδείγματα χρήσης της εφαρμογής:
  Tο όνομα και η ημερομηνία όλων των κρατήσεων που δεν ακυρώθηκαν.
    SELECT fname,lname,arrival_date,departure_date
    FROM camping_database.visit as vi, camping_database.customer as cu
    WHERE vi.id_customer=cu.id and cancel='0';
    
    ![image](https://user-images.githubusercontent.com/63556263/149604976-680a8de0-0213-4d02-964f-49e211e2f1f8.png)
    
  Το όνομα του πελάτη και του εξοπλισμού που θα έχει στο camping.
    SELECT fname,lname,name
    FROM camping_database.customer as cu,camping_database.visit as vi, camping_database.connected as con, camping_database.equipment as eq
    WHERE cu.id=vi.id_customer and vi.id=con.id_visit and con.id_equipment=eq.id ORDER BY lname,fname;
    
    ![image](https://user-images.githubusercontent.com/63556263/149604992-5c7c2b8b-b462-4ed4-b725-9239257ab11b.png)
    
  Το ποσό που πλήρωσε ο κάθε πελάτης και το τελικό ποσό μαζί με την έκπτωση.
    SELECT pa.customerId, pa.price,(pa.price - pa.price* CAST(di.discountPrice as float)/100) as Total_price
    FROM camping_database.payment as pa,camping_database.discount as di,camping_database.visit as vi
    WHERE pa.discountId=di.id and vi.id_customer=pa.customerId and vi.cancel='0' ORDER BY pa.customerId;
    
    ![image](https://user-images.githubusercontent.com/63556263/149605019-1a660f2e-8763-492d-beee-2d72006fb689.png)

  Το όνομα των πελατών και την κριτική τους.
    SELECT cu.fname,cu.lname,fe.feedback
    FROM camping_database.customer as cu,camping_database.feedback as fe, camping_database.visit as vi
    WHERE vi.id_customer=cu.id and fe.id_visit=vi.id ORDER BY cu.lname,cu.fname;
    
    ![image](https://user-images.githubusercontent.com/63556263/149605028-980827c7-6406-4d55-b935-ac8a2f295005.png)

  Το ονοματεπώνυμο, τις ημερομηνίες άφιξης και αναχώρησης, τον αριθμό ατόμων, την θέση και τις γειτονικές τους
    SELECT fname, lname, arrival_date, departure_date, num_of_people, campPosition.id AS camping_spot, adjacent_to
    FROM visit, customer, campPosition
    WHERE visit.id_customer = customer.id AND visit.id_position = campPosition.id;
    
    ![image](https://user-images.githubusercontent.com/63556263/149605034-45222bc8-99d9-4527-bd6b-dd3c5e312013.png)
