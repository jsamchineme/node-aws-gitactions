### Guide
https://github.com/felixyu9/nodejs-express-on-aws-ec2

### Steps
- Create repo and host on github
- Create the scripts folder with the application_start.sh, application_stop.sh, before_install.sh.
- create the appspec. ENSURE to arrange hooks in the right order - `BeforeInstall`, `ApplicationStop`, `ApplicationStart`.
- setup application code.
- Create Roles: Go to IAM on AWS console and do the following
  - Create a New Role selecting _AWS Service_ as type of trusted entity
  - Choose EC2 as _Use Case_
  - Add permissions: _AmazonEC2RoleforAWSCodeDeploy_
  - enter role name: _EC2CodeDeployRole_
  - Create another New Role selecting _AWS Service_ as type of trusted entity
  - Choose _CodeDeploy_ as _Use Case_
  - Add permissions: _AmazonCodeDeployRole_
  - enter role name: _CodeDeployRole_
- Create EC2 instance
  - Select a Linux AMI
  - On _Configure Instance_ Tab, change IAMRole to _EC2CodeDeployRole_
  - Paste the code below into the user data field
  - For security group, configure port 80, and 3000 to accept all incoming request.

  ```bash
  #!/bin/bash
  sudo yum -y update
  sudo yum -y install ruby
  sudo yum -y install wget
  cd /home/ec2-user
  wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
  sudo chmod +x ./install
  sudo ./install auto
  ```

- Connect CodeDeploy to Github
  - Launch CodeDeploy on the Console.
  - Goto Application and create a new application
  - Enter name and select _EC2/On-premise_ as the compute platform
  - Proceed to deployment groups
  - select  _CodeDeployRole_ 
  - use in-place deployment type
  - add instances
  - create deployment group
  - Go to Code Pipeline
  - Create a new pipeline
  - Connect to github
  - select repo and branch
  - _skip build stage_
  - For _Deploy Provider_, choose AWS CodeDeploy
  - create pipeline
  