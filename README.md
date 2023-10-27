
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# MongoDB bulk update performance issues.
---

This incident type refers to performance issues encountered during bulk updates in MongoDB, a popular NoSQL database management system. Bulk updates involve updating multiple documents in a single operation, which can be resource-intensive and may cause performance degradation if not properly optimized. This incident type requires troubleshooting and optimization to ensure efficient bulk updates without compromising the overall performance of the MongoDB database.

### Parameters
```shell
export MONGO_URI="PLACEHOLDER"

export COLLECTION_NAME="PLACEHOLDER"

export THRESHOLD_SECONDS="PLACEHOLDER"

export MEMORY_LIMIT="PLACEHOLDER"

export CPU_LIMIT="PLACEHOLDER"

export DISK_SPACE_LIMIT="PLACEHOLDER"

export MONGO_CONFIG_FILE="PLACEHOLDER"
```

## Debug

### Check MongoDB server status
```shell
systemctl status mongod.service
```

### Check MongoDB server logs for errors
```shell
tail -f /var/log/mongodb/mongod.log
```

### Connect to MongoDB instance with the mongo shell
```shell
mongo ${MONGO_URI}
```

### Check if the affected collection is indexed
```shell
mongo ${MONGO_URI} --eval "db.${COLLECTION_NAME}.getIndexes()"
```

### Check the size of the affected collection
```shell
mongo ${MONGO_URI} --eval "db.${COLLECTION_NAME}.stats()"
```

### Check the current oplog size
```shell
mongo ${MONGO_URI} --eval "db.oplog.rs.stats()"
```

### Check if there are any long-running operations
```shell
mongo ${MONGO_URI} --eval "db.currentOp({'op': 'update', 'secs_running': {'$gt': ${THRESHOLD_SECONDS}}})"
```

### Monitor MongoDB server performance metrics in real-time
```shell
mongostat
```

## Repair

### Review the MongoDB database configuration to ensure that it is optimized for bulk updates. This includes reviewing the system resources, such as CPU, memory, and disk space, and adjusting the configuration parameters accordingly.
```shell


#!/bin/bash



# Set the path to the MongoDB configuration file

CONFIG_FILE=${MONGO_CONFIG_FILE}



# Set the desired system resource parameters for bulk updates

CPU=${CPU_LIMIT}

MEMORY=${MEMORY_LIMIT}

DISK_SPACE=${DISK_SPACE_LIMIT}



# Update the MongoDB configuration file with the desired parameters

sed -i "s/^cpuLimit=.*/cpuLimit=$CPU/" $CONFIG_FILE

sed -i "s/^memoryLimit=.*/memoryLimit=$MEMORY/" $CONFIG_FILE

sed -i "s/^diskSpaceLimit=.*/diskSpaceLimit=$DISK_SPACE/" $CONFIG_FILE



# Restart the MongoDB service to apply the new configuration

systemctl restart mongod.service


```