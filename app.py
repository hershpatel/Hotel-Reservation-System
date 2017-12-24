from flask import Flask, render_template, flash, redirect, request, url_for, session, g
from flask_mysqldb import MySQL
from wtforms import Form, StringField, TextAreaField, PasswordField, validators, DateField, IntegerField, FieldList, FormField, SelectField
from passlib.hash import sha256_crypt
from functools import wraps
import sys
import datetime

app = Flask(__name__)

#Config MySQL
app.config['MYSQL_HOST'] = 'hoteldb.c7vrdv0crbyb.us-east-2.rds.amazonaws.com'
app.config['MYSQL_USER'] = 'hershpatel'
app.config['MYSQL_PASSWORD'] = 'dsp1907!'
app.config['MYSQL_DB'] = 'HOTELDB'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor' #this config line returns queries we execute as dictionaries, default is to return as a tuple; ex. User Login 
#init MYSQL
mysql = MySQL(app)

    
@app.template_global(name='zip')
def _zip(*args, **kwargs): #to not overwrite builtin zip in globals
    return __builtins__.zip(*args, **kwargs)


def isloggedin(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args,**kwargs)
        else:
            flash('Unauthorized, Please Login', 'danger')
            return redirect(url_for('login'))
    return wrap


"""
--------------------------------------------------------------
"""


"""
Home Page + About Page
"""
@app.route('/')
def index():
	return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')


"""
--------------------------------------------------------------
"""


"""
User Registration
"""
class RegisterForm(Form):
    name = StringField('Name', [validators.Length(min=1, max=50), validators.required()])
    username = StringField('Username', [validators.Length(min=3, max=25), validators.required()])
    phone = StringField('Phone Number', [validators.Length(min=10,max=10), validators.required()])
    address = StringField('Address', [validators.Length(min=3, max=200), validators.required()])
    email = StringField('Email', [validators.Length(min=3, max=50)])
    password = PasswordField('Password', [
            validators.DataRequired(),
            validators.EqualTo('confirm',message='Passwords do not match')
        ])
    confirm = PasswordField('Confirm Password')

@app.route('/register', methods=['GET','POST'])
def register():
    form = RegisterForm(request.form)
    if request.method == 'POST' and form.validate():
        name = form.name.data
        email = form.email.data
        phone = form.phone.data
        address = form.address.data
        username = form.username.data
        password = sha256_crypt.encrypt(str(form.password.data))
        
        #Create Cursor
        cur = mysql.connection.cursor()
        
        result = cur.execute("SELECT * FROM customer WHERE username=%s", [username])
        
        if result>0:
            flash("Username is already taken", 'danger')
            return render_template('register.html', form=form)
        
        #Execute Query
        cur.execute("INSERT INTO customer(username, password, name, email, address, phone_num) VALUES(%s, %s, %s, %s, %s, %s)", (username, password, name, email, address, int(phone)))
        
        #Commit to DB
        mysql.connection.commit()
        
        #Close Connection
        cur.close()
        
        flash("You are now registered and may log in.", 'success') 
        
        return redirect(url_for('login'))
        
    return render_template('register.html', form=form)


"""
--------------------------------------------------------------
"""


"""
User Login
"""
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method=='POST':
        #Get Form Fields
        username = request.form['username']
        password_candidate = request.form['password']
        
        # Create Cursor
        cur = mysql.connection.cursor() 
        
        #Get User by Username
        result = cur.execute("SELECT * FROM customer WHERE username=%s", [username])
        
        if result>0: 
            #Get Stored Hash
            data = cur.fetchone()
            password = data['password']
            session['cid']=data['CID']
            
            #Compare Passwords
            if sha256_crypt.verify(password_candidate, password):
                #Successful Login
                session['logged_in']=True
                session['username']=username
                flash('You are now logged in', 'success')
                cur.close()
                return redirect(url_for('dashboard'))
            else:
                #Good Username, wrong password
                error = "Invalid Password"
                return render_template('login.html', error=error)
            cur.close() 
        else:
            #Username doesn't exist
            cur.close()
            error = 'Username not found'
            return render_template('login.html', error=error)
    return render_template('login.html')
        

"""
--------------------------------------------------------------
"""


"""
User Logout
"""        
@app.route('/logout')
@isloggedin
def logout():
    session.clear()
    flash('You are now logged out', 'success')
    return redirect(url_for('login')) 


"""
--------------------------------------------------------------
"""


"""
Dashboard
"""
@app.route('/dashboard')
@isloggedin
def dashboard():
    reviews=None
    upcoming=None
    current=None
    past=None
    user=None
    
    cur = mysql.connection.cursor()
    
    #Get Reviews
    result = cur.execute('select * from review where cid=%s',[session['cid']])
    if result>0:
        reviews = cur.fetchall()
        
    result = cur.execute("""SELECT DISTINCT reserves.invoiceNo, hotel.hotel_name, 
                                reserves.hotelID, reserves.inDate, reserves.outDate, 
                                COUNT(reserves.room_num) AS numRooms FROM reserves, reservation, hotel 
                             WHERE reserves.invoiceNo = reservation.invoiceNo 
                                AND reserves.hotelID = hotel.hotelID 
                                AND CID = %s 
                                AND reserves.outDate >= NOW() 
                                AND reserves.inDate <= NOW() 
                            GROUP BY reserves.invoiceNo, hotel.hotel_name, reserves.inDate, reserves.outDate 
                            ORDER BY reserves.inDate""", [session['cid']])
    if result>0:
        current=cur.fetchall()
        
    result = cur.execute("""SELECT DISTINCT reserves.invoiceNo, hotel.hotel_name, 
                                reserves.hotelID, reserves.inDate, reserves.outDate, 
                                COUNT(reserves.room_num) AS numRooms FROM reserves, reservation, hotel 
                             WHERE reserves.invoiceNo = reservation.invoiceNo 
                                AND reserves.hotelID = hotel.hotelID 
                                AND CID = %s 
                                AND reserves.outDate < NOW() 
                                AND reserves.inDate < NOW() 
                            GROUP BY reserves.invoiceNo, hotel.hotel_name, reserves.inDate, reserves.outDate 
                            ORDER BY reserves.inDate""", [session['cid']])
    if result>0:
        past=cur.fetchall()
    
    result = cur.execute("""SELECT DISTINCT reserves.invoiceNo, hotel.hotel_name, 
                                reserves.hotelID, reserves.inDate, reserves.outDate, 
                                COUNT(reserves.room_num) AS numRooms FROM reserves, reservation, hotel 
                             WHERE reserves.invoiceNo = reservation.invoiceNo 
                                AND reserves.hotelID = hotel.hotelID 
                                AND CID = %s 
                                AND reserves.outDate > NOW() 
                                AND reserves.inDate > NOW() 
                            GROUP BY reserves.invoiceNo, hotel.hotel_name, reserves.inDate, reserves.outDate 
                            ORDER BY reserves.inDate""", [session['cid']])
    if result>0:
        upcoming=cur.fetchall()
        
    result = cur.execute("""SELECT * FROM customer WHERE CID=%s""", [session['cid']])
    user=cur.fetchone()
    
    return render_template('dashboard.html', reviews=reviews, upcoming=upcoming, past=past, current=current, user=user)
    
    cur.close()

    
@app.route('/reservation/<string:id>/')
@isloggedin
def view_reservation(id):
    breakfasts=None
    services=None
    rooms=None
    
    cur = mysql.connection.cursor()
    result=cur.execute('SELECT * FROM reservation WHERE invoiceNo=%s',[id])
    res = cur.fetchone()
    
    if result<1:
        flash("Reservation does not exist", 'danger')
        return redirect(url_for('dashboard'))
    if res['CID']!=session['cid']:
        flash("You are not authorized to view this reservation",'danger')
        return redirect(url_for('dashboard'))
    
    result=cur.execute("""SELECT DISTINCT reserves.inDate, reserves.outDate, reserves.noOfDays, 
				            reserves.room_num, myroom.room_type, myroom.description
                          FROM reserves, review, reservation, myroom, hotel
                          WHERE reserves.hotelID = hotel.hotelID
                            AND reserves.hotelID = myroom.hotelID 
                            AND reservation.CID = review.CID
                            AND reserves.room_num = myroom.room_num
                            AND reserves.invoiceNo = %s""", [id])
    rooms=cur.fetchall()
    
    result = cur.execute("""SELECT DISTINCT includes.bType, breakfast.description, includes.num_of_breakfasts
                            FROM reserves, includes, reservation, breakfast, hotel
                            WHERE reserves.hotelID = hotel.hotelID
                                AND reserves.hotelID = includes.hotelID
                                AND reserves.invoiceNo = reservation.invoiceNo
                                AND includes.invoiceNo = reserves.invoiceNo
                                AND breakfast.bType = includes.bType
                                AND breakfast.hotelID = reserves.hotelID
                                AND reserves.invoiceNo = %s""", [id])
    if result>0:
        breakfasts=cur.fetchall()
    
    result = cur.execute("""SELECT DISTINCT `contains`.sType
                               FROM reserves, `contains`, review, reservation, services, hotel
                               WHERE reserves.hotelID = hotel.hotelID
                                   AND reserves.hotelID = `contains`.hotelID 
                                   AND reservation.CID = review.CID 
                                   AND `contains`.invoiceNo = reserves.invoiceNo
                                   AND services.sType = `contains`.sType AND services.hotelID = reserves.hotelID 
                                   AND reserves.invoiceNo = %s""", [id])
    if result>0:
        services=cur.fetchall()
    
    cur.close()
    return render_template('reservation.html', res=res, rooms=rooms, breakfasts=breakfasts, services=services)

"""
--------------------------------------------------------------
"""


"""
Reservation System
"""
# Form Data
class SearchHotelForm(Form):
    country = StringField('Country',[validators.Length(min=1), validators.required()])
    state = StringField('State', [validators.Length(min=1), validators.required()])
    check_in = DateField('Check-In Date', [validators.required()], format='%m-%d-%Y')
    check_out = DateField('Check-Out Date', [validators.required()], format='%m-%d-%Y')
    num_rooms = IntegerField('Number of Rooms', [validators.required()])
    
class RoomNumEntry(Form):
    room_num=IntegerField()
    
class PickHotelForm(Form):
    hotel = IntegerField('Choose Hotel ID', [validators.required()])
    room_nums = FieldList(FormField(RoomNumEntry), [validators.required()], min_entries=1)

class BField(Form):
    Breakfast_Type=StringField()
    
class BField2(Form):
    Quantity=StringField()
    
class SField(Form):
    Service_Type=StringField()
    
class AmenitiesForm(Form):
    breakfasts = FieldList(FormField(BField), min_entries=0)
    quantities = FieldList(FormField(BField2), min_entries=0)
    services = FieldList(FormField(SField), min_entries=0)

class ReservationInfo():
    num_rooms=0         #number of roooms to reserve
    room_nums=None      #room info
    hotel=None          #hotel id
    check_in=None       #check-in date
    check_out=None      #check-out date
    num_days=0          #length of stay
    cost=0              #total cost
    capacity=0          #total # of spots in the room
    bfastQuantity=0     #total # of breakfasts
    breakfasts=None     #list of three-ples (id, quantity, cost)
    services=None       #list of three-ples (id, quantity, cost) 
    country=None        #country of reservation
    state=None          #state of reservation
    #### SQL ####
    hotels_avail=None
    bfast_avail=None
    serv_avail=None

res = None
    
# STEP 1 - Search for Available Rooms
@app.route('/search_room', methods=['GET','POST'])
@isloggedin
def search_room():
    search_form = SearchHotelForm(request.form)
    
    cur = mysql.connection.cursor()
    search_result = cur.execute("SELECT DISTINCT state,country FROM hotel")
    location_avail=cur.fetchall()
    cur.close()
    
    locations = dict()
    for loc in location_avail:
        if not loc['country'] in locations:
            locations[loc['country']]=list()
        locations[loc['country']].append(loc['state'])
    
    
    if request.method=='POST' and search_form.validate():
        country = search_form.country.data
        state = search_form.state.data
        check_in = search_form.check_in.data
        check_out = search_form.check_out.data
        num_rooms = search_form.num_rooms.data
        
        if not country in locations:
            flash("Country '"+str(country)+"' does not exist in table", 'danger')
            return render_template('1_search_room.html', form=search_form, loc=locations)
        
        if not state in locations[country]:
            flash("State '"+str(state)+"' does not exist in table under country '"+str(country)+"'", 'danger')
            return render_template('1_search_room.html', form=search_form, loc=locations)
        
        if num_rooms<1:
            flash("Must reserve atleast 1 room", 'danger')
            return render_template('1_search_room.html', form=search_form, loc=locations)
        
        if check_in<datetime.date.today():
            flash("Check-In Date must be today or later", 'danger')
            return render_template('1_search_room.html', form=search_form, loc=locations)
        
        if check_out<=check_in:
            flash("Check-Out Date must be at least one day later than Check-In Date", 'danger')
            return render_template('1_search_room.html', form=search_form, loc=locations)
        
        
        cur= mysql.connection.cursor()
        search_result = cur.execute("""SELECT DISTINCT r.hotelID, r.room_num, h.hotel_name, 
                                            h.country, h.state, h.city, h.address, h.zipcode, r.price, r.capacity, 
                                            r.floor_no, r.description, r.room_type, 
                                            IFNULL(rd.discount, 'No Discount Available') AS DiscountPct
                                        FROM hotel AS h
                                        LEFT JOIN myroom AS r
                                            ON h.hotelID = r.hotelID
                                        LEFT JOIN reserves AS re
                                            ON r.hotelID = re.hotelID
                                                AND r.room_num = re.room_num
                                                AND (re.inDate <= %s OR re.outDate >= %s)
                                        LEFT JOIN room_discount AS rd
                                            ON r.hotelID = rd.hotelID
                                                AND r.room_num = rd.room_no
                                                AND (rd.sdate >= %s AND rd.edate <= %s)
                                        INNER JOIN HotelPhoneNumbers AS ph
                                            ON h.hotelID = ph.hotelID
                                        WHERE re.invoiceNo IS NULL
                                        AND h.country = %s AND h.state = %s
                                        ORDER BY r.hotelID, r.room_num;""",
                                    (check_in, check_out, check_in, check_out, country, state))
        hotels_avail = cur.fetchall()
        cur.close()
        
        #only collect list of hotels with more than specified number of rooms 
        #output lower room number error if not enough space
        if search_result==0:
            flash("No Rooms Available, try different search", 'danger')
            return render_template('1_search_room.html', form=search_form, loc=locations)
        
        count=0
        new_hotels_avail = dict()
        for room in hotels_avail:
            if not room['hotelID'] in new_hotels_avail:
                new_hotels_avail[room['hotelID']]=list()
                count+=1
            new_hotels_avail[room['hotelID']].append(room)
        
        for key in new_hotels_avail.keys():
            if len(new_hotels_avail[key])<num_rooms:
                new_hotels_avail[key]=None
                count-=1
                
        if count==0:
            flash("Not enough rooms available, try different search", 'danger')
            return render_template('1_search_room.html', form=search_form, loc=locations)
        
        global res
        res = ReservationInfo()
        res.num_rooms = num_rooms
        res.check_in = check_in
        res.check_out = check_out
        res.num_days = (check_out-check_in).days
        res.country=country
        res.state=state
        res.hotels_avail=new_hotels_avail
        
        return redirect(url_for('pick_room'))
    return render_template('1_search_room.html', form=search_form, loc=locations)


# STEP 2 - Select Rooms to Reserve
@app.route('/pick_room', methods=['GET','POST'])
@isloggedin
def pick_room():
    global res
    
    room_fields = list()
    for i in range(1,res.num_rooms+1):
        room_fields.append({"room_num":"Enter Room #"+str(i)})
    reserve_form = PickHotelForm(request.form, room_nums=room_fields)
    
    if request.method=='POST' and reserve_form.validate():
        hotel = reserve_form.hotel.data
        room_nums = set([list(r.values())[0] for r in reserve_form.room_nums.data])
        
        #check sql query results from search_room to see if hotel exists
        if not hotel in res.hotels_avail.keys():
            flash("Hotel ID "+str(hotel)+" does not exist in table", 'danger')
            return render_template('2_pick_room.html', form=reserve_form, res=res)
        
        if len(room_nums)<res.num_rooms:
            flash("Entered duplicate room numbers", 'danger')
            return render_template('2_pick_room.html', form=reserve_form, res=res)
        
        #check sql query results from search_room to see if all room_numbers exist
        capacity=0
        total=0
        for num in room_nums:
            found=False
            for room in res.hotels_avail[hotel]:
                if (room['room_num']==num):
                    found=True
                    capacity+=room['capacity']
                    total = total + (room['price']*res.num_days)
                    total+=room['price']
                    break
            if not found:
                flash("Room Number "+str(num)+" does not exist in Hotel "+str(hotel), 'danger')
                return render_template('2_pick_room.html', form=reserve_form, res=res)

        res.capacity=capacity
        res.cost=total
        res.hotel=hotel
        res.room_nums=room_nums
        return redirect(url_for('pick_amenities'))
    
    return render_template('2_pick_room.html', form=reserve_form, res=res)


# STEP 3 - Select Amenities
@app.route('/pick_amenities', methods=['GET','POST'])
@isloggedin
def pick_amenities():
    global res
    bfast_fields = list()
    bfast_q_fields = list()
    serv_fields = list()
    
    cur = mysql.connection.cursor()
    search_result = cur.execute("SELECT bType, description, bPrice FROM breakfast WHERE hotelID=%s", [res.hotel])
    if search_result>0:
        res.bfast_avail = cur.fetchall()
        for b in res.bfast_avail:
            bfast_fields.append({"Breakfast_Type":"Enter Breakfast Type"})
            bfast_q_fields.append({"Quantity":"Enter Quantity"})
    search_result = cur.execute("SELECT sType, sCost FROM services WHERE hotelID=%s", [res.hotel])
    if search_result>0:
        res.serv_avail = cur.fetchall()
        for s in res.serv_avail:
            serv_fields.append({"Service_Type":"Enter Service Type"})
    cur.close()
    amen_form = AmenitiesForm(request.form, breakfasts=bfast_fields, services=serv_fields, quantities=bfast_q_fields)
    
    #print list of all possible breakfast options for the hotel - vary across all rooms
    #print list of all possible service options for the hotel - vary across all rooms
    form = AmenitiesForm(request.form)
    if request.method=='POST':
        services = [list(r.values())[0] for r in amen_form.services.data]
        breakfasts = [list(r.values())[0] for r in amen_form.breakfasts.data]
        old_quantities = [list(r.values())[0] for r in amen_form.quantities.data]
        quantities=list()
        for q in old_quantities:
            if q=="Enter Quantity":
                continue
            elif not q.isdigit():
                flash("Quantity must be an integer >=1", 'danger')
                return render_template('3_pick_amenities.html', form=amen_form, res=res)
            quantities.append(int(q))
        
        if len(quantities)!=len([b for b in breakfasts if b!="Enter Breakfast Type"]):
            flash("Must enter a quantity for each breakfast and vice versa", 'danger')
            return render_template('3_pick_amenities.html', form=amen_form, res=res)
        
        cost=0
        count=0
        final_breakfasts=list()
        for q, b in zip(quantities,breakfasts):
            if b=='Enter Breakfast Type':
                continue
            if q<1:
                flash("Quantity must be >=1", 'danger')
                return render_template('3_pick_amenities.html', form=amen_form, res=res)
            found=False 
            for row in res.bfast_avail:
                if row['bType']==b:
                    found=True
                    cost=cost+(row['bPrice']*q)
                    final_breakfasts.append((b,q))
                    break
            if not found:
                flash("Breakfast Type '"+str(b)+"' does not exist", 'danger')
                return render_template('3_pick_amenities.html', form=amen_form, res=res)
            count+=q
        
        if count>res.capacity:
            flash("Total breakfast quantity must be <="+str(res.capacity), 'danger')
            return render_template('3_pick_amenities.html', form=amen_form, res=res)
        
        final_services=list()
        for s in services:
            if s=='Enter Service Type':
                continue
            found=False
            for row in res.serv_avail:
                if row['sType']==s:
                    found=True
                    cost+=row['sCost']
                    final_services.append(s)
                    break
            if not found:
                flash("Service Type '"+str(s)+"' does not exist", 'danger')
                return render_template('3_pick_amenities.html', form=amen_form, res=res)
        
        res.bfastQuantity=count
        res.cost+=cost
        res.breakfasts=final_breakfasts
        res.services=final_services
        return redirect(url_for('summary'))
    
    return render_template('3_pick_amenities.html', form=amen_form, res=res)


class ReservationSummary():
    check_in=""
    num_days=""
    room_nums=""
    breakfasts=""
    services=""
    cost=""
    
    
# STEP 4 - Reservation Summary
@app.route('/summary', methods=['GET','POST'])
@isloggedin
def summary():
    global res
    summ = ReservationSummary()
    
    cur = mysql.connection.cursor()
    search_result = cur.execute("SELECT hotel_name, city, address, state, country FROM hotel WHERE hotelID=%s", [res.hotel])
    hotel_info=cur.fetchone()
    cur.close()
    
    summ.check_in=str(res.check_in)
    summ.check_out=str(res.check_out)
    summ.num_days=str(res.num_days)
    summ.room_nums=", ".join([str(r) for r in res.room_nums])
    summ.breakfasts = ", ".join([str(b)+" ("+str(q)+")" for b,q in res.breakfasts])
    summ.services = ", ".join([str(s) for s in res.services])
    summ.cost = str(round(res.cost,2))
        
    if request.method=='POST':
        
        cur = mysql.connection.cursor()
        result = cur.execute("""INSERT INTO `reservation`(`CID`, `totalAmt`, `resDate`)
                                VALUES(%s, %s, NOW())""", (session['cid'], res.cost))
        mysql.connection.commit()
        for room in res.room_nums:  
            result = cur.execute("""INSERT INTO `reserves`(`invoiceNo`, `room_num`, `hotelID`, `noOfDays`, `inDate`, `outDate`)
                                    VALUES((SELECT MAX(invoiceNo) AS invNo FROM reservation), %s, %s, %s, %s, %s)""", 
                                    (room, res.hotel, res.num_days, res.check_in, res.check_out))
            mysql.connection.commit()
        for b,q in res.breakfasts:
            result = cur.execute("""INSERT INTO `includes`(`invoiceNo`, `hotelID`,`bType`, `num_of_breakfasts`)
                                    VALUES((SELECT MAX(invoiceNo) AS invNo FROM reservation), %s, %s, %s)""", 
                                    (res.hotel, b, q))
            mysql.connection.commit()
        for s in res.services:
            result = cur.execute("""INSERT INTO `contains`(`invoiceNo`, `hotelID`,`sType`, `num_of_services`)
				                    VALUES((SELECT MAX(invoiceNo) AS invNo FROM reservation), %s, %s, %s)""", 
                                    (res.hotel, s, 1))
            mysql.connection.commit()
        cur.close()
        
        res = None
        flash("Reservation successful",'success')
        return redirect(url_for('dashboard'))
    return render_template('4_summary.html', summ=summ, hotel=hotel_info)

@app.route('/pick_room')
@isloggedin
def reroute_pick_room():
    return redirect(url_for('search_room'))
    
@app.route('/pick_amenities')
@isloggedin
def reroute_pick_amenities():
    return redirect(url_for('search_room'))

@app.route('/summary')
@isloggedin
def reroute_summary():
    return redirect(url_for('search_room'))
    
    
"""
--------------------------------------------------------------
"""


"""
Review System
"""
class ReviewsForm(Form):
    hotel = IntegerField('Invoice ID', [validators.required()])
    revtype = SelectField('Review Type', [validators.required()], choices=[('Room','Room'),('Service','Service'),('Breakfast','Breakfast')])
    
class ReviewsForm2(Form):
    actual_title = StringField('Title of Review', [validators.Length(min=1, max=200)])
    title = StringField('About Review (MUST CHOOSE SOMETHING FROM COLUMN 1)', [validators.Length(min=1, max=200)])
    rating = SelectField('Rating', choices=[('1','1'),('2','2'),('3','3'),('4','4'),('5','5'),('6','6'),('7','7'),('8','8'),('9','9'),('10','10')])
    body = TextAreaField('Review', [validators.Length(min=5)])
    
class ReviewInfo():
    invoice=None    #invoice number
    hotel=None      #hotel name
    hotelID=None    #hotel ID
    check_in=None   #check_in date
    check_out=None  #check_out date
    num_rooms=None  #number of rooms
    revtype=None    #'Room' is room, 'Breakfast' is breakfast, 'Service' is service
    titles_avail=None #sql output of possible review titles
    

review = None
    
@app.route('/add_review_1', methods=['GET','POST'])
@isloggedin
def add_review_1():
    global review
    form = ReviewsForm(request.form)
    
    cur = mysql.connection.cursor()
    
    result = cur.execute("SELECT DISTINCT reserves.invoiceNo, hotel.hotel_name, reserves.hotelID, reserves.inDate, reserves.outDate, COUNT(reserves.room_num) AS numRooms FROM reserves, reservation, hotel WHERE reserves.invoiceNo = reservation.invoiceNo AND reserves.hotelID = hotel.hotelID AND CID = %s AND reserves.outDate < NOW() AND reserves.inDate < NOW() GROUP BY reserves.invoiceNo, hotel.hotel_name, reserves.inDate, reserves.outDate ORDER BY reserves.inDate", [session['cid']])
    res_avail=cur.fetchall()
    if result<1:
        cur.close()
        flash("You do not have any past reservations to write a review about", 'danger')
        return redirect(url_for('dashboard'))
    cur.close()

    
    if request.method == 'POST' and form.validate():
        invoice = form.hotel.data
        revtype = str(form.revtype.data)
        
        found=False
        r = None
        for row in res_avail:
            if row['invoiceNo']==invoice:
                found=True
                r=row
                break
        if not found:
            flash("Invoice # '"+str(invoice)+"' does not exist in table", 'danger')
            return render_template('add_review_1.html', form=form, inv=res_avail)
        
        cur = mysql.connection.cursor()
        review = ReviewInfo()
        if revtype=="Room":
            search_result = cur.execute("""SELECT DISTINCT reserves.room_num, myroom.room_type
                                           FROM reserves, review, reservation, myroom, hotel
                                           WHERE reserves.hotelID = hotel.hotelID 
                                                AND reserves.hotelID = myroom.hotelID 
                                                AND reservation.CID = review.CID 
                                                AND reserves.invoiceNo = reservation.invoiceNo
                                                AND reserves.room_num = myroom.room_num
                                                AND reserves.invoiceNo = %s""", [invoice])
            if search_result<1 or search_result==None: 
                cur.close()
                flash("You did not get any room types in this reservation, try a different review type", 'danger')
                return render_template('add_review_1.html', form=form, inv=res_avail)
            review.titles_avail=cur.fetchall()
        elif revtype=="Breakfast":
            search_result = cur.execute("""SELECT DISTINCT includes.bType, breakfast.bPrice, breakfast.description
                                            FROM reserves, includes, reservation, breakfast, hotel
                                            WHERE reserves.hotelID = hotel.hotelID
                                                AND reserves.hotelID = includes.hotelID
                                                AND reserves.invoiceNo = reservation.invoiceNo
                                                AND includes.invoiceNo = reserves.invoiceNo
                                                AND breakfast.bType = includes.bType
                                                AND breakfast.hotelID = reserves.hotelID
                                                AND reserves.invoiceNo = %s""", [invoice])
            if search_result<1 or search_result==None:
                cur.close()
                flash("You did not get any breakfasts in this reservation, try a different review type", 'danger')
                return render_template('add_review_1.html', form=form, inv=res_avail)
            review.titles_avail=cur.fetchall()
        else:
            search_result = cur.execute("""SELECT DISTINCT `contains`.sType, services.sCost
                                           FROM reserves, `contains`, review, reservation, services, hotel
                                           WHERE reserves.hotelID = hotel.hotelID
                                               AND reserves.hotelID = `contains`.hotelID 
                                               AND reservation.CID = review.CID 
                                               AND reserves.invoiceNo = reservation.invoiceNo
                                               AND `contains`.invoiceNo = reserves.invoiceNo
                                               AND services.sType = `contains`.sType AND services.hotelID = reserves.hotelID 
                                               AND reserves.invoiceNo = %s""", [invoice])
            if search_result<1 or search_result==None:
                cur.close()
                flash("You did not get any services in this reservation, try a different review type", 'danger')
                return render_template('add_review_1.html', form=form, inv=res_avail)
            review.titles_avail=cur.fetchall()
        
        cur.close()  
        review.invoice=invoice
        review.revtype=revtype
        review.check_in=r['inDate']
        review.check_out=r['outDate']
        review.num_rooms=r['numRooms']
        review.hotel=r['hotel_name']
        review.hotelID=r['hotelID']
        
        return redirect(url_for('add_review_2'))
    
    return render_template('add_review_1.html', form=form, inv=res_avail)

@app.route('/add_review_2', methods=['GET','POST'])
@isloggedin
def add_review_2():
    global review
    form = ReviewsForm2(request.form)
    
    if request.method == 'POST' and form.validate():
        actual_title = form.actual_title.data
        title = form.title.data
        body = form.body.data
        rating = int(form.rating.data)
        
        if review.revtype=='Room':
            if not title.isdigit():
                flash("About Review Value, '"+str(title)+"', is not a valid Room Number", 'danger')
                return render_template('add_review_2.html', form=form, rev=review)
            found=False
            for row in review.titles_avail:
                if int(title)==row['room_num']:
                    found=True
                    break
            if not found:
                flash("About Review Value, '"+str(title)+"', is not a valid Room Number", 'danger')
                return render_template('add_review_2.html', form=form, rev=review)
        elif review.revtype=='Breakfast':
            found=False
            for row in review.titles_avail:
                if title==row['bType']:
                    found=True
                    break
            if not found:
                flash("About Review Value, '"+str(title)+"', is not a valid Breakfast Type", 'danger')
                return render_template('add_review_2.html', form=form, rev=review) 
        else:
            found=False
            for row in review.titles_avail:
                if title==row['sType']:
                    found=True
                    break
            if not found:
                flash("About Review Value, '"+str(title)+"', is not a valid Service Type", 'danger')
                return render_template('add_review_2.html', form=form, rev=review)
        
        cur = mysql.connection.cursor()
        if review.revtype=='Room':
            result = cur.execute("""INSERT INTO `review` (`CID`, `rating`, 	`title`, `textcomment`, `review_type`)
			                        VALUES (%s, %s, %s, %s, 'Room')""",                                        
                                    (session['cid'], rating, actual_title, body))
            mysql.connection.commit()
            result = cur.execute("""INSERT INTO `room_review` 
                                    VALUES ((SELECT MAX(reviewID) AS revID FROM review), %s, %s)""",
                                    (int(title), review.hotelID))
            mysql.connection.commit()
        elif review.revtype=='Breakfast':
            result = cur.execute("""INSERT INTO `review` (`CID`, `rating`, 	`title`, `textcomment`, `review_type`)
			                        VALUES (%s, %s, %s, %s, 'Breakfast')""",                                         
                                    (session['cid'], rating, actual_title, body))
            mysql.connection.commit()
            result = cur.execute("""INSERT INTO `breakfast_review` 
                                    VALUES ((SELECT MAX(reviewID) AS revID FROM review), %s, %s)""",
                                    (title, review.hotelID))
            mysql.connection.commit()
        else:
            result = cur.execute("""INSERT INTO `review` (`CID`, `rating`, 	`title`, `textcomment`, `review_type`)
			                        VALUES (%s, %s, %s, %s, 'Service')""",                                        
                                    (session['cid'], rating, actual_title, body))
            mysql.connection.commit()
            result = cur.execute("""INSERT INTO `service_review` 
                                    VALUES ((SELECT MAX(reviewID) AS revID FROM review), %s, %s)""",
                                    (title, review.hotelID))
            mysql.connection.commit()
        cur.close()
        
        review = None
        flash("Review Added", 'success')
        return redirect(url_for('dashboard'))
    
    return render_template('add_review_2.html', form=form, rev=review)

# Delete Review
@app.route('/delete_review/<string:id>', methods=['POST'])
@isloggedin
def delete_review(id):
    cur = mysql.connection.cursor()
    cur.execute("delete from review where reviewID=%s",  [id])
    mysql.connection.commit()
    cur.close()
    flash("Review Deleted", 'success')
    return redirect(url_for('dashboard'))


@app.route('/reviews')
def reviews():
    #Create Cursor
    cur = mysql.connection.cursor()
    
    #Get Reviews
    result = cur.execute('select * from review')
    reviews = cur.fetchall()
    
    if result>0:
        return render_template('reviews.html', reviews=reviews)
    else:
        cur.close()
        flash("No Reviews Found", 'success')
        return render_template('reviews.html')
    cur.close()

@app.route('/review/<string:id>/') 
def review(id):
    hotel=None
    data=None
    user=None
    cur = mysql.connection.cursor()
    result=cur.execute('SELECT * FROM review WHERE reviewID=%s',[id])
    review = cur.fetchone()
    
    if review['review_type']=='Room':
        result = cur.execute("""SELECT * FROM myroom 
	                            WHERE hotelID=(SELECT hotelID FROM room_review WHERE reviewID=%s)
		                          AND room_num=(SELECT room_num FROM room_review WHERE reviewID=%s)""", (id,id))
        data=cur.fetchone()
        
        result = cur.execute("""SELECT * FROM hotel WHERE hotelID=%s""", [data['hotelID']])
        hotel=cur.fetchone()
        
    elif review['review_type']=='Breakfast':
        result = cur.execute("SELECT * FROM breakfast_review WHERE reviewID=%s", [id])
        data=cur.fetchone()
        
    else:
        result = cur.execute("SELECT * FROM service_review WHERE reviewID=%s", [id])
        data=cur.fetchone()
    
    result = cur.execute("SELECT * FROM customer WHERE CID=%s", [review['CID']])
    user=cur.fetchone()
    
    cur.close()
    return render_template('review.html', review=review, data=data, user=user, hotel=hotel)

    
"""
--------------------------------------------------------------
"""


"""
Customer Analytics Page
"""

def isadmin(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'admin'==session['username']:
            return f(*args,**kwargs)
        else:
            flash('Unauthorized, must be admin', 'danger')
            return redirect(url_for('dashboard'))
    return wrap

class analyticsForm(Form):
    begin = DateField('Begin Date', [validators.required()], format='%m-%d-%Y')
    end = DateField('End Date', [validators.required()], format='%m-%d-%Y')
    stat = SelectField('Choose Statistic', [validators.required()], choices=[('1','Highest Rated Room Type Per Hotel'),('2','Highest Rated Breakfast Across All Hotels'),('3','Highest Rated Service Across All Hotels'),('4','Top 5 Customers ($$)')])

class analyticsInfo():
    one=None
    two=None
    three=None
    four=None
    stat='0'

@app.route('/analytics', methods=['GET','POST'])
@isloggedin
@isadmin
def analytics():
    
    form = analyticsForm(request.form)
    anal=analyticsInfo()
    anal.stat='0'
    if request.method == 'POST' and form.validate():
        begin=form.begin.data
        end=form.end.data
        stat=form.stat.data
        
        if end<=begin:
            flash("End Date must be at least one day later than Begin Date", 'danger')
            return render_template('analytics.html', form=form, anal=anal)
        
        if end>datetime.date.today():
            flash("End Date must on or before today's date", 'danger')
            return render_template('analytics.html', form=form, anal=anal)
        
        cur = mysql.connection.cursor()
        result = 0
        cur.close()
        
        if stat=='1':
            final=list()
            cur = mysql.connection.cursor()
            result = cur.execute("SELECT hotelID FROM hotel")
            hotels = cur.fetchall()
            for h in hotels:
                result = cur.execute("""SELECT r.hotelID, r.room_type, SUM(re.rating)/COUNT(r.room_num) AS Average
                                        FROM myroom AS r, reserves AS res, review AS re, room_review AS rr
                                        WHERE re.reviewID = rr.reviewID 
                                            AND rr.room_num = r.room_num 
                                            AND rr.hotelID = r.hotelID 
                                            AND r.hotelID = %s
                                            AND (res.inDate >= %s AND res.outDate <= %s)
                                        GROUP BY r.hotelID, r.room_type
                                        ORDER BY SUM(re.rating)/COUNT(r.room_num) DESC
                                        LIMIT 1""", (h['hotelID'], begin, end))
                final.append(cur.fetchone())
            cur.close()
            anal.one=final
        elif stat=='2':
            cur = mysql.connection.cursor()
            result = cur.execute("""SELECT br.bType, SUM(re.rating)/COUNT(b.bType) AS Average
                                    FROM breakfast AS b, review AS re, breakfast_review AS br, reserves AS res
                                    WHERE re.reviewID = br.reviewID AND br.btype = b.bType
                                    AND (res.inDate >= %s AND res.outDate <= %s)
                                    GROUP BY br.btype
                                    ORDER BY SUM(re.rating)/COUNT(b.btype) DESC
                                    LIMIT 1""", (begin, end))
            anal.two=cur.fetchall()
            cur.close()
        elif stat=='3':
            cur = mysql.connection.cursor()
            result = cur.execute("""SELECT s.sType, SUM(re.rating)/COUNT(sr.sType) AS Average
                                    FROM services AS s, review AS re, service_review AS sr, reserves AS res
                                    WHERE re.reviewID = sr.reviewID AND sr.sType = s.sType
                                    AND (res.inDate >= %s AND res.outDate <= %s)
                                    GROUP BY s.sType
                                    ORDER BY SUM(re.rating)/COUNT(sr.sType) DESC
                                    LIMIT 1""", (begin, end))
            anal.three=cur.fetchall()
            cur.close()
        elif stat=='4':
            cur = mysql.connection.cursor()
            result = cur.execute("""SELECT r.CID, c.name, ROUND(SUM(r.totalAmt),2) AS totalSpent
                                    FROM customer AS c, reservation AS r, reserves AS res
                                    WHERE c.CID = r.CID 
                                    AND r.invoiceNo = res.invoiceNo
                                    AND (res.inDate >= %s AND res.outDate <= %s)
                                    GROUP BY r.CID, c.name
                                    ORDER BY SUM(r.totalAmt) DESC
                                    LIMIT 5""", (begin, end))
            anal.four=cur.fetchall()
            cur.close()
        anal.stat=stat
        return render_template('analytics.html', form=form, anal=anal)
    return render_template('analytics.html', form=form, anal=anal)
    
    


"""
--------------------------------------------------------------
"""
    
    
if __name__ == '__main__':
    app.secret_key='secret123'
    app.run(debug=True)


    