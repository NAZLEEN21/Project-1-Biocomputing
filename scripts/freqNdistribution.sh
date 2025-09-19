#!/bin/bash

echo -e "AA Frequency F.Distribution"

LONG_HDR=$(awk '/^>/ {if(h) print h "\t" l; h=$0; l=0; next} {l+=length($0)} END {if (h) print "\t" l}' combined_homologous_seq.fasta |sort -k2 -nr | head -n1 | cut -f1)

awk -v H="$LONG_HDR" '
BEGIN { aas = "A R N D C Q E G H I L K M F P S T W Y V"; split(aas,AA," ") }       
/^>/ { inseq = ($0 == H); next }
inseq {
for (i=1;i<=length($0);i++) {
	c = toupper(substr($0,i,1))
	if (c ~ /[A-Z]/) {counts[c]++; total++}
	}
}
END {
if (total==0) { print "No residues counted (check header matching)."; exit}
	printf "Total residues: %d\n\n","AA","Count","Percent"
	for (i=1;i<=length(AA);i++){
		a=AA[i]; c =counts[a]+0
		printf "%-2s %8d %9.2f%%\n", a,c, (c/total*100)
	}
			# print extras separately
			extras_printed =0
			for (r in counts) {
				found=0
				for (i=1;i<=length(AA);i++) if (AA[i]==r) found=1
					if (!found) {
						if (!extra_printed) {print "\nExtras:"; extra_printed=1}
							print "%-2s %8 %9.2f%%\n", r, counts[r], (counts[r]/total*100)
						}
					}
				}
				' combined_homologous_seq.fasta

