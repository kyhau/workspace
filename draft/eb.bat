@ECHO OFF

docker build -t docker.example.com/my_app .

docker run -d -p 8080:8080 docker.example.com/my_app:latest

zip -r app.zip my_app env setup.py *.ini Dockerfile Dockerrun.aws.json constraints.txt MANIFEST.in

:: Show all solution stacks
aws elasticbeanstalk list-available-solution-stacks
