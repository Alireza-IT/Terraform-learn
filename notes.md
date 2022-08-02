some time you have run script or cmd om servers which is provisioned by terraform 
 terraform does not have any control on what happen next and if cmd is failed terraform wont tell us anythings 
 event though we can pass the data to configure the server but not on control 
 terraform use provisioners to run and pass those data and command and script
