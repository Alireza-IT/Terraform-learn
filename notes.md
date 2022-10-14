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


with modules = container for multiple resources used together
logical grouping and we can use them many times
we can paramerterise the configuration 
module is like writing the function , we have input and output 
use module when we want to froup resources to one single logical group 
like vpc need subnet and ingw and etc.
there are already module created by someone else 

in terraform registry --> modules and search the list of that
dependency is about if it's included the list of other moule or not and install them by terrafrom init

create module in project.many resources in main.tf
end up with this infrs:
main.tf
variables.tf
providers.tf
output.tf
no need to link the files together.we have cross reference here
each modules has it's own variables and main and output.tf files

naming is standard!

creating module should group multiple resources 

use output.tf in module as return value 

whenever we are doing module or changes in module we have to do the terraform init

store state in somewhere anyone can access to it
by use terraform in main.tf which is included metadata
do not forget to do the terraform init after that all data in local tfstate is stored in the remote side
