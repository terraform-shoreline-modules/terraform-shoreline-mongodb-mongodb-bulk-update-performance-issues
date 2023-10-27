

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