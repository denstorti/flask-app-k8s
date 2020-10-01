run_docker: build
	docker run -it --rm -p 5000:5000 denstorti/app_flask:0.1
	
build:
	docker build -t denstorti/app_flask:0.1 .

deploy:
	kubectl apply -f k8s/deployment.yaml
	kubectl apply -f k8s/service.yaml

# service IP: 10.100.107.107
# Nodes:
	# - 192.168.99.100
	# - 192.168.99.101

# NODEPORT IP + NODEPORT PORT
# http://192.168.99.100:30727/