

### how to install ansible

i install ansible in a python virtual env like this
(always with the latest stable cryptographically verified version
of python virtualenv) :

```bash
cd ~/Persistent
./virtualenv-x.xx.x/virtualenv.py --system-site-packages ~/Persistent/virtenv-ansible
. ~/Persistent/virtenv-ansible/bin/activate
pip install ansible
```

Ansible also has several other installation methods:

[http://docs.ansible.com/intro_installation.html](http://docs.ansible.com/intro_installation.html)


### how to use this ansible role:

#### note about planetlabs:

you'll need to add this to your ansible config file
if you want to use planetlabs servers:

```bash
cat <<EOT>~/Persistent/.ansible.cfg
[ssh_connection]
scp_if_ssh=True
EOT
ln -s ~/Persistent/.ansible.cfg ~/.ansible.cfg
```

#### ansible directory layout

Make sure you are using ansible according to the best practices
directory-layout specified here:

http://docs.ansible.com/playbooks_best_practices.html#directory-layout


I setup mine on my Tails persistent volume like this:

```bash
mkdir -p /home/amnesia/Persistent/projects/ansible-base/roles
cd /home/amnesia/Persistent/projects/ansible-base/roles
git clone https://github.com/david415/ansible-tor.git
git clone https://github.com/david415/ansible-ooniprobe.git
```

Next I create a host inventory file, let's call it 
/home/amnesia/Persistent/projects/ansible-base/master-inventory:

```
[ooni-planetlab]
#planetlab1.xeno.cl.cam.ac.uk
planetlab1.acis.ufl.edu
```

copy a playbook into our ansible base directory:
```bash
cd /home/amnesia/Persistent/projects/ansible-base/
cp roles/ansible-ooniprobe/playbooks/ooni-planetlab.yml .
```

firstly make sure the planetlab node has python-simplejson installed:
```bash
ansible ooni-planetlab -i master-inventory -u uwaterloo_geossl -m raw -a"sudo yum install -y python-simplejson"
```


to use planetlab servers you must specify the correct ssh user
via the '-u' option. run the playbook like this:
```bash
ansible-playbook -i master-inventory ooni-planetlab.yml -vvvv -u uwaterloo_geossl
```

