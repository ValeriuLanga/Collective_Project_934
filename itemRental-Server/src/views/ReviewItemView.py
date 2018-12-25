from flask import request, json, Response, Blueprint
from src.models import UserModel
from src.models.RentableItemModel import RentableItemModel
from ..models.ReviewItemModel import ReviewItemModel, ReviewItemSchema


review_api = Blueprint('review', __name__)
review_schema = ReviewItemSchema()


@review_api.route('/', methods=['POST'])
def create():
    req_data = request.get_json()

    data = review_schema.load(req_data)

    review = ReviewItemModel(data)

    user_in_db = UserModel.get_user_by_name(data.get('owner_name'))
    rentableitem_in_db = RentableItemModel.get_rentableitem_by_id(data.get('rentableitem_id'))

    if not user_in_db:
        message = {'error': 'User does not exists exist, please supply another name'}
        return custom_response(message, 400)

    if not rentableitem_in_db:
        message = {'error': 'Rentable item does not exists exist, please supply another id'}
        return custom_response(message, 401)

    review.owner_id = user_in_db.id
    review.owner = user_in_db
    review.owner_name = user_in_db.name
    review.rentableitem = rentableitem_in_db
    review.rentableitem_id = rentableitem_in_db.id

    review.save()

    ser_review = review_schema.dump(review)
    return custom_response(ser_review, 200)


def custom_response(res, status_code):
    """
    Custom Response Function
    """
    return Response(
        mimetype="application/json",
        response=json.dumps(res),
        status=status_code
    )
