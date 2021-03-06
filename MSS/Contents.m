% Marine Systems Simulator (MSS)
%
% Reference: T. I. Fossen (2021). Handbook of Marine Craft Hydrodynamics and
%       Motion Control. John Wiley & Sons Ltd., 2n edition
%
%       Book examples:  >> help mss_examples 
%
% -------------------------------------------------------------------------
%
% GNCDemo - Demonstration menu for:
%  1) KinDemo    - Euler angle and quaternion kinematics.
%  2) ManDemo    - Maneuvering trials.
%  3) StabDemo   - Straight-line, directional and positional motion stability
%  4) WaveDemo   - Wave spectra demonstrations
%
% Conversions:
%  conversion       - defines the conversion factors R2D, D2R, MS2KNOTS, KNOTS2MS
%  ssa(angle,'deg') - maps an angle in deg to the interval (-180, 180]
%  ssa(angle,'rad') - maps an angle in rad to the interval (-pi pi] 
%    
% Control allocation and propeller models:
%   ucalloc     - Unconstrained control allocation for tau = T*K*u (T=K=constant)
%   wageningen  - Thrust and torque models for Wageningen B-series propellers
%
% Control systems:
%  lqtracker   - Computes the LQ tracker gain matrices for LTI systems 
%
% Guidance systems:
%  crosstrack - computes the crosstrack error and origin of the path-tangential frame
%  crosstrackWpt - computes the crosstrack error between two waypoints
%
% Kinematics:
%  eulerang   - Euler angle transformation matrices J, J1 and J2
%  ecef2llh   - ECEF xyz-coordinates to longitude-lattitude-height
%  euler2q    - Euler angles (roll-pitch-yaw) to quaternions
%  flat2llh   - Flat Earth (NED) to longitude-lattitude-height
%  quest      - QUEST algorithm for attitude determination
%  quest6DOF  - 6-DOF position/attitude vector from 3 position measurements
%  llh2ecef   - longitude-lattitude-height to ECEF xyz-coordinates
%  llh2flat   - Longitude-lattitude-height to flat Earth (NED)
%  euler2q    - Computes the Euler angles from the unit quaternions.
%  rad2pipi   - Converts an angle in rad to the interval [-pi pi)
%  rbody      - Computes MRB and CRB(nu) for a rigid body
%  Rll        - Euler angle rotation matrix (longitude-lattitude)
%  Rquat      - Quaternion rotation matrix
%  Rzyx       - Euler angle rotation matrix (roll-pitch-yaw)
%  Smtrx      - skew-symmetric matrix for vector cross products: a x b = S(a)b
%  Tquat      - Quaternion transformation matrix for attitude
%  Tzyx       - Euler angle transformation matrix for attitude (roll-pitch-yaw)
%  q2euler    - Quaternions to Euler angles (roll-pitch-yaw)
%  R2euler    - Rotation matrix to Euler angles (roll-pitch-yaw)
%  vex        - Inverse vex(S(a))=a for the skew-symmetric matrix S(a)
%  quatern    - Quaternion transformation matrices J, J1 and J2
%  quatprod   - Quaternion product
%
% Navigation systems:
%  acc2rollpitch - computes the static roll-pitch angles from specific force
%  gravity       - acceleration of gravity as a function lattitude (WGS-84)
%  ins_ahrs      - INS error-state Kalman filter using AHRS
%  ins_mekf      - INS error-state MEKF (quaternion representation) 
%  ins_mekf_psi  - INS error-state MEKF using compass measurement
%  insSignal - basic INS signal generator 
%
% Numerical integration:
%  euler2     - 2nd-order Euler integration, fixed step
%  rk4        - 4th-order Runge Kutta method, fixed step
%
% Path generation:
%  order3      - Path generation using cubic (3rd-order) polynominals 
%  order5      - Path generation using 5th order polynominals
% 
% Time-series simulations:
%  SIMmariner     - Simulate mariner.m under PD control
%  SIMcontainer   - Simulate container.m and Lcontainer.m under PD control
%  SIMnavalvessel - Smulate navnalvessel.m  under PD control
%  SIMrig         - Simulate rig.m under PD control
%
% Maneuvering trials/Bode plots:
%  nomoto      - Bode plots of Nomoto's 1st- and 2nd-order models
%  TurnCircle  - performs a turning circle for a given ship model
%  ZigZag      - performs a zig-zag maneuver for a given ship model
%  Pullout     - performs a pullout maneuver for a given ship model
%
% Model transformations and conversion factors:
%  conversion - loads a set of useful conversion factors to workspace, D2R, R2D, MS2KNOTS etc.
%  Hmtrx      - system transformation matrix
%  Gmtrx      - Gravitational-buoyancy matrix (floating vessels)
%  gvect      - Gravitational-buoyancy vector (submerged vehicles)
%  m2c        - System inertia to Coriolis-centripetal transformation matrix
%
% Ships models:
%  frigate     - Frigate, L = 100 m (nonlinear autopilot model)
%  mariner     - Mariner class vessel, L=160 m (nonlinear maneuvering model)
%  tanker      - Esso Osaka tanker, L=304 m (nonlinear course unstable maneuvering model)
%  container   - Container ship, L=175 m (nonlinear maneuvering model including the roll mode)
%  Lcontainer  - Container ship, L=175 m (LINEAR maneuvering model including the roll mode)
%  navalvessel - Multipurpose naval vessel, L = 51.5 m (nonlinear manneuvering model)
%  ROVzefakkel - Boat, L = 45 m (nonlinear autopilot model) 
%  supply      - Supply vessel, L = 76.2 m (linear low-speed DP model)
%
% Underwater vehicle models:
%  DSRV        - Deep submergence rescue vehicle (DSRV), L = 5.0 m
%  npsauv      - Naval Postgraduate School autnomous underwater vehicle (AUV), L = 5.3 m
%
% Semisubmersible models:
%  rig         - Semisub MDG (mass-damper-spring) model, L = 84.6 m
%
% USV models:
%  otter       - Small autonomous USV, L = 2.0 m
%
% Wave response:
%  waveresponse345 - heave, roll and pitch respnoses of ships in regular waves
%
% Wave Spectra, encounter frequency and Motion Sickness Incidence (MSI):
%  encounter   - Computes the encounter frequency
%  ww2we       - Computes the encounter frequency (vector; no abs value)
%  HMmsi       - Motion Sickness Incidence using the criterion of O'Hanlon and McCauley
%  ISOmsi      - Motion Sickness Incidence using the ISO 2631-1 criterion 
%  wavespec    - Different wave spectra can be evaualted
%  rand_phases - Generate vector of random phases
%  hs2vw       - Convert from Hs to wind speed
%  vw2hs       - Convert from  wind speed to Hs
%    
% Wind forces and moments:
%  blendermann94 - Wind coeffcients using the data of Blendermann (1994)
%  isherwood72   - Wind coefficients using the data of Isherwood (1972)
%
% See the help of each individual function for further information
