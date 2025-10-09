from bson import ObjectId
from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt

client = MongoClient('mongodb://localhost:27017/cinema-app')
db = client['cinema-app']

@keyword('Remover usuario do database')
def remove_user(user):
    users = db['users']
    email = user["email"]
    users.delete_many({'email': email})
 

@keyword('Inserir usuario no database')
def insert_user(user):
    hash_pass = bcrypt.hashpw(user["password"].encode('utf-8'), bcrypt.gensalt(8))
    doc = {
        'name': user["name"],
        'email': user["email"],
        'password': hash_pass
    }
    users = db['users']
    users.insert_one(doc)


@keyword('Atualizar role do usuario para admin')
def update_user_role_to_admin(email):
    users = db['users']
    users.update_one(
        {'email': email},               
        {'$set': {'role': 'admin'}}     
    )


@keyword('Limpar usuario do database')
def clean_user(user):
    users = db["users"]
    user_email = user["email"]
    reservations = db["reservations"]
    u = users.find_one({"email": user_email})
    if(u):
        reservations.delete_many({"user": u["_id"]})
        users.delete_many({"email": user_email})


@keyword('Pegar id do usuario')
def get_user_id(user):
    users = db["users"]
    user = users.find_one({"email": user["email"]})
    return user["_id"] 


@keyword('Remover filme do database')
def remove_movie(id_movie):
    movies = db["movies"]
    movies.delete_many({'_id': id_movie})


@keyword('Inserir filme no database')
def insert_movie(movie):
    doc = {
        "title": movie["title"],
        "synopsis": movie["synopsis"],
        "director": movie["director"],
        "genres": movie["genres"],
        "duration": movie["duration"],
        "classification": movie["classification"],
        "poster": movie["poster"],
        "releaseDate": movie["releaseDate"]
    }
    movies = db['movies']
    movies.insert_one(doc)


@keyword('Pegar id do filme')
def get_movie_id(movie):
    movies = db["movies"]
    movie = movies.find_one({"title": movie["title"]})
    return movie["_id"] 


@keyword('Remover teatro do database')
def remove_theater(id_teatro):
    teatros = db["theaters"]
    teatros.delete_many({'_id': id_teatro})


@keyword('Inserir teatro no database')
def insert_theater(theater):
    doc = {
        "name": theater["name"],
        "capacity": theater["capacity"],
        "type": theater["type"]
    }
    theaters = db['theaters']
    theaters.insert_one(doc)


@keyword('Pegar id do teatro')
def get_theater_id(theater):
    theaters = db["theaters"]
    theater = theaters.find_one({"name": theater["name"]})
    return theater["_id"] 


@keyword('Remover sessao do database')
def remove_session(id_session):
    sessions = db["sessions"]
    sessions.delete_many({'_id': id_session})


@keyword('Inserir sessao no database')
def insert_session(session):
    seats = []
    for row in range(8):  
        row_letter = chr(ord('A') + row)
        for num in range(1, 11):  
            seats.append({
                "row": row_letter,
                "number": num,
                "status": "available"
            })
    doc = {
        "movie": session["movie"],
        "theater": session["theater"],
        "datetime": session["datetime"],
        "fullPrice": session["fullPrice"],
        "halfPrice": session["halfPrice"],
        "seats": seats
    }
    sessions = db['sessions']
    sessions.insert_one(doc)


@keyword('Pegar id da sessao')
def get_session_id(session):
    sessions = db["sessions"]

    movie_id = ObjectId(str(session["movie"]))
    theater_id = ObjectId(str(session["theater"]))

    doc = sessions.find_one({
        "movie": movie_id,
        "theater": theater_id
    })
    return doc["_id"] 


@keyword('Remover reserva do database')
def remove_reservation(id_reservation):
    reservations = db["reservations"]
    reservations.delete_many({'_id': id_reservation}) 


@keyword('Inserir reserva no database')
def insert_reservation(reservation):
    doc = {
        "session": reservation["session"],
        "seats": reservation["seats"],
        "paymentMethod": reservation["paymentMethod"]
    }
    reservations = db['reservations']
    reservations.insert_one(doc) 


@keyword('Pegar id da reserva')
def get_reservation_id(reservation):
    reservations = db["reservations"]
    session_id = ObjectId(str(reservation["session"]))
    
    doc = reservations.find_one({
        "session": session_id
    })
    return doc["_id"]