Ansible-OpenLdap
=========

Installs and configures OpenLDAP and phpLDAPadmin  
http://www.openldap.org/

## Getting started:
Install requirements using Ansible Galaxy.
````
sudo ansible-galaxy install -r requirements.yml -f
````

Spin up Vagrant environment.
````
vagrant up
````

## Test
```
ldapsearch -H ldap://localhost:1389 -x -D cn=admin,dc=localhost -w P@55w0rd -b ou=People,dc=localhost "(uid=john)"
```

## Manage
Go to [`http://localhost:8080/phpldapadmin`](http://localhost:8080/phpldapadmin) and login with
```
user: cn=admin,dc=localhost
password: P@55w0rd
```

## Role Variables

```
---
# defaults file for ansible-openldap
openldap_admin_password: 'P@55w0rd'
openldap_admin_user: 'admin'
openldap_base: 'dc=example,dc=org'
openldap_bind_id: 'cn={{ openldap_bind_user }},{{ openldap_base }}'
openldap_bind_user: '{{ openldap_admin_user }}'
openldap_debian_packages:
  - slapd
  - ldap-utils
  - phpldapadmin
openldap_organizationalunits:  #defines OU's to populate
  - People
  - Groups
openldap_phpldapadmin_hide_warnings: 'true'
openldap_populate: false  #defines if openldap DB should be populated with openldap_organizationalunits, openldap_posixgroups and openldap_users
openldap_posixgroups:  #defines groups to create within OU's
  - name: miners
    ou: Groups
    gidNum: 5000  #start group numbers at 5000 and up
openldap_server_host: '127.0.0.1'  #defines host for phpLDAPadmin
openldap_users:
  - FirstName: John
    LastName: Smith
    ou: People  #defines OU name
    uidNum: 10000  #start user numbers at 10000 and up
    gidNum: 5000  #defines gidNum from openldap_posixgroups
    password: 'P@55w0rd'
    loginShell: /bin/bash
    homeDirectory: /home/john
pri_domain_name: 'example.org'
```

## Example Playbooks

#### GitHub
```
---
- hosts: all
  become: true
  vars:
    - openldap_base: 'dc=localhost'
    - pri_domain_name: localhost
    - openldap_populate: true
  roles:
    - role: ansible-etc-hosts
    - role: ansible-openldap
  tasks:
```

#### Galaxy
```
---
- hosts: all
  become: true
  vars:
    - openldap_base: 'dc=localhost'
    - pri_domain_name: localhost
    - openldap_populate: true
  roles:
    - role: mrlesmithjr.etc-hosts
    - role: mrlesmithjr.openldap
  tasks:
```

## License
BSD
