from flask import request, json, Response, Blueprint

from src.models.RentableItemModel import RentableItems, RentableItemsSchema
from src.models.ReviewItemModel import ReviewItems, ReviewItemsSchema
from ..models.UserModel import UserModel, UserSchema

user_api = Blueprint('user', __name__)
user_schema = UserSchema()
rentableitems_schema = RentableItemsSchema()
reviewitems_schema = ReviewItemsSchema()


@user_api.route('/', methods=['POST'])
def create():
    req_data = request.get_json()

    data = user_schema.load(req_data)

    user_in_db = UserModel.get_user_by_name(data.get('name'))
    if user_in_db:
        message = {'error': 'User already exist, please supply another name'}
        return custom_response(message, 400)

    user = UserModel(data)
    user.save()
    ser_users = user_schema.dump(user)
    return custom_response(ser_users, 200)


@user_api.route('/login', methods=['POST'])
def login():
    req_data = request.get_json()

    data = user_schema.load(req_data, partial=True)

    if not data.get('name') or not data.get('password'):
        return custom_response({'error': 'you need email and password to sign in'}, 400)
    user = UserModel.get_user_by_name(data.get('name'))
    if not user:
        return custom_response({'error': 'Invalid credentials'}, 400)
    if not user.check_hash(data.get('password')):
        return custom_response({'error': 'Invalid credentials'}, 400)
    ser_data = user_schema.dump(user)
    return custom_response(ser_data, 200)


@user_api.route('/rentableitems/<string:user_name>', methods=['GET'])
def get_all_rentableitems_of_user(user_name):
    user = UserModel.get_user_by_name(user_name)

    if not user:
        message = {'error': 'User does not exists exist, please supply another name'}
        return custom_response(message, 400)

    rentableitems = user.rentableitems
    ri = RentableItems(rentableitems)
    ser_rentableitems = rentableitems_schema.dump(ri)
    response = custom_response(ser_rentableitems, 200)
    return response


@user_api.route('/reviews/<string:user_name>', methods=['GET'])
def get_all_reviewitems_of_user(user_name):
    user = UserModel.get_user_by_name(user_name)

    if not user:
        message = {'error': 'User does not exists exist, please supply another name'}
        return custom_response(message, 400)

    reviewitems = user.reviews
    ri = ReviewItems(reviewitems)
    ser_reviewitems = reviewitems_schema.dump(ri)
    response = custom_response(ser_reviewitems, 200)
    return response


def custom_response(res, status_code):
    """
    Custom Response Function
    """
    return Response(
        mimetype="application/json",
        response=json.dumps(res),
        status=status_code
    )
