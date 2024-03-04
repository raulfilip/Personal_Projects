from flask import Flask, jsonify, render_template, request, url_for, session, redirect
import mysql.connector
from adresa_parcari import get_parking_id, select_parking_name, select_parking_price, update_ocupare_loc_liber, update_ocupare_loc_rezervat, update_paraseste_parcare

app = Flask(__name__, template_folder='templates_simulare')
app.config['SECRET_KEY'] = 'your_secret_key'
app.config['STATIC_FOLDER'] = 'static'

@app.route('/')
def selectare_parcare_simulation():
    return render_template('selectare_parcare_simulation.html')

@app.route('/get_parking_options')
def get_parking_options():
    parking_names = select_parking_name()
    if parking_names is not None:
        return jsonify({'success': True, 'options': parking_names})
    else:
        return jsonify({'success': False, 'error': 'Error retrieving parking names.'})


@app.route('/paraseste_parcare', methods=['POST'])
def paraseste_parcare():
    result = update_paraseste_parcare(get_parking_id(session['selected_parking']))  # Replace 'parking_id' with the actual parking ID
    return jsonify(result)


@app.route('/ocupa_loc_liber', methods=['POST'])
def ocupa_loc_liber():
    # Add your logic to handle "Ocupa Loc Liber" here
    # Call the function to update the database or perform any other actions
    result = update_ocupare_loc_liber(get_parking_id(session['selected_parking']))  # Replace 'parking_id' with the actual parking ID
    return jsonify(result)

@app.route('/ocupa_loc_rezervat', methods=['POST']) 
def ocupa_loc_rezervat():
    reservation_id = request.get_json().get('reservationId')
    result = update_ocupare_loc_rezervat(get_parking_id(session['selected_parking']), reservation_id)
    return jsonify(result)

@app.route('/confirm_selection', methods=['POST'])
def confirm_selection():
    selected_parking = request.get_json().get('selectedParking')
    session['selected_parking'] = selected_parking
    print(session['selected_parking'])
    result = {'success': True, 'message': f'Selected parking set to {selected_parking}', 'redirect_url': url_for('simulare')}
    return jsonify(result)

@app.route('/simulare')
def simulare():
    selected_parking = session.get('selected_parking')
    if selected_parking is None:
        # Handle the case where no parking is selected
        return redirect(url_for('selectare_parcare_simulation'))

    # You can pass the selected parking to the 'simulare.html' template if needed
    return render_template('simulare.html', selected_parking=selected_parking)

if __name__ == '__main__':
    app.run(debug=True, port=5001)
