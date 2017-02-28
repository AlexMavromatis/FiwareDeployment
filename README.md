FIWARE DEPLOYMENT BIO-HPN

Previous Requirements
Centos 6.6 with SE Linux Disabled
After installing Centos we need to open the ports of the OS
Run sudo system-config-firewall-tui
If you have this error:
Traceback (most recent call last):
  File "/usr/bin/system-config-firewall-tui", line 29, in <module>
    import fw_tui
  File "/usr/share/system-config-firewall/fw_tui.py", line 34, in <module>
    import fw_nm
ImportError: No module named fw_nm


It is solved here: https://bugzilla.redhat.com/show_bug.cgi?id=1123919
Context Broker
Installing Context Broker
We are going to use this reference documentation: https://fiware-orion.readthedocs.io/en/1.4.0/admin/install/index.html
Install MongoDB 2.6
    https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/
Add the FIWARE repository
http://stackoverflow.com/questions/24331330/how-to-configure-system-to-use-the-fiware-yum-repository/24510985#24510985
Install the EPEL repository
http://fedoraproject.org/wiki/EPEL
Install Orion Context Broker: yum install ContextBroker
Start it: sudo /etc/init.d/contextBroker start
Check it: /etc/init.d/contextBroker status
IoT Agent
Installing IoT Agent
We are going to use this reference documentation: https://github.com/telefonicaid/iotagent-json/blob/master/docs/stepbystep.md
Install IoT Agent Dependencies:
Node.js (v0.12.0)
        http://whatizee.blogspot.co.uk/2015/02/installing-nodejs-on-centos-66.html 
Mosquitto (v1.4.7)
    Create a repo in /etc/yum.repos.d/ as mosquitto.repo and paste:

[home_oojah_mqtt]
name=mqtt (CentOS_CentOS-6)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6//repodata/repomd.xml.key
enabled=1

Curl (v7.19.7) If it is not already installed then run: sudo yum install curl
Git (v1.7.1) : sudo yum install git
Change directory run: cd /opt and clone the image run: git clone https://github.com/telefonicaid/iotagent-json.git
Change directory run: cd iotagent-json and run: npm install
Now run the agent in the background by executing: nohup bin/iotagent-json &> /var/log/iotAgent&
In order to test everything run: curl http://localhost:4041/iot/about






Short term historic
Installing STH
We are going to use this reference documentation:
https://github.com/telefonicaid/fiware-sth-comet/blob/master/doc/manuals/installation.md
First clone the repository: git clone https://github.com/telefonicaid/fiware-sth-comet.git
cd fiware-sth-comet/
After that: npm install
Start the STH server by running: ./bin/sth
Set the subscription between Orion Context Broker and STH server(localhost:8866/notify)
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -H "Fiware-Service: XXXXXXX" -H "Fiware-ServicePath: /XXXXXXX"  -d '{
    "entities": [
        {
            "type": "XXXXXX",
            "isPattern": "false",
            "id": "XXXXXXX"
        }
    ],
    "attributes": [
        "XXXXXXX"
    ],
    "reference": "http://localhost:8666/notify",
    "duration": "P1M",
    "notifyConditions": [
        {
            "type": "ONCHANGE",
            "condValues": [
                "XXXXXXX"
            ]
        }
    ],
    "throttling": "PT5S"
}' "http://XXXXXXX/v1/subscribeContext"


Supervisor
Installing supervisor
Follow FULL instructions here: http://www.alphadevx.com/a/455-Installing-Supervisor-and-Superlance-on-CentOS
You need to configure Iot Agent and Short Term Historic(STH)
Run vim /etc/supervisord.conf and paste the lines below
[program:iotagent]
command=/opt/iotagent-json/bin/iotagent-json &> /var/log/iotAgent&

[program:STH]
command=/opt/fiware-sth-comet/bin/sth

After reboot the system or just run sudo service supervisord restart
Running supervisor on start up
Run vim /etc/rc.d/init.d/supervisord
Add the 2 and 3 lines at the script
And run sudo chkconfig supervisord on
#!/bin/bash
# chkconfig: 2345 99 60
# description: supervisord 
. /etc/init.d/functions

DAEMON=/usr/bin/supervisord…
…


And run sudo reboot
