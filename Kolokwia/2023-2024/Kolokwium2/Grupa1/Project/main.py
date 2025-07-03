from DatabaseManager import DatabaseManager

if __name__ == '__main__':
    config_file = "cnf.ini"
    with DatabaseManager(config_file) as manager:
        manager.execute_A()
        manager.execute_B()
        manager.execute_C()
        manager.execute_D()