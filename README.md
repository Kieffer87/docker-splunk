# Splunk for UnRAID

## Overview
This docker image enables the use of the latest [Official Splunk Docker Image](https://github.com/splunk/docker-splunk) on UnRAID.

### Key Benefits
- No custom bash scripts to configure/upgrade splunk
- Automatated upgrades when a new splunk version is released and has been tested by Splunk
- UnRAID parameters to map ports/storage
- KVStore and splunk_archiver disabled

## UnRAID Parameters
| **Parameter**                        | **Description**                                                                                                                  | **Default**                          |
|--------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| **Persistent Data Storage**          | The UnRAID storage location for `/opt/splunk/var` which stores all of the indexes                                                | /mnt/user/appdata/docker/splunk/data |
| **Persistent Configuration Storage** | The UnRAID storage location for `/opt/splunk/etc` which contains local configurations                                            | /mnt/user/appdata/docker/splunk/etc  |
| **License URI**                      | URI to fetch a Splunk Enterprise license. This can be a local path, a remote URL, or “Free”.                                     | Free                                 |
| **Splunk start args**                | Arguments to start Splunk with. Please note, Container will not start without the existence of –accept-license in this variable. | --accept-license                     |
| **Admin Password**                   | Default Admin password used the first time you start Splunk                                                                      | changeme2019                         |
| **HTTP Web Port**                    | HTTP Web Port                                                                                                                    | 8000                                 |
| **UDP Syslog Port**                  | UDP Syslog Port                                                                                                                  | 1514                                 |
| **Default Forwarding Port**          | Default Forwarding Port                                                                                                          | 9997                                 |
| **Default Management Port**          | Default Management Port                                                                                                          | 8089                                 |

## Splunk Default Settings
Several Splunk configurations are set by default in the [default.yml](https://github.com/Kieffer87/docker-splunk/blob/master/default.yml) file. These settings are required for Docker or reduce the footprint of Splunk for non-clustered/Enterprise workloads.
