import sqlite3

mydb = sqlite3.connect(
    'orderPick.db'
##    host="localhost",
##    user="root",
##    password="CS470"
)
cursor = mydb.cursor()

def exeFileScript(filename):
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')
    for command in sqlCommands:
        try:
            if command.strip() != '':
                cursor.execute(command)
        except IOError as msg:
            print("Command skipped: ", msg)

##exeFileScript('C:\\Users\\emily\\Desktop\\orderPick_ddl_dml_sqlite.sql')
##mydb.commit()

#Welcome
device_name = 'T100'
print("Welcome\nDevice %s" %(device_name))
while True:
    #validate user input matches required length
    employee_input = input("Enter Employee ID: ")
    try:
        employee_val = int(employee_input)
        if 999999 < employee_val < 10000000:
            pass
        else:
            raise ValueError
    except ValueError:
        print("Error: Employee_ID must be 7-digit number. Please try again.")
    else:
        #update employee_assigned_device if not already found
        found = cursor.execute("SELECT COUNT(1) FROM employee_assigned_device \
                                WHERE employee_id = '%d'" %employee_val)
        for x in found:
            if x[0] != 0:
                print("Error: This Employee_ID is already associated with \
                      another device. Please log off other device and try again.")
                continue
            else:
                break
        cursor.execute("INSERT INTO employee_assigned_device VALUES \
                       ('%s','%d')" %(device_name, employee_val))
        #device is updated to checked out
        cursor.execute("UPDATE device SET checked_out = 1 WHERE device_id = '%s'" \
                       %device_name)
        break

#Sled Selection
print("Sled Selection")
while True:
    #validate
