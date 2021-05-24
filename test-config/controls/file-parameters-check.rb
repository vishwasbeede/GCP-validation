# copyright: 2018, The Authors

title "sample section"

yamlcontent = inspec.profile.file("inputs.yml")
yamlparams = YAML.load(yamlcontent)

test_data = yamlparams['parameter_data']
puts test_data

  control "ifcfg-1.0" do                        # A unique ID for this control
    impact 1.0                                # The criticality, if this control fails.
    title "Veify netwrok parameters of ifcfg file"             # A human-readable title
    desc "Script which is used to validate network parameters."
    #   it { should exist }
   describe file("/root/inspec_ifcfg/ifcfg-eth0") do                
      it { should exist }
      its(:content) { should match /#{test_data["DEVICE"]}/ }
      its(:content) { should match /#{test_data["BOOTPROTO"]}/ }

    end
  end
