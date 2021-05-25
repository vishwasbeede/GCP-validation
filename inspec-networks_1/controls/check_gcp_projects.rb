########################################################################################################################
#Used to parse test validation inputs
#inputs are created in YAML files inside files directory of profile 
 
 yamlcontent=inspec.profile.file("inputs.yml")
 yamlparams = YAML.load(yamlcontent)

 project_data = yamlparams['Project_data']
 #network_vpc_names = yamlparams['network_vpc_name']
 #subnet_ips = yamlparams['gcp_subnet_ips']
 #subnet_names = yamlparams['gcp_subnet_names']
  
#  puts project_data 

  #project_data.each do | project_name | 
    #     
     #puts "project_name: "+ project_name["project_name"]
     #puts project_name["vpc_name"]
     #puts project_name["region_name"]
     #puts project_name["subnet_name"]
     #puts project_name["subnet_id"]
    # Need to add parts  
   #end 

#######################################################################################################################

  control "gcp-subnets-projects" do                                                     
    impact 1.0                                                                          
    title "Ensure input file updated with subnet masks and subnet ip addresses."                         
    desc "Validation of subnets and subnet names"
    
    project_data.each do | project_name | 
   #Existnce of VPC networks names  

    describe google_compute_network(project: project_name["project_name"], name: project_name[:vpc_name] ) do
        it { should exist }
    end

    describe google_compute_subnetwork(project: project_name["project_name"],region: project_name["region_name"] ,name: project_name["subnet_name"]) do
   	     it { should exist }
	     its('ip_cidr_range') { should eq  project_name["subnet_id"]}
    end

     end

end


######################################################################################################################
