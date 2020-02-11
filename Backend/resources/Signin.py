from flask_restful import Resource
from flask import request
from models import db, User
import random
import string

class Signin(Resource):
    
    def post(self):
        result = ""
        # Get username, email, password
        json_data = request.get_json(force=True)
        header = request.headers["Authorization"]

        if not header:
            result = self.username_and_password_signin(json_data)
        else:
            print(header)
            user = User.query.filter_by(api_key=header).first()
            if user:
                result = User.serialize(user)
            else:
                result = self.username_and_password_signin(json_data)

        return {'status' : 'success', 'data' : result}, 201
    
    def username_and_password_signin(self, json_data):
        # Check if was type an username
        if not json_data:
            return {'message' : 'No imput data provide'}, 400


        # Check if username exist
        user = User.query.filter_by(username=json_data['username']).first()
        if not user:
            return {'message' : 'Username does not exist'}, 400
            
        # Check password 
        if user.password != json_data['password']:
            return {'message' : 'Incorrect Passwor try again'}, 400

        return User.serialize(user)

    # Create api_key
    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(50))
