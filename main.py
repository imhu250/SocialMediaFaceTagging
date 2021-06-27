from flask import Flask
from public import public
from admin import admin
from users import users

app=Flask(__name__)
app.secret_key="sdfgh"

app.register_blueprint(public)
app.register_blueprint(admin,url_prefix='/admin')
app.register_blueprint(users,url_prefix='/users')

app.run(debug='true',port=5014)

