import mysql.connector


def create_account(username, password):
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        # Check if username already exists
        query_check = f"SELECT * FROM user WHERE username = '{username}'"
        cursor.execute(query_check)
        existing_user = cursor.fetchone()

        if existing_user:
            print("Username already exists.")
            return 1  # Username already exists

        # Get the next available ID
        query_max_id = "SELECT MAX(id) FROM user"
        cursor.execute(query_max_id)
        max_id = cursor.fetchone()[0]

        # Insert the new user
        new_id = max_id + 1 if max_id else 1
        query_insert = f"INSERT INTO user (id, username, password) VALUES ({new_id}, '{username}', '{password}')"
        cursor.execute(query_insert)
        connection.commit()

        # Close cursor and connection
        cursor.close()
        connection.close()

        print("Account created successfully.")
        return 0  # Account created successfully

    except mysql.connector.Error as error:
        print(f"Error: {error}")
        return 2
def check_credentials(username, password):
    try:
        connection = mysql.connector.connect(
               user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        query = f"SELECT * FROM user WHERE username = '{username}' AND password = '{password}'"
        cursor.execute(query)

        # Check if there is a match
        match = cursor.fetchone() is not None

        # Close cursor and connection
        cursor.close()
        connection.close()

        return 0 if match else 1

    except mysql.connector.Error as error:
        print(f"Error: {error}")
        return 1






def select_parking_location():
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        query = f"SELECT denumire, location FROM parcare"

        cursor.execute(query)

        # Obține toate rândurile din rezultate
        rows = cursor.fetchall()

        # Închide cursorul și conexiunea
        cursor.close()
        connection.close()

        return rows

    except mysql.connector.Error as error:
        print(f"Eroare: {error}")
        return None
    
import mysql.connector

def select_parking_name():
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        query = f"SELECT denumire FROM parcare"

        cursor.execute(query)

        # Obține toate rândurile din rezultate
        rows = cursor.fetchall()

        # Închide cursorul și conexiunea
        cursor.close()
        connection.close()

        return rows

    except mysql.connector.Error as error:
        print(f"Eroare: {error}")
        return None

def select_parking_price():
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        query = f"SELECT denumire, location, pret FROM parcare"

        cursor.execute(query)

        # Obține toate rândurile din rezultate
        rows = cursor.fetchall()

        # Închide cursorul și conexiunea
        cursor.close()
        connection.close()

        return rows

    except mysql.connector.Error as error:
        print(f"Eroare: {error}")
        return None



def get_parcari():
    # Exemplu de utilizare
    result = select_parking_location()
    address = []
    if result:

        for row in result:
            address1 = ""
            address1 = address1 + row[1] + ", " + row[0]
            address.append(address1)
    return address

def get_adresa_pret_minim():
    # Exemplu de utilizare
    result = select_parking_price()
    address =""
    minim = float('inf')
    if result:

        for row in result:
            if row[2]<minim:
                minim=row[2]
                address1 = ""
                address1 = address1 + row[1] + ", " + row[0]
                address=address1
    return address

import mysql.connector

def urmarire_locuri_parcare():
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        query = "SELECT denumire, location , nr_locuri_libere, nr_locuri_ocupate, nr_locuri_rezervate FROM parcare"

        cursor.execute(query)

        # Fetch all rows from the result
        rows = cursor.fetchall()

        # Close the cursor and connection
        cursor.close()
        connection.close()

        return rows
    except mysql.connector.Error as error:
        print(f"Error: {error}")
        return None
    
def get_parking_id(name):
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'  # Replace with your actual database name
        )

        cursor = connection.cursor()

        query = "SELECT id FROM parcare WHERE denumire = %s"
        values = (name,)

        cursor.execute(query, values)

        # Fetch the user ID
        user_id = cursor.fetchone()

        # Close the cursor and connection
        cursor.close()
        connection.close()

        return user_id[0] if user_id else None

    except mysql.connector.Error as error:
        print(f"Error: {error}")
        return None

def get_user_id(username):
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'  # Replace with your actual database name
        )

        cursor = connection.cursor()

        query = "SELECT id FROM user WHERE username = %s"
        values = (username,)

        cursor.execute(query, values)

        # Fetch the user ID
        user_id = cursor.fetchone()

        # Close the cursor and connection
        cursor.close()
        connection.close()

        return user_id[0] if user_id else None

    except mysql.connector.Error as error:
        print(f"Error: {error}")
        return None

def get_rezervari_for_client(idclient):
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        # Select the necessary columns from the "parcare" table
        query = f"SELECT rezervare.idrezervare, parcare.denumire, parcare.location, parcare.pret " \
                f"FROM rezervare " \
                f"JOIN parcare ON rezervare.idparcare = parcare.id " \
                f"WHERE rezervare.idclient = {idclient}"

        cursor.execute(query)

        # Fetch all the rows from the result
        rows = cursor.fetchall()

        # Close the cursor and connection
        cursor.close()
        connection.close()

        return rows

    except mysql.connector.Error as error:
        print(f"Eroare: {error}")
        return None

def get_available_parkings():
    
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        # Select the necessary columns from the "parcare" table
        query = "SELECT id,denumire FROM parcare where nr_locuri_libere>0"

        cursor.execute(query)

        # Fetch all the rows from the result
        rows = cursor.fetchall()

        # Close the cursor and connection
        cursor.close()
        connection.close()

        return rows

    except mysql.connector.Error as error:
        print(f"Eroare: {error}")
        return None


    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        # Select the id of the parking based on its name
        query = f"SELECT id FROM parcare WHERE denumire = '{parking_name}'"

        cursor.execute(query)

        # Fetch the result
        result = cursor.fetchone()

        # Close the cursor and connection
        cursor.close()
        connection.close()

        if result:
            return result[0]  # Return the id if the parking is found
        else:
            print(f"Parking with name '{parking_name}' not found.")
            return None

    except mysql.connector.Error as error:
        print(f"Eroare: {error}")
        return None
import mysql.connector

def add_reservation(user_id, parking_id):
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        # Select the max existing idrezervare and increment it by 1
        cursor.execute("SELECT MAX(idrezervare) FROM rezervare")
        max_reservation_id = cursor.fetchone()[0]
        new_reservation_id = max_reservation_id + 1 if max_reservation_id else 1

        # Insert the new reservation into the rezervare table
        query = f"INSERT INTO rezervare (idrezervare, idclient, idparcare) VALUES ({new_reservation_id}, {user_id}, {parking_id})"
        cursor.execute(query)

        # Update the corresponding parking entry
        update_query = f"UPDATE parcare SET nr_locuri_libere = nr_locuri_libere - 1, nr_locuri_rezervate = nr_locuri_rezervate + 1 WHERE id = {parking_id}"
        cursor.execute(update_query)

        # Commit the changes
        connection.commit()

        # Close the cursor and connection
        cursor.close()
        connection.close()

        print(f"Reservation added successfully with idrezervare {new_reservation_id}. Parking updated.")

    except mysql.connector.Error as error:
        print(f"Eroare: {error}")

import mysql.connector

def cancel_reservation_db(reservation_id):
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        # Get the parking ID associated with the reservation
        cursor.execute(f"SELECT idparcare FROM rezervare WHERE idrezervare = {reservation_id}")
        parking_id = cursor.fetchone()

        if parking_id:
            # Delete the reservation
            delete_query = f"DELETE FROM rezervare WHERE idrezervare = {reservation_id}"
            cursor.execute(delete_query)

            # Update the corresponding parking entry
            update_query = f"UPDATE parcare SET nr_locuri_libere = nr_locuri_libere + 1, nr_locuri_rezervate = nr_locuri_rezervate - 1 WHERE id = {parking_id[0]}"
            cursor.execute(update_query)

            # Commit the changes
            connection.commit()

            print(f"Reservation with idrezervare {reservation_id} canceled successfully. Parking updated.")

        else:
            print(f"Reservation with idrezervare {reservation_id} not found.")

        # Close the cursor and connection
        cursor.close()
        connection.close()

    except mysql.connector.Error as error:
        print(f"Eroare: {error}")


def update_ocupare_loc_rezervat(parking_id,reservation_id):
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        # Check if the reservation belongs to the specified parking
        select_query = f"SELECT * FROM rezervare WHERE idrezervare = {reservation_id} AND idparcare = {parking_id}"
        cursor.execute(select_query)
        if not cursor.fetchone():
            print(f"The reservation with idrezervare {reservation_id} does not belong to this parking.")
            return {'success': False, 'message': f"The reservation with idrezervare {reservation_id} does not belong to this parking."}

        # Delete the reservation
        delete_query = f"DELETE FROM rezervare WHERE idrezervare = {reservation_id}"
        cursor.execute(delete_query)

        # Update the corresponding parking entry
        update_query = f"UPDATE parcare SET  nr_locuri_ocupate = nr_locuri_ocupate + 1, nr_locuri_rezervate = nr_locuri_rezervate - 1 WHERE id = {parking_id}"
        cursor.execute(update_query)

        # Commit the changes
        connection.commit()

        print(f"Reservation with idrezervare {reservation_id} canceled successfully. Parking updated.")
        return {'success': True, 'message': f"Reservation with idrezervare {reservation_id} canceled successfully. Parking updated."}

    except mysql.connector.Error as error:
        print(f"Eroare: {error}")
        return {'success': False, 'message': f"Error: {error}"}

    finally:
        # Close the cursor and connection
        cursor.close()
        connection.close()



def update_ocupare_loc_liber(parking_id):
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        # Fetch the current values of Locuri Libere and Locuri Ocupate
        query_select = f"SELECT nr_locuri_libere, nr_locuri_ocupate FROM parcare WHERE id = {parking_id}"
        cursor.execute(query_select)
        current_values = cursor.fetchone()

        if current_values:
            locuri_libere = current_values[0]
            locuri_ocupate = current_values[1]

            # Update Locuri Libere and Locuri Ocupate
            if locuri_libere > 0:
                locuri_libere -= 1
                locuri_ocupate += 1

                # Update the database
                query_update = f"UPDATE parcare SET nr_locuri_libere = {locuri_libere}, nr_locuri_ocupate = {locuri_ocupate} WHERE id = {parking_id}"
                cursor.execute(query_update)
                connection.commit()

                return {'success': True, 'message': f'Updated Locuri Libere and Locuri Ocupate for parking with ID {parking_id}'}
            else:
                return {'success': False, 'error': 'No available parking spaces.'}
        else:
            return {'success': False, 'error': f'Parking with ID {parking_id} not found.'}

    except mysql.connector.Error as error:
        return {'success': False, 'error': f'Error: {error}'}

    finally:
        # Close cursor and connection
        if cursor:
            cursor.close()
        if connection:
            connection.close()

def update_paraseste_parcare(parking_id):
    try:
        connection = mysql.connector.connect(
            user='root',
            password='root1234',
            host='localhost',
            database='proiectis'
        )

        cursor = connection.cursor()

        # Fetch the current values of Locuri Libere and Locuri Ocupate
        query_select = f"SELECT nr_locuri_libere, nr_locuri_ocupate,nr_total_locuri FROM parcare WHERE id = {parking_id}"
        cursor.execute(query_select)
        current_values = cursor.fetchone()

        if current_values:
            locuri_libere = current_values[0]
            locuri_ocupate = current_values[1]
        
            # Update Locuri Libere and Locuri Ocupate
            if locuri_ocupate>0:
                locuri_libere += 1
                locuri_ocupate -= 1

                # Update the database
                query_update = f"UPDATE parcare SET nr_locuri_libere = {locuri_libere}, nr_locuri_ocupate = {locuri_ocupate} WHERE id = {parking_id}"
                cursor.execute(query_update)
                connection.commit()

                return {'success': True, 'message': f'Updated Locuri Libere and Locuri Ocupate for parking with ID {parking_id}'}
            else:
                return {'success': False, 'error': 'The parking is empty.'}
        else:
            return {'success': False, 'error': f'Parking with ID {parking_id} not found.'}

    except mysql.connector.Error as error:
        return {'success': False, 'error': f'Error: {error}'}

    finally:
        # Close cursor and connection
        if cursor:
            cursor.close()
        if connection:
            connection.close()




