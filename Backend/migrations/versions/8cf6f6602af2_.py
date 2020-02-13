"""empty message

Revision ID: 8cf6f6602af2
Revises: 41b8a7a69884
Create Date: 2020-02-13 06:52:27.165146

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '8cf6f6602af2'
down_revision = '41b8a7a69884'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('tasks', sa.Column('title', sa.String(), nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('tasks', 'title')
    # ### end Alembic commands ###
