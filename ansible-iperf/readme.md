<pre><code>

ansible-playbook -i inv_hosts ssh-known_hosts.yml
ansible-playbook -i inv_hosts ssh-copy-id.yml

# https://www.digitalocean.com/community/cheatsheets/how-to-manage-multiple-servers-with-ansible-ad-hoc-commands

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

# https://stackoverflow.com/questions/67257168/ansible-playbook-to-check-server-reachability-from-target-host

  - command: ping -c3 8.8.8.8
    ignore_errors: true
    register: output
  - meta: end_host
    when: output.rc != 0

  - name: Ping net1
    shell:  |
      ping -c3 8.8.8.8 >/dev/null
      if [ $? -eq 0 ]
      then
        echo "ok"
      else
        echo "nok"
      fi
    ignore_errors: true
    register: output
  - name: end playbook
    meta: end_host
    when: output.stdout == 'nok'

# https://github.com/j05h/ansible-net-test

  - name: start server iperf
    shell: iperf3 --server --one-off --daemon

  - name: set iperf server
    set_fact: iperf_server="{{ groups['servers'][groups['clients'].index(inventory_hostname)] }}"
  - name: start client iperf
    shell: "iperf3 --client {{ iperf_server }} --time 600 >> {{ iperf_out }}"

  - name: template config
    vars:
      - conname: "conn_{{ hostvars[inventory_hostname].ansible_set_ip }}_{{ hostvars[item].ansible_set_ip }}"
      - ipsip_item: "{{ hostvars[item].ansible_set_ip }}"
    template:
      src: connect_strongswan.j2
      dest: /etc/ipsec.d/{{ conname }}.conf
      owner: root
      group: root
      mode: 0644
    when: item != inventory_hostname
    with_items: "{{ groups['ipsec_enable'] }}"	# на каждом сервере из groups['ipsec_enable'] выполнить цикл по элементам [item] из groups['ipsec_enable'] кроме самого себя

</code></pre>
