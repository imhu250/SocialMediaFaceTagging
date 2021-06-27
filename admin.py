from flask import Blueprint,request,render_template,redirect,url_for,session,flash
from database import *
from core import *
admin=Blueprint("admin",__name__)

 
@admin.route('/adminhome')
def adminhome():
	return render_template("adminhome.html")

@admin.route('/viewuser')
def viewuser():
	data={}
	q="select *,concat(fname,' ',lname) as names from users"
	res=select(q)
	data['users']=res
	return render_template("adminviewusers.html",data=data)


@admin.route('/viewuploadedimages')
def viewuploadedimages():
	data={}
	q="select *,concat(fname,' ',lname) as names from users inner join images using(user_id)"
	res=select(q)
	data['users']=res
	return render_template("adminviewuploadedimages.html",data=data)

@admin.route('/viewtaggedusers')
def viewtaggedusers():
	data={}
	imid=request.args['imid']
	q="select *,concat(fname,' ',lname) as names from users where user_id in (select user_id from imageusers where image_id='%s')" %(imid)
	res=select(q)
	data['users']=res
	return render_template("adminviewtaggedusers.html",data=data)
