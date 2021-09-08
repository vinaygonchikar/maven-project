Step 1

Create First Job and name as 'anatomy'  (Freestyle)

Fork into your repo

https://github.com/nramnad/maven-project.git

SCM Section :

Select Git option and supply GitHub URL

At Build Section

Select invoke top-level Maven Targets

Goal : clean package
______________________________________________________________________________________________
Step 2

Run Job Manually

- Click Build Now

After build has completed

- Go to Workspace, you get directory structure
________________________________________________________________________________________
Ignore Step 3

Step 3
Code Quality and Quality metrics

Install Checkstyle plugin

At Build section, add checkstyle:checkstyle
Goals should be clean package checkstyle:checkstyle

At Post Build Section

Select Publish checkstyle analysis results

Now, trigger the job now

Go to main page the build, you get new menu called "Checkstyle Warnings"

Upon clicking Checkstyle Warnings, you get Checkstyle Result

_________________________________________________________________________________________
Step 4
Archive Generated artifacts

Deploy artifacts to staging environments

Go to Post Build Actions

Select Archive the artifacts (Plugin is artifact deployer)

Files to archive : **/*.war

After run the job, go to build main page, 
	jenkins has generated Build artifacts file for us which is webapp.war

Go to console output, jenkins is archiving artifacts
____________________________________________________________________________________
Step 5

Install and Configure Tomcat as a staging environment

- Archive artifacts needs to be deployed at container

Install copy artifact and deploy to container plugin

Deploy our application at Staging

- Create new job name as package and select copy from anatomy
- Save package job
___________________________________________________________________________________________________________

Step 5A

Now, create a new job for deploy artifacts tomcat

Create new job name as deploy-to-staging (Freestle project)

At Build Section, select

-	copy artifacts from other projects, choose package job (Previous job)
	Go to Plugin Page download "Copy Artifact" Plugin
-	Artifacts to copy : **/*.war

Post Bulid Action
	
-	select Deploy war/ear/ to a container : **/*.war
-	at container, select Tomcat 7 or 8 
-	Provide Tomcat username and Password
-	At Tomcat URL, << Enter Tomcat URL >> (local host or cloud public DNS)

Save deploy-to-staging job

_________________________________________________________________________________________________________________________

Step 5B

Go to Package job configuration

At Post Build section,
-	select build other project deploy-to-staging

Time for deploy

First, trigger upstream job of package

After completion package job, system automatically trigger deploy-to-staging job

Automatically triggered, if upstream job package job got success

Now, time for getting results

Go to browser, << Enter Tomcat URL with port number >>

You get the output

__________________________________________________________________________________________

Step 6

Jenkins Build Pipeline

Install build pipeline plugin

Go to Jenkins Home Page and select + button

You get new viewn and name as build pipeline

Select Build Pipeline view

-	One important things you need to be considered is new job
-	Select initial job package
-	Leave other fields default
-	After ok, you can get pipeline view
-	By visually, you can see up and downstream job
-	For refreshing, click run button
___________________________________________________________________________________________
Step 7

Parallel Jenkins Build

Create a new job as static-analysis (freestyle)

-	Supply URL of Package Job GitHub Repo

At Build Section
-	Invoke top-level Maven target
-	Goals : package

Save static-analysis job


-	We would like to trigger this job as soon as package job successful

-	Go to Package job configuration
-	At Post Build Section
-	Build other projects
-	Project to build, static-analysis job along with deploy-to-staging

-	Go to Build Pipeline view
-	Static Analysis job has added in the pipeline

-	Refresh Run 

____________________________________________________________________________________________

Step 8

Deploy to Production

-	Go to Tomcat Configuration folder and add new port of 9090 at Server.xml
-	Configure accordingly (Keep port number as 9090)



Create a new job as deploy-to-prod

At Build Section

-	Select Copy artifacts from other projects
-	Project name : package

-	Artifacts to copy : **/*.war

At Post Build Action

-	Select Deploy war/ear to a container
-	WAR / EAR File : **/*.war
-	Container : Select Tomcat 7 or 8
-	Supply Tomcat username, Password and Tomcat URL

Save deploy-to-prod job

Go to Deploy-to-staging configuration page

At Post Build Action

-	Select Build other projects (manual step)
-	Downstream Project Name : deploy-to-prod

Go to Build Pipeline view

-	Deploy-to-prod job has added in the build pipeline view
-	Refresh Pipeline
-	Go to browser for getting output

___________________________________________________________________________________

