units              real
processors         2 2 2

atom_style         charge
atom_modify        map array
boundary           p p p
atom_modify        sort 0 0.0

variable t equal   1200.0

read_data          data.ch
molecule           dodecane dodecane.txt

lattice            sc 20
region             grid block -1 1 -1 2 0 1
create_atoms       0 region grid mol dodecane 5467637

group              carbon type 1
group              hydrogen type 2
group2ndx          atoms.ndx carbon hydrogen

pair_style         reax/c NULL safezone 2.0 mincap 200
pair_coeff         * * ffield.reax.cho C H

timestep           0.1
neighbor           1.0 bin
neigh_modify       every 1 delay 5 check yes

fix                1 all nve
fix                2 all temp/csld $t $t 1000.0 485846
fix                3 all qeq/reax 1 0.0 10.0 1.0e-6 reax/c

thermo             1000
thermo_style       custom step temp pe time density

# equilibrate
velocity           all create $t 574741 dist gaussian mom yes rot yes
fix                4 all deform 1 x final -25 25 y final -25 25 z final -25 25 units box
run                100000

balance            1.0 x 0.5 y 0.5 z 0.5
unfix              1
unfix              2
unfix              4
velocity           all zero linear
velocity           all zero angular
fix                1 all nvt temp $t $t 100.0

reset_timestep     0

# production run

thermo_style       custom step temp pe time

dump               1 all xyz 100000 dump.ch
dump_modify        1 element C H

fix                5 all reax/c/species 1 1 100000 species.out element C H
fix                cv all colvars colvars.inp unwrap no
fix                boost all timeboost $t cv

run                100000000

