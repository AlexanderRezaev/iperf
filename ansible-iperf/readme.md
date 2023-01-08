<pre><code>

ansible-playbook -i inv_hosts ssh-known_hosts.yml
ansible-playbook -i inv_hosts ssh-copy-id.yml

ansible all -i inv_hosts -m ping
ansible all -i inv_hosts -m ping -u alex
ansible all -i inv_hosts -m ping --private-key=~/.ssh/custom_id

ansible rancher16 -i inv_hosts -m ping

ansible rancher16 -i inv_hosts -m setup
ansible rancher16 -i inv_hosts -m setup -a "filter=*ipv4*"

ansible all -i inv_hosts -a 'uptime'
ansible all -i inv_hosts -a "tail -n 1 /var/log/syslog" --become

ansible all -i inv_hosts -m apt -a "name=iperf3" --become

ansible all -i inv_hosts -m copy -a "src=./file.txt dest=~/myfile.txt" 

ansible all -i inv_hosts -m file -a "dest=/var/www/file.txt mode=600 owner=sammy group=sammy" --become

ansible webservers -i inventory -m service -a "name=nginx state=restarted" --become

ansible webservers -i inventory -a "/sbin/reboot"  --become


ansible iperf -i inv_hosts -m ping

ansible-playbook -i inv_hosts test.yml

</code></pre>
