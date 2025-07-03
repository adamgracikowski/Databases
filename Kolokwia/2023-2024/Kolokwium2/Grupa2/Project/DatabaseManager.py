import configparser
import pymssql # type: ignore
from datetime import datetime, timedelta
import random

class DatabaseManager():
    def __init__(self, config_file):
        self.config_file = config_file
        self.connection = None
        self.cursor = None

    def __enter__(self):
        parser = configparser.ConfigParser()
        parser.read(self.config_file)
        config = parser['mssqlDB']

        try:
            self.connection = pymssql.connect(
                user=config.get('user'),
                password=config.get('pass'),
                server=config.get('server'),
                database=config.get('db')
            )
            print("Connection estabilished successfully.")
            self.cursor = self.connection.cursor()
            print("Cursor created succesfully.")
            return self
        except pymssql.Error as e:
            print(f"Error connecting to the database: {e}")
            raise
    
    def __exit__(self, exc_type, exc_value, traceback):
        if self.cursor:
            self.cursor.close()
            print("Cursor closed.")
        if self.connection:
            self.connection.close()
            print("Connection closed.")

    def display_table(self, table_name):
        query = '''select * from %s'''
        self.cursor.execute(query % table_name)
        rows = self.cursor.fetchall()
        for row in rows:
            print(row)

    def execute_A(self):
        print("Task A)")
        query = self.truncate_query
        self.cursor.execute(query)
        self.connection.commit()
        print("Invoices after task A):")
        self.display_table("Invoices")

    def execute_B(self):
        print("Task B)")        
        netto = [100, 200, 300]
        invoices = self.create_invoices(len(netto), netto)
        query = self.insert_query
        print(f"{len(invoices)} new invoices inserted successfully.")
        self.cursor.executemany(query, invoices)
        self.connection.commit()
        self.display_table("Invoices")

    def execute_C(self):
        print("Task C)")
        query = '''
            update Invoices
            set Brutto = 2 * Brutto
        '''
        self.cursor.execute(query)
        print("Brutto values have been updated.")
        
        invoices = self.create_invoices(1, [1000 / 1.23])
        query = self.insert_query    
        self.cursor.executemany(query, invoices)
        self.connection.commit()
        
        print("New invoice has been inserted.")
        print("Invoices after task C):")
        self.display_table("Invoices")

    def execute_D(self):
        print("Task D)")
        invoices = self.create_invoices(10, [None] * 10)
        query = self.insert_query
        self.cursor.executemany(query, invoices)
        print(f"{len(invoices)} new invoices have been inserted successfully.")
        print("Invoices after first commit of task D):")
        self.display_table("Invoices")
        
        query = self.min_max_query
        self.cursor.execute(query)
        min_brutto, max_brutto = self.cursor.fetchone()

        if min_brutto and max_brutto:
            new_brutto = random.randint(1000, 2000)
            query = f'''
                update Invoices set Brutto = {new_brutto} where Brutto in ({max_brutto}, {min_brutto})
            '''
            self.cursor.execute(query)      
            self.connection.commit()
            print("Invoices with minimal and maximal brutto have been modified.")
            print("Invoices after second commit of task D):")
            self.display_table("Invoices")
        else:
            print("No modification needed, as no invoices were found.")
          
    def create_invoices(self, n, netto):
        return [self.create_invoice(netto[i]) for i in range(n)]          
            
    def create_invoice(self, netto = None):
        if netto is None:
            netto = random.randint(1, 1000)
        brutto = 1.23 * netto
        account = f"Account_{str(random.randint(1, 100))}"
        return [netto, brutto, account]
        
    insert_query = '''
        insert into Invoices
        values (%s, %s, %s)    
    '''
    truncate_query = '''
        truncate table Invoices
    '''
    min_max_query = '''
        select min(Brutto), max(Brutto) from Invoices
    '''