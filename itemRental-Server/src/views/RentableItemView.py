import marshmallow
from flask import request, json, Response, Blueprint

from src.models import UserModel
from src.models.RentableItemModel import RentableItemSchema, RentableItemModel, RentableItems, RentableItemsSchema
from src.models.ReviewItemModel import ReviewItems, ReviewItemsSchema

rentableitem_api = Blueprint('rentableitem', __name__)
rentableitem_schema = RentableItemSchema()
rentableitems_schema = RentableItemsSchema()
reviewitems_schema = ReviewItemsSchema()


@rentableitem_api.route('/', methods=['POST'])
def create():
    req_data = request.get_json()
    try:
        data = rentableitem_schema.load(req_data)
    except marshmallow.exceptions.ValidationError as e:
        return custom_response(e.messages, 401)

    rentableitem = RentableItemModel(data)

    user_in_db = UserModel.get_user_by_name(data.get('owner_name'))

    if not user_in_db:
        message = {'error': 'User does not exists exist, please supply another name'}
        return custom_response(message, 400)

    rentableitem.owner_id = user_in_db.id
    rentableitem.owner = user_in_db
    rentableitem.owner_name = user_in_db.name
    rentableitem.save()

    ser_rentableitem = rentableitem_schema.dump(rentableitem)
    return custom_response(ser_rentableitem, 200)


@rentableitem_api.route('/<int:rentableitem_id>', methods=['GET'])
def get_a_rentableitem(rentableitem_id):
    rentableitem = RentableItemModel.get_rentableitem_by_id(rentableitem_id)
    if not rentableitem:
        return custom_response({'error': 'rentable item not found'}, 404)

    ser_rentableitem = rentableitem_schema.dump(rentableitem)
    return custom_response(ser_rentableitem, 200)


@rentableitem_api.route('/', methods=['GET'])
def get_all():
    rentableitems = RentableItemModel.get_all()
    ri = RentableItems(rentableitems)
    ser_rentableitems = rentableitems_schema.dump(ri)
    response = custom_response(ser_rentableitems, 200)
    return response


@rentableitem_api.route('/reviews/<int:rentableitem_id>', methods=['GET'])
def get_all_reviewitems_of_user(rentableitem_id):
    rentableitem = RentableItemModel.get_rentableitem_by_id(rentableitem_id)

    if not rentableitem:
        message = {'error': 'Rentable item does not exists exist, please supply another id'}
        return custom_response(message, 400)

    reviewitems = rentableitem.reviews
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
