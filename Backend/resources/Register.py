from flask_restful import Resource
from flask import request
from models import db, User

class Register(Resource):
    
    def get(self):
        users = User.query.all()
        user_list = []
        for i in range(0, len(users)):
            user_list.append(users[i].serialize())
        return {"status" : str(user_list)}, 200

    def post(self):

        # Get username, email, password
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message' : 'No imput data provide'}, 400

        # data, errors = User.load(json_data)

        # if errors:
        #     return errors, 422

        # Check if username exist
        user = User.query.filter_by(username=json_data['username']).first()
        if user:
            return {'message' : 'Username not available'}, 400

        # Check if the email exist
        user = User.query.filter_by(email=json_data['email']).first()
        if user:
            return {'message' : 'Email already exist'}, 400

        # username = data['username']
        # password = data['password']
        # email = data['email']
        
        # Create the user
        user = User(
            firstname = json_data['firstname'],
            lastname = json_data['lastname'],
            email = json_data['email'],
            password = json_data['password'],
            username = json_data['username']
        )
        db.session.add(user)
        db.session.commit()

        result = User.serialize(user)

        return {'status' : 'success', 'data' : result}

        # Create api_key
