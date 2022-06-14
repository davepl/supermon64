all: supermon64.prg kimmon9000.ptp

supermon64.prg: relocate.prg supermon64-8000.prg supermon64-C000.prg 
	./build.py $^ $@

supermon64-8000.prg: supermon64.asm
	64tass -i $< -o $@ -DORG='$$8000' -DC64=1

supermon64-C000.prg: supermon64.asm
	64tass -i $< -o $@ -DORG='$$C000' -DC64=1

kimmon9000.prg: supermon64.asm 
	64tass -nostart -L kimmon9000.lst -i $< -o $@ -DORG='9000' -DKIM1=1

kimmon9000.ptp: kimmon9000.prg
	srec_cat kimmon9000.prg -binary -offset 0x9000 -o kimmon9000.ptp -MOS_Technologies

relocate.prg: relocate.asm
	64tass -i $< -o $@
