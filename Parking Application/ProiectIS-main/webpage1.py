from flask import Flask, jsonify, render_template, request, redirect, session, url_for,abort
from adresa_parcari import add_reservation, cancel_reservation_db, check_credentials, create_account, urmarire_locuri_parcare,get_user_id,get_rezervari_for_client,get_available_parkings
from harta import afiseaza_toate_parcarile
from Main import gaseste_cea_mai_apropiata_parcare, gaseste_cea_mai_ieftina_parcare

app = Flask(__name__, template_folder='templates')
app.config['STATIC_FOLDER'] = 'static'
app.config['SECRET_KEY'] = 'your_secret_key'

current_location = None

@app.route('/')
def home():
    return render_template('home.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        session['current_user'] = username
        # Check credentials using your Python file function
        result = check_credentials(username, password)

        if result == 0:
            # Redirect to the main app page upon successful login
            return redirect(url_for('main_app_page'))
        else:
            # Render the login page again with an error message
            error_message = "Invalid username or password. Please try again."
            return render_template('login.html', error_message=error_message)

    # Render the login page for GET requests
    return render_template('login.html')


# Add a route for the main app page
@app.route('/main_app_page')
def main_app_page():
    # Add any necessary logic for the main app page
    return render_template('main_app_page.html')  # Replace with your actual main app page template


# Add a route for the signup page
@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        username = request.form.get('signup-username')
        password = request.form.get('signup-password')

        # Use the create_account function to check if the user can be added
        result = create_account(username, password)
        
        if result == 0:
            # Account created successfully, redirect to login or main app page
            return render_template('login.html')
        elif result == 1:
            # Username already exists, show an error message
            error_message = "Username already exists. Please choose a different username."
            return render_template('signup.html', error_message=error_message)

    # Render the signup page for GET requests
    return render_template('signup.html')


@app.route('/all_parkings')
def all_parkings():


    # Call the necessary functions with the location input
    afiseaza_toate_parcarile(current_location)  # Example function call

    # Redirect to the location_map.html in the same folder
    return render_template('location_map.html')


@app.route('/cheapest_parking')
def cheapest_parking():
    

    # Call the necessary functions with the location input
    gaseste_cea_mai_ieftina_parcare(current_location)  # Example function call

    return render_template('location_map.html')


@app.route('/closest_parking')
def closest_parking():
    

    # Call the necessary functions with the location input
    gaseste_cea_mai_apropiata_parcare(current_location)  # Example function call

    return render_template('location_map.html')


@app.route('/process_location', methods=['POST'])
def process_location():
    global current_location

    # Get the location input from the AJAX request
    location_input = request.get_json().get('location')

    # Set the current location variable
    current_location = location_input
    print(current_location)
    # Perform any other logic here

    # Return a response if necessary
    result = {'success': True, 'message': f'Location received: {location_input}'}
    return jsonify(result)


@app.route('/urmarire_parcare')
def urmarire_parcare():
    # Call the function to get parking information
    parking_info = urmarire_locuri_parcare()

    # Check if there is parking information
    if parking_info is not None:
        # Convert the result to a JSON format
        parking_json = [{'Denumire': row[0], 'Locatie': row[1], 'Locuri Libere': row[2], 'Locuri Rezervate': row[4], 'Locuri Ocupate': row[3]} for row in parking_info]
        
        # Return the JSON response
        return jsonify({'success': True, 'data': parking_json})
    else:
        # Return an error response
        return jsonify({'success': False, 'error': 'Error retrieving parking information.'})
    
@app.route('/vezi_rezervare')
def vezi_rezervare():
    # Call the function to get parking information
    current_user = session.get('current_user')
    print(get_user_id(current_user))
    reservation_info = get_rezervari_for_client(get_user_id(current_user))
    print(reservation_info)

    # Check if there is parking information
    if reservation_info is not None:
        # Convert the result to a JSON format
        parking_json = [{'ID Rezervare': row[0], 'Denumire': row[1], 'Locatie': row[2], 'Pret': row[3]} for row in reservation_info]
        
        # Return the JSON response
        return jsonify({'success': True, 'data': parking_json})
    else:
        # Return an error response
        return jsonify({'success': False, 'error': 'Error retrieving reservation information.'})
    
@app.route('/available_parkings')
def available_parkings():
    # Call the function to get available parkings
    available_parkings_info = get_available_parkings()

    # Check if there are available parkings
    if available_parkings_info is not None:
        # Convert the result to a JSON format
        available_parkings_json = [{'ID Parcare': row[0], 'Denumire': row[1]} for row in available_parkings_info]

        # Return the JSON response
        return jsonify({'success': True, 'data': available_parkings_json})
    else:
        # Return an error response
        return jsonify({'success': False, 'error': 'Error retrieving available parkings.'})

@app.route('/confirm_reservation', methods=['POST'])
def confirm_reservation():
    selected_parking = request.get_json().get('selectedParking')
    current_user = session.get('current_user')
    # Perform any necessary logic with the selected parking
    # For example, store the reservation in the database
    add_reservation(get_user_id(current_user),selected_parking)
    # Return a response
    result = {'success': True, 'message': f'Reservation confirmed for {selected_parking}'}
    return jsonify(result)

@app.route('/user_reservations', methods=['GET', 'POST'])
def user_reservations():
    current_user = session.get('current_user')
    print(get_user_id(current_user))
    reservation_info = get_rezervari_for_client(get_user_id(current_user))
    print(reservation_info)

    # Check if there is parking information
    if reservation_info is not None:
        # Convert the result to a JSON format
        parking_json = [{'ID Rezervare': row[0]} for row in reservation_info]
        
        # Return the JSON response
        return jsonify({'success': True, 'data': parking_json})
    else:
        # Return an error response
        return jsonify({'success': False, 'error': 'Error retrieving reservation information.'})
    
    from flask import request

@app.route('/cancel_reservation', methods=['POST'])
def cancel_reservation():
    selected_reservation = request.get_json().get('selectedReservation')
    print(selected_reservation)
    
    try:
        # Add your cancellation logic here based on the selected_reservation
        # For example, you might want to update the database to mark the reservation as canceled
        cancel_reservation_db(selected_reservation)
        result = {'success': True, 'message': f'Reservation {selected_reservation} canceled successfully'}
        return jsonify(result)
    except Exception as e:
        print(f"Error canceling reservation: {e}")
        # Return an error response
        return jsonify({'success': False, 'error': 'Error canceling reservation'}), 500

if __name__ == '__main__':
    app.run(debug=True)
