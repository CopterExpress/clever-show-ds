# Use clover-ds base image for simulation
FROM goldarte/clover-ds

# Clone clever-show repo and install requirements
RUN cd /home/user \
	&& git clone https://github.com/CopterExpress/clever-show\
	&& pip install -r /home/$ROSUSER/clever-show/Drone/requirements.txt

# Copy services from repo
COPY services/* /lib/systemd/system/
RUN systemctl enable show-starter

# Expose ROS and local Mavlink ports
EXPOSE 14556/udp 14557/udp 14560/udp 8181/udp 11311 8080 8081 57575 25000

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["/sbin/init"]

