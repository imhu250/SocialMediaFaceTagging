from flask import Blueprint,request,render_template,redirect,url_for,session,flash
from database import *
from core import *
users=Blueprint("users",__name__)

 
@users.route('/userhome')
def userhome():
	data={}
	q="select * from post inner join images using(image_id) where users_id=(select user_id from users where login_id='%s')" %(session['logid'])
	res=select(q)
	data['post']=res
	return render_template("userhome.html",data=data)

@users.route('/viewusers')
def viewusers():
	data={}

	if 'uid' in request.args:
		uid=request.args['uid']
		q="insert into requests values(null,(select user_id from users where login_id='%s'),'%s',curdate(),'NA')" %(session['logid'],uid)
		insert(q)
		flash("Request Send")
	q="SELECT *,CONCAT(fname,' ',lname) AS names FROM users WHERE user_id NOT IN(SELECT IF(`sender_id`=(select user_id from users where login_id='%s'), `receiver_id`, `sender_id`) AS uid FROM requests WHERE sender_id=(select user_id from users where login_id='%s') OR receiver_id=(select user_id from users where login_id='%s')) AND user_id!=(select user_id from users where login_id='%s')" %(session['logid'],session['logid'],session['logid'],session['logid'])
	res=select(q)
	data['users']=res
	return render_template("userviewuser.html",data=data)

@users.route('/viewrequest')
def viewrequest():
	data={}
	if 'action' in request.args:
		action=request.args['action']
		rid=request.args['rid']
	else:
		action=None
	if action =="accept":
		q="update requests set status='Accept' where request_id='%s'" %(rid)
		update(q)
		q="select * from requests where request_id='%s'" %(rid)
		res=select(q)
		q="insert into friends values(null,'%s','%s')" %(res[0]['sender_id'],res[0]['receiver_id'])
		insert(q)
		flash("Accepted")
		return redirect(url_for('users.viewrequest'))
	if action =="reject":
		q="delete from requests where request_id='%s'" %(rid)
		delete(q)
		flash("Rejected")
		return redirect(url_for('users.viewrequest'))

	q="SELECT *,concat(fname,' ',lname) as names FROM requests INNER JOIN users ON users.user_id=requests.`sender_id` WHERE  receiver_id = (select user_id from users where login_id='%s')" %(session['logid'])
	print(q)
	res=select(q)
	data['viewusersrequested']=res
	return render_template("userviewrequest.html",data=data)

@users.route('/uploadimage',methods=['post','get'])
def uploadimage():
	data={}
	if 'submit' in request.form:
		lid=session['logid']
		# q="select "
		image=request.files['newimage']
		path="static/uploads/"+str(uuid.uuid4())+image.filename
		image.save(path)
		val(path,session['logid'])
		
		flash('Added successfully...')
		return redirect(url_for('users.uploadimage'))
	data={}
	q="select * from  images where user_id=(select user_id from users where login_id='%s')" %(session['logid'])
	res=select(q)
	data['users']=res
	return render_template("newuploadimage.html",data=data)

@users.route('/userviewtaggedusers')
def userviewtaggedusers():
	data={}
	imid=request.args['imid']
	q="select *,concat(fname,' ',lname) as names from users where user_id in (select user_id from imageusers where image_id='%s')" %(imid)
	res=select(q)
	data['users']=res
	return render_template("userviewtaggedusers.html",data=data)


@users.route('/userviewuploadedimages')
def userviewuploadedimages():
	data={}
	lid=session['logid']
	if "action" in request.args:
		action=request.args['action']
		rid=request.args['rid']
	else:
		action=None

	if action=="accept":
		q="update imageusers set status='Upload' where image_user_id='%s'" %(rid)
		update(q)
		q1="insert into post values(null,(select image_id from imageusers where image_user_id='%s'),(select user_id from users where login_id='%s'))" %(rid,lid)
		insert(q1)
	if action=="reject":
		q="update imageusers set status='NA' where image_user_id='%s'" %(rid)
		update(q)

	q="SELECT *,CONCAT(fname,' ',lname) AS names,imageusers.status as statuss FROM imageusers INNER JOIN images USING(`image_id`) inner join users on users.user_id=images.user_id where imageusers.user_id=(select user_id from users where login_id='%s')" %(lid)
	res=select(q)
	print(res)
	data['users']=res
	return render_template("userviewuploadedimages.html",data=data)


@users.route('/userviewuserdetails')
def userviewuserdetails():
	data={}
	uid=request.args['uid']
	q="select *,concat(fname,' ',lname) as names from users where user_id='%s'" %(uid)
	res=select(q)
	data['users']=res
	return render_template("userviewuserdetails.html",data=data)



@users.route('/Viewfriends')
def Viewfriends():
	data={}
	lid=session['logid']

	q="SELECT *,concat(fname,' ',lname) as names FROM users where user_id IN (SELECT IF(userid1=(select user_id from users where login_id='%s'),userid2,userid1) AS userid FROM `friends` WHERE  userid1=(select user_id from users where login_id='%s') OR userid2=(select user_id from users where login_id='%s'))" %(lid,lid,lid)
	print(q)
	res=select(q)
	data['viewfriends']=res
	return render_template("userviewfriends.html",data=data)