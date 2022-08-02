some time you have run script or cmd om servers which is provisioned by terraform 
 terraform does not have any control on what happen next and if cmd is failed terraform wont tell us anythings 
 event though we can pass the data to configure the server but not on control 
 terraform use provisioners to run and pass those data and command and script

if you want ot run cmd remotely use configuration management tools like ansible and puppet
once server provisioned.hand over to those tools
config manager has more visible and control flow
or use local_file providers
run script from CI/CD tool instead of terraform 

if provisioner is failed ,terraform taint the resource to be failed and you have to recreate the resource again