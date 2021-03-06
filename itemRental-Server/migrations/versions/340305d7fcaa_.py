"""empty message

Revision ID: 340305d7fcaa
Revises: ffe06f85363a
Create Date: 2019-01-18 21:58:44.661157

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '340305d7fcaa'
down_revision = 'ffe06f85363a'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('rentperiod',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('start_date', sa.Date(), nullable=True),
    sa.Column('end_date', sa.Date(), nullable=True),
    sa.Column('rentableitem_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['rentableitem_id'], ['rentableitem.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('rentperiod')
    # ### end Alembic commands ###
