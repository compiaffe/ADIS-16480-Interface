objects = spi_ADIS_16480.o reg_sys_e_flag.o reg_diag_sts.o reg_glob_cmd.o

ADIS_Interface : $(objects)
	gcc -o ADIS_Interface -L /usr/local/lib -lsoc $(objects)

spi_ADIS_16480.o : spi_ADIS_16480.c spi_ADIS_16480.h
	gcc -c -I /usr/local/include  spi_ADIS_16480.c 

reg_sys_e_flag.o : reg_sys_e_flag.c reg_sys_e_flag.h spi_ADIS_16480.h
	gcc -c -I /usr/local/include  reg_sys_e_flag.c 

reg_diag_sts.o : reg_diag_sts.c reg_diag_sts.h spi_ADIS_16480.h
	gcc -c -I /usr/local/include  reg_diag_sts.c 

reg_glob_cmd.o : reg_glob_cmd.c reg_glob_cmd.h spi_ADIS_16480.h
	gcc -c -I /usr/local/include reg_glob_cmd.c


clean: 
		rm ADIS_Interface $(objects)
