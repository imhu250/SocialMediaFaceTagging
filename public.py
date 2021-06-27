from flask import Blueprint,request,render_template,redirect,url_for,session,flash
from database import *
from core import *
public=Blueprint("public",__name__)

 
@public.route('/')
def home():
	return render_template("index.html")


@public.route('/log',methods=['post','get'])
def log():
	if 'login' in request.form:
		uname=request.form['username']
		pwd=request.form['password']
		q="select * from login where username='%s' and password='%s'"%(uname,pwd)
		res=select(q)
		if res:
			session['logid']=res[0]['logid']
			if res[0]['usertype']=="admin":
				return redirect(url_for("admin.adminhome"))
			if res[0]['usertype']=="user":
				return redirect(url_for("users.userhome"))
		else:
			flash("Invalid Username and Password")
	return render_template("login.html") 

@public.route('/reg',methods=['post','get'])
def reg():
	if 'submit' in request.form:
		print("Haii")
		f=request.form['fname']
		l=request.form['lname']
		g=request.form['gender']
		p=request.form['place']
		ph=request.form['phone']
		e=request.form['email']

		pimage=request.files['pimage']
		path="static/profilepic/"+str(uuid.uuid4())+pimage.filename
		pimage.save(path)

		u=request.form['username']
		pa=request.form['password']

		q="insert into login values(null,'%s','%s','user')"%(u,pa)
		id=insert(q)
		q="insert into users values(null,'%s','%s','%s','%s','%s','%s','%s','%s')"%(id,f,l,ph,e,p,g,path)
		id=insert(q)
		path=""
		# Check whether the   
		# specified path is   
		# an existing file 
		pid=str(id)
		isFile = os.path.isdir("static/trainimages/"+pid)  
		print(isFile)
		if(isFile==False):
			os.mkdir('static\\trainimages\\'+pid)
		image1=request.files['image1']
		path="static/trainimages/"+pid+"/"+str(uuid.uuid4())+image1.filename
		image1.save(path)

		image2=request.files['image2']
		path="static/trainimages/"+pid+"/"+str(uuid.uuid4())+image2.filename
		image2.save(path)

		image3=request.files['image3']
		path="static/trainimages/"+pid+"/"+str(uuid.uuid4())+image3.filename
		image3.save(path)
		enf("static/trainimages/")
		
		flash('Added successfully...')
	return render_template("registration.html")

