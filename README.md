# jenkin-proj (freestyle)


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
