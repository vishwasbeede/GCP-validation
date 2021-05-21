########################################################################################################################
#Used to parse test validation inputs
#inputs are created in YAML files inside files directory of profile 
 
 yamlcontent=inspec.profile.file("inputs.yml")
 yamlparams = YAML.load(yamlcontent)

 project_name = yamlparams['gcp_project_name']
 network_vpc_names = yamlparams['network_vpc_name']
 subnet_ips = yamlparams['gcp_subnet_ips']
 subnet_names = yamlparams['gcp_subnet_names']


#######################################################################################################################

  control "gcp-subnets-projects" do                                                     
    impact 1.0                                                                          
    title "Ensure input file updated with subnet masks and subnet ip addresses."                         
    desc "Validation of subnets and subnet names"

	subnet_names.zip(subnet_ips).each do |subnet_name,subnet_ip|
	 describe google_compute_subnetwork(project: project_name,region: 'europe-west2',name: subnet_name) do
   	    it { should exist }
	    its('ip_cidr_range') { should eq subnet_ip }
	 end
        end
  end


######################################################################################################################
#describe google_compute_network(project: 'chef-inspec-gcp',  name: 'gcp-inspec-network') do
#  it { should exist }
#end

