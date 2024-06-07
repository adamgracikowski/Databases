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
        query = self.delete_query
        self.cursor.execute(query)
        self.connection.commit()
        print("Inactive participants have been deleted.")
        print("Participants after task A):")
        self.display_table("Participants")

    def execute_B(self):
        print("Task B)")
        participants = self.create_participants(3)
        query = self.insert_query
        self.cursor.executemany(query, participants)
        self.connection.commit()
        print(f"3 new participants have been inserted.")
        print("Participants after task B):")
        self.display_table("Participants")

    def execute_C(self):
        print("Task C)")
        query = '''
            update Participants
            set PointsPerCompetition = (TotalPoints + 5.5) / TotalAmountOfCompetitions,
                TotalPoints = TotalPoints + 5.5
        '''
        self.cursor.execute(query)
        self.connection.commit()
        print("TotalPoints has been updated.")
        print("Participants after first commit of task C):")
        self.display_table("Participants")
        
        query = self.insert_query

        participant = self.create_participant()
        participant[7] = 1
        participant[8] = 100.1
        participant[9] = participant[8] / participant[7]
                
        self.cursor.execute(query, participant)
        self.connection.commit()
        print("Participant has been inserted.")
        print("Participants after second commit of task C):")
        self.display_table("Participants")

    def execute_D(self):
        print("Task D)")
        participant = self.create_participants(4)
        query = self.insert_query
        self.cursor.executemany(query, participant)
        self.connection.commit()
        print("4 new participants have been added successfully.")
        print("Participants after first commit of task D):")
        self.display_table("Participants")
        
        query = self.min_max_query
        self.cursor.execute(query)
        min_date, max_date = self.cursor.fetchone()

        if min_date and max_date and min_date != max_date:
            min_date, max_date = min_date.strftime('%Y-%m-%d'), max_date.strftime('%Y-%m-%d')
            query = f'''
                update Participants set JoinDate = {min_date} where IsActive = 0 and JoinDate = {max_date}
            '''
            self.cursor.execute(query)
            query = f'''
                update Participants set JoinDate = {max_date} where IsActive = 0 and JoinDate = {min_date}
            '''
            self.cursor.execute(query)        
            self.connection.commit()
            print("JoinDate for inactive users swapped successfully.")
            print("Participants after second commit of task D):")
            self.display_table("Participants")
        else:
            print("No swap needed, as min_date and max_date are the same or no inactive users found.")
          
    def create_participants(self, n):
        return [self.create_participant() for _ in range(n)]          
            
    def create_participant(self):
        email = f"participant_{random.randint(1, 1000)}@example.com"
        birthday_date = (datetime.now() - \
            timedelta(days=random.randint(365*18, 365*80))).strftime('%Y-%m-%d')
        is_active = random.choice([0, 1])
        name = f"name_{random.randint(1, 1000)}"
        surname = f"surname_{random.randint(1, 1000)}"
        fee = round(random.uniform(1, 1000), 2)
        join_date = (datetime.now() - \
            timedelta(days=random.randint(1, 365))).strftime('%Y-%m-%d %H:%M:%S')
        total_competitions = random.randint(1, 10)
        total_points = round(random.uniform(100, 10000), 2)
        points_per_competition = total_points / total_competitions
        return [email, birthday_date, is_active, name, surname, fee, join_date, 
                total_competitions, total_points, points_per_competition]
        
    insert_query = """
        insert into participants (
            Email, 
            BirthdayDate, 
            IsActive, 
            Name, 
            Surname, 
            OrganizationalFee, 
            JoinDate, 
            TotalAmountOfCompetitions, 
            TotalPoints, 
            PointsPerCompetition
        )
        values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    delete_query = '''
        delete from Participants
        where IsActive = 0 
            and JoinDate = (
                select min(JoinDate) 
                from Participants
                where IsActive = 0
            )
    '''
    min_max_query = '''
        select min(JoinDate), max(JoinDate) from Participants where IsActive = 0
    '''