#!/usr/bin/perl

open (FH,"count_list") or die ;

while(<FH>) {

    chomp;

    if ( /\s+(\S+)\s+(\S+)/ ) {
	$idx = $1;
	$name = $2 ;
    }

    print <<EOM;

    KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, $name );
    count[$name]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);

EOM

}
