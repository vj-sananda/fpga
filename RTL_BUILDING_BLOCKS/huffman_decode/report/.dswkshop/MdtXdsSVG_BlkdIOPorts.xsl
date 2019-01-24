<?xml version="1.0" standalone="no"?>
<xsl:stylesheet version="1.0"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           xmlns:exsl="http://exslt.org/common"
           xmlns:xlink="http://www.w3.org/1999/xlink">
                
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
	       doctype-public="-//W3C//DTD SVG 1.0//EN"
		   doctype-system="http://www.w3.org/TR/SVG/DTD/svg10.dtd"/>
			
<xsl:param name="IOP_H"   select="10"/>				
<xsl:param name="IOP_W"   select="10"/>				

<xsl:param name="IOP_SY"  select="150"/>				
<xsl:param name="IOP_SPC" select="32"/>				

<xsl:param name="IOP_COL_NOR" select="'#0000FF'"/>		        
<!-- ======================= MAIN BLOCK =============================== -->

<xsl:template name="Layout_BlkdIOPDefs">

	 <symbol id="GPortNorm">
		<rect  x="0"  y="0" 
			width= "{$IOP_W}" 
			height="{$IOP_H}" style="fill:{$IOP_COL_NOR}; stroke:black; stroke-width:2"/> 
	</symbol>

</xsl:template>

<xsl:template name="Draw_IOPorts"> 
	<xsl:param name="drawarea_w" select="50"/>
	
	<xsl:variable name="i_x_pos" select="($BLKD_PRTCHAN_W - $IOP_W)"/>
	<xsl:variable name="o_x_pos" select="($BLKD_PRTCHAN_W + ($BLKD_IORCHAN_W * 2) + $drawarea_w)"/>
	
	<xsl:for-each select="MHSINFO/GLOBALPORTS/GPORT[@DIR='I'or @DIR='IN' or @DIR='IO' or @DIR='INPUT']">
		<xsl:sort data-type="number" select="@PRTNUMBER" order="ascending"/>
		<xsl:variable name="o_y_pos" select="($IOP_SY + ((position() - 1) * $IOP_SPC))"/>
		
		<use   x="{$i_x_pos}"  y="{$o_y_pos}"  xlink:href="#GPortNorm"/>
	
		<text class="iopnumb"
		  x="{$i_x_pos - 10}" 
		  y="{$o_y_pos + ceiling($IOP_H div 2) + 6}">
		 
			<xsl:value-of select="@PRTNUMBER"/>
		</text>
		
	</xsl:for-each>
	
	<xsl:for-each select="MHSINFO/GLOBALPORTS/GPORT[@DIR='O' or @DIR='OUT' or @DIR='OUTPUT']">
		<xsl:sort data-type="number" select="@PRTNUMBER" order="ascending"/>
		<xsl:variable name="o_y_pos" select="($IOP_SY + ((position() - 1) * $IOP_SPC))"/>
		<use   x="{$o_x_pos}"  y="{$o_y_pos}"  xlink:href="#GPortNorm"/>
	
		<text class="iopnumb"
		  x="{$o_x_pos + $IOP_W + 10}" 
		  y="{$o_y_pos + ceiling($IOP_H div 2) + 6}">
		 
			<xsl:value-of select="@PRTNUMBER"/>
		</text>
		
	</xsl:for-each>
	
</xsl:template>
<!-- ======================= END MAIN BLOCK =========================== -->

</xsl:stylesheet>
