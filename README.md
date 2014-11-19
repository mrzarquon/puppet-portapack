[Portapack](http://en.wikipedia.org/wiki/Portable_classroom)

Simple portable classroom

portapack::guac - sets up the guacamole server (tested on ubuntu 14 for speed since has all needed packages), will eventually query puppetdb for presence of studentname fact to get list of hosts, and which machines for which students, etc.

portapack::nodes - enables win_rdp for the systems, adds a 'student' user with default username password that corresponds to the one on the guacamole servers user-mapping.xml file

Todo: everything

tasks to accomplish:

Populate users in LDAP, assign to machines

Source users from LDAP
Source machine profiles from LDAP

Configure puppet master (portapack::setup) to talk to ldap, populate RBAC rules with "machine user can log in to, user can modifiy classifications to in pe console"


