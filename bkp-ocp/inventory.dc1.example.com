[OSEv3:vars]

###########################################################################
### Ansible Vars
###########################################################################
timeout=60
#ansible_user=ec2-user
#ansible_become=yes

###########################################################################
### OpenShift Basic Vars
###########################################################################

openshift_deployment_type=openshift-enterprise

openshift_disable_check="disk_availability,memory_availability,docker_image_availability,package_availability"

openshift_image_tag=v3.11.98
openshift_pkg_version=-3.11.98
openshift_release="3.11"


# Node Groups
openshift_node_groups=[{'name': 'node-config-master', 'labels': ['node-role.kubernetes.io/master=true','runtime=docker']}, {'name': 'node-config-infra', 'labels': ['node-role.kubernetes.io/infra=true','runtime=docker']}, {'name': 'node-config-compute', 'labels': ['node-role.kubernetes.io/compute=true','runtime=docker'], 'edits': [{ 'key': 'kubeletArguments.pods-per-core','value': ['20']}]}]


logrotate_scripts=[{"name": "syslog", "path": "/var/log/cron\n/var/log/maillog\n/var/log/messages\n/var/log/secure\n/var/log/spooler\n", "options": ["daily", "rotate 7","size 500M", "compress", "sharedscripts", "missingok"], "scripts": {"postrotate": "/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true"}}]

# Deploy Operator Lifecycle Manager Tech Preview
#openshift_enable_olm=false

###########################################################################
### OpenShift Registries Locations
###########################################################################

#oreg_url=registry.redhat.io/openshift/ose-${component}:${version}
oreg_auth_user='99999999|sampleusers'
oreg_auth_password='aaaalss0VjFTfZclaLRgPPqmEVTqU4440IONL_Ebbb'



#openshift_docker_insecure_registries=isolated1.dc1.example.com:5000
#openshift_docker_blocked_registries=registry.redhat.io,registry.access.redhat.com,docker.io
openshift_examples_modify_imagestreams=true


# Set this line to enable NFS
openshift_enable_unsupported_configurations=True

###########################################################################
### OpenShift Master Vars
###########################################################################

openshift_master_api_port=443
openshift_master_console_port=443

#Default: 
openshift_master_cluster_method=native
openshift_master_cluster_hostname=lb.dc1.example.com
openshift_master_cluster_public_hostname=ocp.dc1.example.com
openshift_master_default_subdomain=apps.dc1.example.com
openshift_master_overwrite_named_certificates=True

###########################################################################
### OpenShift Network Vars
###########################################################################

osm_cluster_network_cidr=10.1.0.0/16
openshift_portal_net=172.30.0.0/16

os_sdn_network_plugin_name='redhat/openshift-ovs-networkpolicy'

###########################################################################
### OpenShift Authentication Vars
###########################################################################

# HTPASSWD Authentication Only
openshift_master_identity_providers=[{'name': 'Usuário Local', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider'}]


###########################################################################
### OpenShift Metrics and Logging Vars
###########################################################################

#########################
# Prometheus Metrics
#########################

openshift_hosted_prometheus_deploy=false
#openshift_prometheus_namespace=openshift-metrics
#openshift_prometheus_node_selector={"node-role.kubernetes.io/infra":"true"}

openshift_cluster_monitoring_operator_install=false


########################
# Cluster Metrics
########################

openshift_metrics_install_metrics=false

#openshift_metrics_storage_kind=nfs
#openshift_metrics_storage_access_modes=['ReadWriteOnce']
#openshift_metrics_storage_nfs_directory=/srv/nfs
#openshift_metrics_storage_nfs_options='*(rw,root_squash)'
#openshift_metrics_storage_volume_name=metrics
#openshift_metrics_storage_volume_size=10Gi
#openshift_metrics_storage_labels={'storage': 'metrics'}
#openshift_metrics_cassandra_pvc_storage_class_name=''


#openshift_metrics_hawkular_nodeselector={"node-role.kubernetes.io/infra": "true"}
#openshift_metrics_cassandra_nodeselector={"node-role.kubernetes.io/infra": "true"}
#openshift_metrics_heapster_nodeselector={"node-role.kubernetes.io/infra": "true"}

# Store Metrics for 2 days
#openshift_metrics_duration=2	

# Suggested Quotas and limits for Prometheus components:
#openshift_prometheus_memory_requests=2Gi
#openshift_prometheus_cpu_requests=750m
#openshift_prometheus_memory_limit=2Gi
#openshift_prometheus_cpu_limit=750m
#openshift_prometheus_alertmanager_memory_requests=300Mi
#openshift_prometheus_alertmanager_cpu_requests=200m
#openshift_prometheus_alertmanager_memory_limit=300Mi
#openshift_prometheus_alertmanager_cpu_limit=200m
#openshift_prometheus_alertbuffer_memory_requests=300Mi
#openshift_prometheus_alertbuffer_cpu_requests=200m
#openshift_prometheus_alertbuffer_memory_limit=300Mi
#openshift_prometheus_alertbuffer_cpu_limit=200m


# Grafana
#openshift_grafana_storage_type=pvc
#openshift_grafana_pvc_size=2Gi
#openshift_grafana_node_exporter=true

########################
# Cluster Logging
########################

openshift_logging_install_logging=true
#openshift_logging_install_eventrouter=true

#openshift_logging_storage_kind=nfs
#openshift_logging_storage_access_modes=['ReadWriteOnce']
#openshift_logging_storage_nfs_directory=/srv/nfs
#openshift_logging_storage_nfs_options='*(rw,root_squash)'
##openshift_logging_storage_volume_name=logging
#openshift_logging_storage_volume_size=10Gi
#openshift_logging_storage_labels={'storage': 'logging'}
#openshift_logging_es_pvc_storage_class_name=''

openshift_logging_es_memory_limit=6Gi
openshift_logging_es_cluster_size=1
openshift_logging_curator_default_days=2

openshift_logging_kibana_nodeselector={"node-role.kubernetes.io/infra": "true"}
openshift_logging_curator_nodeselector={"node-role.kubernetes.io/infra": "true"}
openshift_logging_es_nodeselector={"node-role.kubernetes.io/infra": "true"}
#openshift_logging_eventrouter_nodeselector={"node-role.kubernetes.io/infra": "true"}

###########################################################################
### OpenShift Router and Registry Vars
###########################################################################

# default selectors for router and registry services
openshift_router_selector='node-role.kubernetes.io/infra=true'
openshift_registry_selector='node-role.kubernetes.io/infra=true'

openshift_hosted_router_replicas=2

# openshift_hosted_router_certificate={"certfile": "/path/to/router.crt", "keyfile": "/path/to/router.key", "cafile": "/path/to/router-ca.crt"}

openshift_hosted_registry_replicas=1
#openshift_hosted_registry_pullthrough=true
#openshift_hosted_registry_acceptschema2=true
#openshift_hosted_registry_enforcequota=true


#openshift_hosted_registry_storage_kind=nfs
#openshift_hosted_registry_storage_access_modes=['ReadWriteMany']
#openshift_hosted_registry_storage_nfs_directory=/srv/nfs
#openshift_hosted_registry_storage_nfs_options='*(rw,root_squash)'
#openshift_hosted_registry_storage_volume_name=registry
#openshift_hosted_registry_storage_volume_size=20Gi

###########################################################################
### OpenShift Service Catalog Vars
###########################################################################

# default=true
openshift_enable_service_catalog=true

# default=true
#template_service_broker_install=true
#openshift_template_service_broker_namespaces=['openshift']

# default=true
#ansible_service_broker_install=true
#ansible_service_broker_local_registry_whitelist=['.*-apb$']

###########################################################################
### OpenShift Hosts
###########################################################################
# openshift_node_labels DEPRECATED
# openshift_node_problem_detector_install

[OSEv3:children]
lb
masters
etcd
nodes
nfs

[lb]
lb.dc1.example.com

[masters]
master1.dc1.example.com
master2.dc1.example.com
master3.dc1.example.com

[etcd]
master1.dc1.example.com
master2.dc1.example.com
master3.dc1.example.com

[nodes]
## These are the masters
master1.dc1.example.com openshift_node_group_name='node-config-master'
master2.dc1.example.com openshift_node_group_name='node-config-master'
master3.dc1.example.com openshift_node_group_name='node-config-master'

## These are infranodes
infra1.dc1.example.com openshift_node_group_name='node-config-infra'
infra2.dc1.example.com openshift_node_group_name='node-config-infra'

## These are regular nodes
app1.dc1.example.com openshift_node_group_name='node-config-compute'
app2.dc1.example.com openshift_node_group_name='node-config-compute'

[nfs]
bastiao.dc1.example.com
