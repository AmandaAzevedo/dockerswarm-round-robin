from flask import Flask
import os
import socket

app = Flask(__name__)

@app.route('/')
def hello():
	return 'Hello World I am %s and my IP is %s.\n'%(socket.gethostname(),howMyIp())

def howMyIp():
	os.system("curl ifconfig.me >> my_ip.txt")
	file = open('my_ip.txt','r')
	my_ip=""
	for line in file:
		x = line.strip()
		my_ip=x
	file.close()
	os.system("echo "" > my_ip.txt")
	return my_ip

app.run(port=8080, host="0.0.0.0", debug=True)
