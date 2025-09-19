#!/bin/bash

echo -e "Residue_i Residue_j Distance"
awk '
{id[NR]=$3; x[NR]=$5; y[NR]=$6; z[NR]=$7; n=NR }
END {
for(i=1;i<=n;i++){
	for(j=i+1;j<=n;j++){
		dx=x[i]-x[j]; dy=y[i]-y[j]; dz=z[i]-z[j]
		dist=sqrt(dx*dx+dy*dy+dz*dz)
		printf "%-9s %-9s %.3f\n", id[i], id[j], dist
	}
}
}
' alanine_info.pdb
