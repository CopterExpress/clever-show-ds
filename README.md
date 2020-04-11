# clever-show-ds

Clever-Show client docker image with roscore, clever, sitl and clever-show services running inside.

This container includes:

* [px4 toolchain for simulation](https://dev.px4.io/v1.9.0/en/setup/dev_env.html)
* px4 sitl binary with version [v1.8.2-clever.10](https://github.com/CopterExpress/Firmware/releases/tag/v1.8.2-clever.10)
* [ROS Melodic](http://wiki.ros.org/melodic)
* [clover](https://github.com/CopterExpress/clever) ROS package
* [clever-show](https://github.com/CopterExpress/clever-show) software
* [roscore](services/roscore.service) service
* [clover](services/clover.service) service
* [sitl](services/sitl.service) service
* [clever-show](services/clever-show.service) service

## Running

It is assumed that you have installed latest `docker` version. Instruction is [here](https://docs.docker.com/get-docker/).

Clone this repository and cd into it

```cmd
git clone https://github.com/goldarte/clever-show-ds.git
cd <cloned repo>
```

Execute this command to run container with name and hostname `sim`:

```cmd
docker run \
    -it \
    --rm \
    --name sim \
    --hostname sim \
    --privileged=true \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    goldarte/clever-show-ds
```

Or simple execute `run` bash script to run container with name and hostname `sim-0`.

```cmd
./run
```

There will be 4 services running inside the container: roscore, clover, sitl and clever-show.

You can manage them using `systemctl` and watch their logs with `journalctl -u <service name>`. For example if you want to restart the service `clover`, just use `systemctl restart clover`.

If you want to run more copies of this container you can specify the first parameter of `run` script:

```cmd
./run <param>
```

This will run new container with name and hostname `sim-<param>`.

If you want to open new terminal session in working container, use following command:

```cmd
docker exec -it <container name> bash
```

To stop and kill containers you can use

```cmd
docker kill <container name>
```
