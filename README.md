# clever-show-ds

[clever-show](https://github.com/CopterExpress/clever-show) docker sitl image with roscore, clever, sitl and clever-show services running inside.

This docker container can be used as simulated copter with companion computer and px4 flight controller inside. You can run as much containers as you want to simulate drone formation (as long as there is enough performance).

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

## Requirements

### Simulate copters in Gazebo (default)

* Ubuntu 18.04
* ROS Melodic Desktop-Full Install ([install instruction](http://wiki.ros.org/melodic/Installation/Ubuntu))
* docker ([install instruction](https://docs.docker.com/get-docker/))

## Simulate N copters in Gazebo

Clone this repository, cd into it and pull docker image:

```cmd
git clone https://github.com/CopterExpress/clever-show-ds.git
cd <cloned repo>
docker pull goldarte/clever-show-ds
```

Launch Gazebo simulator and generate n px4 copters with simulated companion
computers

```cmd
python simulate.py [-h] [-n NUMBER] [-p PORT] [-d DIST]

optional arguments:
  -h, --help            show help message and exit
  -n NUMBER, --number NUMBER
                        Number of copters to simulate. Default is 1.
  -p PORT, --port PORT  UDP port for simulation data of the first copter.
                        Default is 14601. UDP port for n-th copter will be
                        equal to <port> + n - 1.
  -d DIST, --dist DIST  Distance between generated copters. The generated
                        copters will be arranged as a 2D array in a shape
                        close to square.
```

For example, you can simply simulate 5 copters in Gazebo by executing

```cmd
python simulate.py -n 5
```

![5 generated copters in Gazebo](docs/assets/copters-landed.png)

> If you get error:
>
> ```cmd
> ImportError: No module named roslaunch
> ```
>
> add `source /opt/ros/melodic/setup.bash` to the end of ~/.bashrc file.

## Control copters from clever-show server

Clone [clever-show](https://github.com/CopterExpress/clever-show) repository and cd to it

```cmd
git clone https://github.com/CopterExpress/clever-show.git
cd <cloned repo>
```

Setup requirements with pip3

```cmd
pip3 install -r requirements.txt
```

Run clever-show server GUI

```cmd
cd Server
python3 server_qt.py
```

Change option `send_ip` in `BROADCAST` section to `172.17.255.255` by clicking `Server` -> `Edit server config`

![Server settings](docs/assets/server-settings.png)

Check option `Restart` and click `Save` button.

Wait until all simulated copters connect to server automatically.

![5 connected copters in table](docs/assets/copters-landed-table.png)

Test copters by selecting them all (ctrl+A) and clicking `Takeoff` button on the right panel of GUI.

![5 flying copters in table](docs/assets/copters-takeoff-table.png)

![5 flying copters in Gazebo](docs/assets/copters-takeoff.png)

Land copters by clicking `Land ALL` button on the right panel of GUI.

More documentation about [clever-show](https://github.com/CopterExpress/clever-show#documentation) software can be found in the Github repository.

## Run container standalone

Execute this command to run container with name and hostname `sim-1` with UDP listening port 14601 for simulator data:

```cmd
docker run \
    -d \
    -it \
    --rm \
    --name sim-1 \
    --hostname sim-1 \
    --tmpfs /tmp \
    --tmpfs /run \
    --tmpfs /run/lock \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    -p 14601:14560/udp \
    goldarte/clever-show-ds
```

Or simple execute `run` bash script to run container with the same settings as above (from clever-show-ds directory):

```cmd
./run
```

There will be 4 services running inside the container: roscore, clover, sitl and clever-show.

You can manage them using `systemctl` and watch their logs with `journalctl -u <service name>`. For example if you want to restart the service `clover`, just use `systemctl restart clover`.

If you want to run more copies of this container you can specify options for `run` script:

```cmd
./run [options]
Options:
    -h --help       Print this message
    -i --id=ID      Set container name and hostname to sim-<id> (default: 1)
    -p --port=PORT  Set UDP listening port for simulator data (default: 14601)

```

> Each time you want to run new container it must have UDP port for simulator data that differs from the UDP ports for simulator data of the other running containers!

If you want to open new terminal session in working container, use following command:

```cmd
docker exec -it <container name> bash
```

To stop or kill containers you can use

```cmd
docker stop <container name>
docker kill <container name>
```

To get information about running containers you can use

```cmd
docker ps
```
