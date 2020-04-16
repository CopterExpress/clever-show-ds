import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Launch Gazebo simulator and generate N px4 copters with simulated companion computers")
    parser.add_argument('-N','--number', type=int, default='1',
                        help="Number of copters to simulate. Default is 1.")
    parser.add_argument('-p','--port', type=int, default='14601',
                        help="UDP port for simulation data of the first copter. Default is 14601. UDP port for n-th copter will be equal to <port> + n - 1.")
    parser.add_argument('-d','--dist', type=int, default='1',
                        help="Distance between generated copters. The generated copters will be arranged as a 2D array in a shape close to square.")
    args = parser.parse_args()