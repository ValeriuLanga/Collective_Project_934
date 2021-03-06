import os

import marshmallow
from flask import request, json, Response, Blueprint, send_file

from src.models import UserModel, db
from src.models.RentPeriodModel import RentPeriodSchema, RentPeriodModel
from src.models.RentableItemModel import RentableItemSchema, RentableItemModel, RentableItems, RentableItemsSchema
from src.models.ReviewItemModel import ReviewItems, ReviewItemsSchema, ReviewItemModel

rentableitem_api = Blueprint('rentableitem', __name__)
rentableitem_schema = RentableItemSchema()
rentableitems_schema = RentableItemsSchema()
reviewitems_schema = ReviewItemsSchema()
rentperiod_schema = RentPeriodSchema()


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

    if rentableitem.category not in RentableItemModel.categoryTypes:
        message = {'error': 'Category does not exists exist, please supply another category'}
        return custom_response(message, 400)

    rentableitem.owner_id = user_in_db.id
    rentableitem.owner = user_in_db
    rentableitem.owner_name = user_in_db.name
    rentableitem.rented = False
    rentableitem.save()

    ser_rentableitem = rentableitem_schema.dump(rentableitem)
    return custom_response(ser_rentableitem, 200)


@rentableitem_api.route('/delete/<int:rentableitem_id>', methods=['DELETE'])
def delete(rentableitem_id):
    rentableitem = RentableItemModel.get_rentableitem_by_id(rentableitem_id)
    if not rentableitem:
        return custom_response({'error': 'rentable item not found'}, 404)
    reviews_to_be_deleted = ReviewItemModel.get_all_reviews_with_rentableitem_id(rentableitem.id)
    for r in reviews_to_be_deleted:
        r.delete()
    rentableitem.delete()
    return custom_response("delete succes", 200)


@rentableitem_api.route('/rent/<int:rentableitem_id>', methods=['PUT'])
def rent_item(rentableitem_id):
    req_data = request.get_json()
    data = rentperiod_schema.load(req_data)
    start_date = data.get("start_date")
    end_date = data.get("end_date")
    name = data.get("user_name")

    user = UserModel.get_user_by_name(name)

    if not user:
        message = {'error': 'User does not exists exist, please supply another name'}
        return custom_response(message, 400)
    rentableitem = RentableItemModel.get_rentableitem_by_id(rentableitem_id)

    if not rentableitem:
        return custom_response({'error': 'rentable item not found'}, 404)

    periods_of_rental_of_current_item = RentPeriodModel.get_all_rent_periods_with_rentableitem_id(rentableitem.id)
    for period_of_rental in periods_of_rental_of_current_item:
        if start_date < period_of_rental.end_date and end_date > period_of_rental.start_date:
            return custom_response({'error': 'the item is already rented in that period'}, 404)

    if not (start_date >= rentableitem.available_start_date and end_date <= rentableitem.available_end_date):
        return custom_response({'error': 'the owner does not rent the item in that period'}, 404)

    rent_period = RentPeriodModel(data)
    rent_period.rentableitem = rentableitem
    rent_period.rentableitem_id = rentableitem.id
    rent_period.save()

    rentableitem.rented = True
    db.session.commit()
    return custom_response("rent succes", 200)


@rentableitem_api.route('/return/<int:rentableitem_id>', methods=['PUT'])
def return_item(rentableitem_id):
    rentableitem = RentableItemModel.get_rentableitem_by_id(rentableitem_id)
    if not rentableitem:
        return custom_response({'error': 'rentable item not found'}, 404)
    rentableitem.rented = False
    db.session.commit()
    return custom_response("return succes", 200)


@rentableitem_api.route('/uploadimage/<int:rentableitem_id>', methods=['POST'])
def uploadimage(rentableitem_id):
    rentableitem = RentableItemModel.get_rentableitem_by_id(rentableitem_id)
    if not rentableitem:
        return custom_response({'error': 'rentable item not found'}, 404)
    file = request.files['pic']
    filename = file.filename
    if rentableitem.photo_name is None or rentableitem.photo_name == '':
        rentableitem.photo_name = filename
        db.session.commit()
        file.save(os.path.join(os.getcwd(), 'photos', filename))
        return custom_response("upload succes", 200)
    else:
        if os.path.isfile(os.path.join(os.getcwd(), 'photos', rentableitem.photo_name)) is True:
            return custom_response("this rentable item has already a photo", 404)
        else:
            rentableitem.photo_name = filename
            db.session.commit()
            file.save(os.path.join(os.getcwd(), 'photos', filename))
            return custom_response("upload succes", 200)


@rentableitem_api.route('/downloadimage/<int:rentableitem_id>', methods=['GET'])
def downloadimage(rentableitem_id):
    rentableitem = RentableItemModel.get_rentableitem_by_id(rentableitem_id)
    if not rentableitem:
        return custom_response({'error': 'rentable item not found'}, 404)
    if rentableitem.photo_name is None or rentableitem.photo_name == '':
        return custom_response({'error': 'rentable item does not have a photo'}, 404)
    if os.path.isfile(os.path.join(os.getcwd(), 'photos', rentableitem.photo_name)) is False:
        rentableitem.photo_name = ''
        db.session.commit()
        return custom_response({'error': 'rentable item does not have a photo'}, 404)
    return send_file(os.path.join(os.getcwd(), 'photos', rentableitem.photo_name), as_attachment=True)


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


@rentableitem_api.route('/category/<string:category>', methods=['GET'])
def get_all_by_category(category):
    if category not in RentableItemModel.categoryTypes:
        message = {'error': 'Category does not exists exist, please supply another category'}
        return custom_response(message, 400)

    rentableitems = RentableItemModel.get_all_by_category(category)
    ri = RentableItems(rentableitems)
    ser_rentableitems = rentableitems_schema.dump(ri)
    response = custom_response(ser_rentableitems, 200)
    return response


@rentableitem_api.route('/<string:name>', methods=['GET'])
def get_all_like_name(name):
    rentableitems = RentableItemModel.get_all_like_name(name)
    ri = RentableItems(rentableitems)
    ser_rentableitems = rentableitems_schema.dump(ri)
    response = custom_response(ser_rentableitems, 200)
    return response


@rentableitem_api.route('/categories', methods=['GET'])
def get_categories():
    categories = RentableItemModel.categoryTypes
    response = custom_response({'categories': categories}, 200)
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
