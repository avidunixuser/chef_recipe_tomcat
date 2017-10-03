# tomcat

TODO: Enter the cookbook description here.

- Create a Repo

$ chef generate repo workshop-repo

- Inspect what is in the repo

$ cd workshop-repo

$ ls -la

total 56
drwxr-xr-x  14 user  staff   476 Sep 27 15:58 .
drwxr-xr-x+ 79 user  staff  2686 Oct  2 20:32 ..
-rw-r--r--@  1 user  staff  6148 Sep 27 12:40 .DS_Store
-rw-r--r--   1 user  staff   255 Sep 27 11:52 .chef-repo.txt
drwxr-xr-x  10 user  staff   340 Oct  2 20:32 .git
-rw-r--r--   1 user  staff  2121 Sep 27 11:52 .gitignore
-rw-r--r--   1 user  staff    70 Sep 27 11:52 LICENSE
-rw-r--r--   1 user  staff  1499 Sep 27 11:52 README.md
-rw-r--r--   1 user  staff  1133 Sep 27 11:52 chefignore
drwxr-xr-x   4 user  staff   136 Sep 27 11:52 cookbooks
drwxr-xr-x   4 user  staff   136 Sep 27 11:52 data_bags
drwxr-xr-x   4 user  staff   136 Sep 27 11:52 environments
drwxr-xr-x   4 user  staff   136 Sep 27 14:23 roles

- Generate a cookbook for tomcat

$ chef generate cookbook tomcat

$ ls -ld tomcat 

drwxr-xr-x  17 user  staff   578 Oct  2 20:32 tomcat

- Generate a configurable port to change it if tomcat cannot run on port 8080

$ chef generate attribute tomcat port

$ cd tomcat

- Generate a recipe to use server.rb script rather than default.rb

$ chef generate recipe server

- Generate a template to provide parameters for tomcat to start as a service

$ chef generate template tomcat.service.erb

- Files to inspect

tomcat/.kitchen.yml - apwxidy driver and platform in particular
tomcat/recipes/server.rb - default recipe to install the required components
tomcat/spec/unit/recipes/server_spec.rb - sanity check to ensure prerequisites
tomcat/templates/tomcat.service.erb - template with all the environment variables, java and tomcat runtime input parameters
tomcat/attributes/port.rb - custom/configurable port for tomcat in case 8080 is busy

Rest of the files under tomcat directory are untouched.

- Execute the bookbook - be in a tomcat directory or

$ cd tomcat
$ kitchen converge

To test the running state of tomcat server

$ kitchen verify

-----> Starting Kitchen (v1.17.0)
-----> Verifying <default-centos-73>...
       Loaded tests from test/smoke/default 

Profile: tests from test/smoke/default
Version: (not specified)
Target:  ssh://vagrant@127.0.0.1:2200


  User root
     ↺  
  Port 80
     ↺  
  User root
     ↺  
  Port 80
     ↺  
  Port 8080
     ✔  should be listening

Test Summary: 1 successful, 0 failures, 0 skipped
       Finished verifying <default-centos-73> (0m0.40s).


$ kitchen exec -c 'curl localhost:8080'

The above command will execute the jsp from /opt/tomcat/webapps/manager/WEB-INF/jsp from the VM image.
To login to VM image, execute 

$ kitchen login
$ su
<super user passwd is vagrant>

Then follow the file path given above.

This concludes the creation and execution of a Chef cookbook to install Tomcat 8.5.23 with openjdk-1.8.0

Thank you and happy cooking! :)
