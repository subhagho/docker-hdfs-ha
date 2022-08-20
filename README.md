# docker-hdfs-ha
# Docker Image to startup Hadoop HA HDFS
---

## Docker Compose scripts available at [GitHub](https://github.com/subhagho/docker-hdfs-ha)


## HDFS HA Setup:

| Node | Instances |
| --- | -----------|
| ZooKeeper | 1 |
| Journal | 1 |
| NameNode | 2 (primary/secondary) |
| DataNode | 3 |


---

## Setup Sequence:
### Get the docker-compose scripts:
[Format Primary NameNode](https://github.com/subhagho/docker-hdfs-ha/blob/main/nn-format-primary.yml)

[Bootstrap Secondary NameNode](https://github.com/subhagho/docker-hdfs-ha/blob/main/nn-boostrap-secondary.yml)

[Start Hadoop HA](https://github.com/subhagho/docker-hdfs-ha/blob/main/start-hadoop-ha.yml)


### Update the Volumes
Update the volume mappings in the docker compose scripts to Paths in the host machine.

    volumes:
        - E:\docker\hadoop\nn1:/mnt/hadoop
        - J:\docker\hadoop\logs:/usr/local/hadoop/logs 

### Startup

* `docker-compose -p <name> -f nn-format-primary.yml up`
    * once namenode formatting is done, shutdown the containers.
* `docker-compose -p <name> -f nn-boostrap-secondary.yml up`
    * once secondary namenode is bootstrapped, shutdown the containers.
* `docker-compose -p <name> -f start-hadoop-ha.yml up`
    * all containers up and running...


