ELE4001 AUV simulation files
Shane Rutherford
19/04/21


IMPORTANT! before simulating either of the Simulink files, ensure that the contents of the 3DScope folder are in the MATLAB path environment: right click on 3DScope folder > Add to Path > Selected Folders

The following 3rd party files are used for some of the scripts in this folder:

3DScope: 	https://www.mathworks.com/matlabcentral/fileexchange/4915-3dscope
quiverC3D: 	https://www.mathworks.com/matlabcentral/fileexchange/58527-quiver-magnitude-dependent-color-in-2d-and-3d


The files are explained below.
******************************

Simulink files - These are the Simulink models for the APF and waypoint follower models. They are identical apart from the trajectory generation block.

AUV_APF.slx		
AUV_waypoint.slx



Essential scripts - These files must be in MATLAB's current folder in order to run the simulations.

Jacobian.m			- Used for some kinematic transformations
rotateZYX.m			- Used for some kinematic transformations
S_mtrx.m				- Used for many calculations
AUV_dynamic_model.m		- The AUV model
Contents of 3DScope folder	- For drawing the AUV path in Simulink


Plotting scripts - Used to make plots from logged simulation data. These were used to create most of the plots shown in the report.

make_wapoint_plot.m		- Runs the waypoint follower simulation and plots the AUV path
make_APF_plot.m			- Runs the APF simulation and plots the AUV path
make_APF_movie.m			- Runs the APF simulation and creates a .mp4 animation of the AUV


Other files - These were used to make some of the other plots seen in the report, but aren't relevant to the simulation




