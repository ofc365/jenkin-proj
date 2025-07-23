# jenkins-proj (Freestyle)
---------------------------------


### Step 1: Install Java , Jenkins


```
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
jenkins --version
```

Access Jenkins: `http://<your-ec2-public-ip>:8080`


### Step 2: Install Web Server on EC2

```
sudo apt update
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx
```

```
sudo chown -R jenkins:jenkins /var/www/html
```

### Step 3: Create Freestyle Project in Jenkins


Project Name = `deploy-html-webapp`

Source Code Management = Git

Repo URL = `https://github.com/ofc365/jenkin-proj.git` and generate passcode

Execute shell > Shell script:

```
echo "Deploying HTML WebApp to Nginx"
cp index.html /var/www/html/
```

Save and click Build Now

### Step 4: Access Your App

Visit in browser: `http://<EC2-public-IP>`


(If you want to set up automation, set-up github jenkins integration)


=======


# jenkins-proj (Freestyle - on Docker)
------------------------------------------------


```
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```


Execute shell (remove old and update new) > Shell Script:

```
echo "Building and Deploying Docker Container for HTML WebApp"
docker rm -f htmlweb || true
docker build -t htmlweb-img .
docker run -d -p 80:80 --name htmlweb htmlweb-img
```

NB = IF PORT ERROR

`sudo lsof -i :80`

```
sudo systemctl stop apache2
sudo systemctl stop nginx 
sudo systemctl disable apache2
sudo systemctl disable nginx
```

OR

Use different port

### Step 3: Access Your App

Visit in browser: `http://<EC2-public-IP>:80`

(If you want to set up automation, set-up github jenkins integration but Have to terminate old container)


.................


## Freestyle project on Docker-compose


```
sudo apt update
sudo apt install docker-compose -y
```

Execute shell (remove old and update new) > Shell Script:

```
docker-compose down || true
docker-compose up -d --build
```


Visit in browser: `http://<EC2-public-IP>:8080`

(If you want to set up automation, set-up github jenkins integration but Have to terminate old container)


............................

# jenkins-proj (Pipeline)

NB :- Delete previous containers if any

`sudo docker kill <container name>`

`sudo docker rm <container name>`

or

`sudo docker stop <container name>`

`sudo docker rm <container name>`


### Step 1: Setup Jenkins Pipeline Job

Go to Jenkins Dashboard > Click New Item

Choose Pipeline

Name: html-pipeline-deploy

Repo: `https://github.com/ofc365/jenkin-proj.git`

Script Path: Use Jenkinsfile (default name)

Click Save, then click Build Now

### Step 3: Access Your App

Visit in browser: `http://<EC2-public-IP>:8082`

(If you want to set up automation, set-up github jenkins integration but Have to terminate old container)

-----------------------------------------------------------
