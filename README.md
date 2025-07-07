# jenkins-proj (freestyle)

## Freestyle project on Instance

### Step 1: 

Launch EC2 Instance(ubuntu)

Instance Type: t2.micro

Key Pair: abc.pem

Security Group: Allow SSH (22), HTTP (80), Jenkins (8080)

### Step 2: Install Java , Jenkins

SSH into EC2 and run:

```
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
```

```
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

Unlock using `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`


### Step 3: Install Web Server on EC2

```
# Update the package list
sudo apt update

# Install NGINX
sudo apt install nginx -y

# Enable and start NGINX service
sudo systemctl enable nginx
sudo systemctl start nginx

# Check status (optional)
sudo systemctl status nginx
```

```
sudo chown -R jenkins:jenkins /var/www/html
```

### Step 4: Create Freestyle Project in Jenkins

Open Jenkins

New Item > Freestyle Project

Project Name: `deploy-html-webapp`

Source Code Management --- Git

Repo URL: `https://github.com/ofc365/jenkin-proj.git` and generate passcode

Build Steps > Add build step > Execute shell

Shell script:

```
echo "Deploying HTML WebApp to Nginx"
cp index.html /var/www/html/
```

Save and click Build Now

### Step 5: Access Your App

Visit in browser: `http://<EC2-public-IP>`

You should see:
"Welcome to Jenkins Deployed WebApp!"


(If you want to set up automation, set-up github jenkins integration)


.................


## Freestyle project on Docker

### Step 1: Install Docker on Your EC2 Ubuntu


```
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Add Jenkins user to Docker group
sudo usermod -aG docker jenkins

# Restart Jenkins to apply group changes
sudo systemctl restart jenkins
```

### Step 2: Jenkins Freestyle Project Configuration

Go to Jenkins

Build > Add build step > Execute shell (remove old and update new)

Shell Script:

```
echo "Building and Deploying Docker Container for HTML WebApp"

# Remove old container if it exists
docker rm -f htmlweb || true

# Build Docker image
docker build -t htmlweb-img .

# Run container on port 80
docker run -d -p 80:80 --name htmlweb htmlweb-img
```

NB = IF PORT ERROR

`sudo lsof -i :80`

```
sudo systemctl stop apache2    # if Apache is running
sudo systemctl stop nginx      # if NGINX is running

# Optional: disable to prevent restart on reboot
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

### Step 1: Install Docker-compose on Your EC2 Ubuntu


```
sudo apt update
sudo apt install docker-compose -y
```

### Step 2: Jenkins Freestyle Project Configuration

Go to Jenkins

Build > Add build step > Execute shell (remove old and update new)

Shell Script:

```
echo "Deploying using Docker Compose..."

# Stop any previous container
docker-compose down || true

# Build and start the container
docker-compose up -d --build
```

### Step 3: Access Your App

Visit in browser: `http://<EC2-public-IP>:8080`

(If you want to set up automation, set-up github jenkins integration but Have to terminate old container)


............................

# jenkins-proj (Pipeline)

NB :- Delete previous containers if any

`sudo docker kill <container name>`


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
