import datetime

from . import db
from marshmallow import fields, Schema


class ReviewItemModel(db.Model):
    __tablename__ = 'review'

    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String)
    rating = db.Column(db.Float)
    posted_date = db.Column(db.DateTime)
    owner = db.relationship("UserModel", back_populates="reviews")
    owner_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    owner_name = db.Column(db.String)
    rentableitem = db.relationship("RentableItemModel", back_populates="reviews")
    rentableitem_id = db.Column(db.Integer, db.ForeignKey('rentableitem.id'))

    def __init__(self, data):
        self.text = data.get('text')
        self.rating = data.get('rating')
        self.posted_date = datetime.datetime.utcnow().strftime('%b %d %Y %I:%M%p')

    def save(self):
        db.session.add(self)
        db.session.commit()

    @staticmethod
    def get_all_reviews_with_rentableitem_id(value):
        return ReviewItemModel.query.filter_by(rentableitem_id=value).all()

    def delete(self):
        db.session.delete(self)
        db.session.commit()


class ReviewItemSchema(Schema):
    text = fields.Str()
    rating = fields.Integer()
    owner_name = fields.Str()
    rentableitem_id = fields.Str()
    posted_date = fields.DateTime('%b %d %Y %I:%M%p')


class ReviewItems:
    def __init__(self, reviewitems):
        self.reviewitems = reviewitems


class ReviewItemsSchema(Schema):
    reviewitems = fields.Nested(ReviewItemSchema, many=True)

