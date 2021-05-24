# copyright: 2018, The Authors

title "sample section"

=begin
# you can also use plain tests
describe file("/tmp") do
  it { should be_directory }
end
=end

#Created sample inputs file
=begin
DEVICE=eth0
IPADDR=10.41.87.250
NETMASK=255.255.0.0
GATEWAY=10.41.1.1
BOOTPROTO=none
ONBOOT=yes
TYPE=Etherneti
=end

#Cretae hashes

file_content = { "DEVICE" => "DEVICE=eth0","BOOTPROTO" => "BOOTPROTO=none" }

puts file_content["DEVICE"] 

  control "tmp-1.0" do                        # A unique ID for this control
    impact 0.7                                # The criticality, if this control fails.
    title "Create /tmp directory"             # A human-readable title
    desc "An optional description..."
    describe file("/root/inspec_ifcfg/ifcfg-eth0") do                  # The actual test
      it { should exist }
      its('content') { should match /#{file_content["DEVICE"]}/ }
      its('content') { should match /#{file_content["BOOTPROTO"]}/ }

    end
  end
