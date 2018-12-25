from . import db
from marshmallow import fields, Schema


class RentableItemModel(db.Model):
    __tablename__ = 'rentableitem'

    id = db.Column(db.Integer, primary_key=True)
    category = db.Column(db.String)
    usage_type = db.Column(db.String)
    start_date = db.Column(db.DateTime)
    end_date = db.Column(db.DateTime)
    receiving_details = db.Column(db.String)
    item_description = db.Column(db.String)
    owner_name = db.Column(db.String)
    owner = db.relationship("UserModel", back_populates="rentableitems")
    owner_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    reviews = db.relationship("ReviewItemModel", back_populates="rentableitem")

    def __init__(self, data):
        self.category = data.get("category")
        self.usage_type = data.get("usage_type")
        self.receiving_details = data.get("receiving_details")
        self.item_description = data.get("item_description")
        self.start_date = data.get('start_date')
        self.end_date = data.get('end_date')

    def save(self):
        db.session.add(self)
        db.session.commit()

    def delete(self):
        db.session.delete(self)
        db.session.commit()

    @staticmethod
    def get_rentableitem_by_id(value):
        return RentableItemModel.query.filter_by(id=value).first()

    @staticmethod
    def get_all():
        return RentableItemModel.query.all()


class RentableItemSchema(Schema):
    id = fields.Integer()
    category = fields.Str()
    usage_type = fields.Str()
    start_date = fields.DateTime('%b %d %Y %I:%M%p')
    end_date = fields.DateTime('%b %d %Y %I:%M%p')
    receiving_details = fields.String()
    item_description = fields.String()
    owner_name = fields.String()


class RentableItems:
    def __init__(self, rentableitems):
        self.rentableitems = rentableitems


class RentableItemsSchema(Schema):
    rentableitems = fields.Nested(RentableItemSchema, many=True)
