########################################################################################################################
#Used to parse test validation inputs
#inputs are created in YAML files inside files directory of profile 
 
 yamlcontent=inspec.profile.file("inputs.yml")
 yamlparams = YAML.load(yamlcontent)

 yamlproj = yamlparams['gcp_project_id']
 yamlproj_no= yamlparams['gcp_project_no'] 



#######################################################################################################################

 control "gcp-regions-loop-1.0" do                                                  
   impact 1.0                                                                         
     title " Tseting available GCP projects with project number."                      

   # google_projects.project_ids.each do |gcp_project_id|  # Loop across all regions by name

   yamlproj.zip(yamlproj_no).each do |gcp_project_id,gcp_proj_no|   
       describe google_project(project: gcp_project_id) do
         it { should exist }
         its('project_number'){ should be == gcp_proj_no }
       end
   end
 
 end


#######################################################################################################################
