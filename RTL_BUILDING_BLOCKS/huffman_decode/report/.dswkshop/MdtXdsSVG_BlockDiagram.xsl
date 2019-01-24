<?xml version="1.0" standalone="no"?>
<xsl:stylesheet version="1.0"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           xmlns:exsl="http://exslt.org/common"
           xmlns:xlink="http://www.w3.org/1999/xlink">

<xsl:include href="MdtXdsSVG_BlkdProcessors.xsl"/>
<xsl:include href="MdtXdsSVG_BlkdIPBlocks.xsl"/>
<xsl:include href="MdtXdsSVG_BlkdBusses.xsl"/>
<xsl:include href="MdtXdsSVG_BlkdIOPorts.xsl"/>
<xsl:include href="MdtXdsSVG_BlkdMemShapes.xsl"/>

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
	       doctype-public="-//W3C//DTD SVG 1.0//EN"
		   doctype-system="http://www.w3.org/TR/SVG/DTD/svg10.dtd"/>
		   
<xsl:param name="BLKD_PROC_NUMB"          select="1"/>				
			
<xsl:param name="BLKD_DEF_DRAWAREA_W"     select="800"/>				

<xsl:param name="BLKD_GAP_Y"              select="32"/>				
<xsl:param name="BLKD_PROC2BUS_GAP_Y"     select="20"/>				

<xsl:param name="BLKD_IORCHAN_H" select="16"/>				
<xsl:param name="BLKD_IORCHAN_W" select="16"/>				
<xsl:param name="BLKD_PRTCHAN_H" select="16"/>				
<xsl:param name="BLKD_PRTCHAN_W" select="40"/>				

<!--
<xsl:param name="BLKD_MEM_GAP_Y"      select="200"/>				
<xsl:param name="BLKD_OPB_COMP_GAP_X" select="40"/>
<xsl:param name="BLKD_PROC_W"      select="128"/>				
<xsl:param name="BLKD_PROC_DEF_H"  select="128"/>				
-->

<xsl:param name="BLKD_COL_BG"     select="'#CCCCCC'"/>				
<xsl:param name="BLKD_COL_BLACK"  select="'#000000'"/>
<xsl:param name="BLKD_COL_WHITE"  select="'#FFFFFF'"/>
<xsl:param name="BLKD_COL_IORING" select="'#000088'"/>				

<xsl:param name="BLKD_COL_LMBBUS"     select="'#7777FF'"/>	
<xsl:param name="BLKD_COL_LMBBUS_TXT" select="'#DDDDFF'"/>

<xsl:param name="BLKD_COL_OPBBUS"     select="'#339900'"/>				
<xsl:param name="BLKD_COL_OPBBUS_TXT" select="'#33FF00'"/>				

<xsl:param name="BLKD_COL_PLBBUS"     select="'#FF3300'"/>				
<xsl:param name="BLKD_COL_PLBBUS_TXT" select="'#FFBB00'"/>				

<xsl:param name="BLKD_COL_FSLBUS"     select="'#CC00CC'"/>				
<xsl:param name="BLKD_COL_FSLBUS_TXT" select="'#FFBBFF'"/>				

<!-- ======================= MAIN SVG BLOCK =============================== -->
<xsl:template match="EDKPROJECT">
	
	<xsl:variable name="BLKD_PROC_NAME">
		<xsl:value-of select="MHSINFO/MODULES/MODULE[@MODCLASS='PROCESSOR']/@INSTANCE"/>
	</xsl:variable>	
	
	<xsl:variable name="BLKD_PROC_TYPE">
		<xsl:value-of select="MHSINFO/MODULES/MODULE[@MODCLASS='PROCESSOR']/@PROCTYPE"/>
	</xsl:variable>	
	
		
<!-- Count busses and memory shapes -->		

	<xsl:variable name="opb_IP_CNT"   select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and (@BUSDOMAIN_IS_OPB='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>
	<xsl:variable name="opb_BUS_CNT"  select="count(MHSINFO/MODULES/MODULE[@MODCLASS='BUS' and (@BUSTYPE='OPB')])"/>
	<xsl:variable name="opb_MSHP_CNT" select="count(RENDERINFO/MEMSHAPE[@BUSDOMAIN_IS_OPB='TRUE' and not(@BUSDOMAIN_IS_MUL)])"/>
	
	<xsl:variable name="plb_IP_CNT"   select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and (@BUSDOMAIN_IS_PLB='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>
	<xsl:variable name="plb_BUS_CNT"  select="count(MHSINFO/MODULES/MODULE[(@MODCLASS='BUS') and (@BUSTYPE='PLB')])"/>
	<xsl:variable name="plb_MSHP_CNT" select="count(RENDERINFO/MEMSHAPE[@BUSDOMAIN_IS_PLB='TRUE' and not(@BUSDOMAIN_IS_MUL)])"/>

	<xsl:variable name="fsl_IP_CNT"   select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and (@BUSDOMAIN_IS_FSL='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>
	<xsl:variable name="fsl_BUS_CNT"  select="count(MHSINFO/MODULES/MODULE[@MODCLASS='BUS' and (@BUSTYPE='FSL')])"/>
	<xsl:variable name="fsl_BIF_CNT"  select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PROCESSOR']/BUSINTERFACE[@BUSDOMAIN='FSL'])"/>
	
	<xsl:variable name="lmb_BUS_CNT"  select="count(MHSINFO/MODULES/MODULE[(@MODCLASS='BUS') and (@BUSTYPE='LMB')])"/>
	
	<xsl:variable name="nobus_IP_CNT" select="count(MHSINFO/MODULES/MODULE[@MODCLASS='IP'])"/>
	
	<xsl:variable name="bridge_CNT"   select="count(MHSINFO/MODULES/MODULE[@MODCLASS='BUS_BRIDGE'])"/>
	
	
	<xsl:variable name="BLKD_BUSSES_H">
		<xsl:call-template  name="Calc_Busses_H">
			<xsl:with-param name="bus_cnt"    select="($opb_BUS_CNT + $plb_BUS_CNT)"/>
			<xsl:with-param name="bridge_CNT" select="$bridge_CNT"/>
		</xsl:call-template>	
	</xsl:variable>
	
	<xsl:variable name="BLKD_PROC_H">
		<xsl:call-template  name="Calc_Proc_H"/>
	</xsl:variable>
	
	<xsl:variable name="BLKD_PROC_W">
		<xsl:call-template  name="Calc_Proc_W"/>
	</xsl:variable>
	
	<xsl:variable name="BLKD_PROC_MEM_H">
		<xsl:call-template  name="Calc_ProcMem_H"/>
	</xsl:variable>
	
	<xsl:variable name="BLKD_PROC_MEM_W">
		<xsl:call-template  name="Calc_ProcMem_W"/>
	</xsl:variable>
	
	<xsl:variable name="BLKD_PROC_HASMEM">
		<xsl:choose>
			<xsl:when test="($lmb_BUS_CNT &gt; 0)">1</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="BLKD_OPB_IPBLK_H">
		<xsl:call-template name="Calc_IPBlk_H">
			<xsl:with-param name="ip_cnt"   select="$opb_IP_CNT"/>
			<xsl:with-param name="ms_cnt"   select="$opb_MSHP_CNT"/>
		</xsl:call-template>	
	</xsl:variable>
	
	<xsl:variable name="BLKD_OPB_IPBLK_W">
		<xsl:call-template name="Calc_IPBlk_W">
			<xsl:with-param name="ip_cnt"   select="($opb_IP_CNT)"/>
		</xsl:call-template>	
	</xsl:variable>
	
	<xsl:variable name="BLKD_PLB_IPBLK_H">
		<xsl:call-template name="Calc_IPBlk_H">
			<xsl:with-param name="ip_cnt"   select="$plb_IP_CNT"/>
			<xsl:with-param name="ms_cnt"   select="$plb_MSHP_CNT"/>
		</xsl:call-template>	
	</xsl:variable>
	
	<xsl:variable name="BLKD_PLB_IPBLK_W">
		<xsl:call-template name="Calc_IPBlk_W">
			<xsl:with-param name="ip_cnt"   select="($plb_IP_CNT)"/>
		</xsl:call-template>	
	</xsl:variable>
	
	<xsl:variable name="BLKD_FSL_IPBLK_W">
		<xsl:call-template name="Calc_IPBlk_W">
			<xsl:with-param name="ip_cnt"   select="($fsl_IP_CNT)"/>
		</xsl:call-template>	
	</xsl:variable>
	
	<xsl:variable name="BLKD_FSL_W">
		<xsl:if test="$fsl_IP_CNT &gt; 0">
			<xsl:value-of select="($BUS_FSL_HCONNE_L + $BUS_FSL_ARROW_W) + $BLKD_FSL_IPBLK_W + $IO_CON_W"/>
		</xsl:if>
		<xsl:if test="not($fsl_IP_CNT &gt; 0)">0</xsl:if>
	</xsl:variable>
	
	<xsl:variable name="BLKD_IPBLK_H">
		<xsl:if test="$BLKD_PLB_IPBLK_H &gt;= $BLKD_OPB_IPBLK_H">
			<xsl:value-of select="$BLKD_PLB_IPBLK_H"/>
		</xsl:if>
		<xsl:if test="$BLKD_OPB_IPBLK_H &gt;= $BLKD_PLB_IPBLK_H">
			<xsl:value-of select="$BLKD_OPB_IPBLK_H"/>
		</xsl:if>
	</xsl:variable>
	
	<xsl:variable name="BLKD_NBIPBLK_H">
		<xsl:variable name="nobus_da_h_">
			<xsl:call-template name="Calc_IPDrawArea_H">
				<xsl:with-param name="ipcnt"   select="$nobus_IP_CNT"/>
			</xsl:call-template>	
		</xsl:variable>	
		
		<xsl:variable name="has_ip_">
			<xsl:if test="$nobus_IP_CNT &gt; 0">1</xsl:if>
			<xsl:if test="not($nobus_IP_CNT &gt; 0)">0</xsl:if>
		</xsl:variable>	
		
		<xsl:value-of select="$nobus_da_h_ + ($IO_CON_W * $has_ip_)"/>
	</xsl:variable>
	
	<xsl:variable name="BLKD_DRAWAREA_W">
		<xsl:choose>
			<xsl:when test="$BLKD_DEF_DRAWAREA_W &gt; ($BLKD_OPB_IPBLK_W + $BLKD_PLB_IPBLK_W + $BLKD_FSL_W)">
				<xsl:value-of select="$BLKD_DEF_DRAWAREA_W"/>
			</xsl:when>	
			
			<xsl:when test="not($BLKD_DEF_DRAWAREA_W &gt; ($BLKD_OPB_IPBLK_W + $BLKD_PLB_IPBLK_W + $BLKD_FSL_W))">
				<xsl:value-of select="($BLKD_OPB_IPBLK_W + $BLKD_PLB_IPBLK_W + $BLKD_FSL_W)"/>
			</xsl:when>	
			
		</xsl:choose>	
	</xsl:variable>
					
<xsl:variable name="BLKD_W" select="($BLKD_DRAWAREA_W + (2 * $BLKD_IORCHAN_W) + (2 * $BLKD_PRTCHAN_W))"/>
<xsl:variable name="BLKD_H" select="( 
 									 ($BLKD_IORCHAN_H * 2)  +
 									 ($BLKD_PRTCHAN_H * 2)  +
									 ($BLKD_GAP_Y * 2)      +
									  $BLKD_PROC_MEM_H      +
									  $BLKD_PROC_H          +
									  $BLKD_PROC2BUS_GAP_Y  +
									  $BLKD_BUSSES_H        +  
									  $BLKD_IPBLK_H         +
									  $BLKD_NBIPBLK_H)"/>
									

<svg width="{$BLKD_W}" height="{$BLKD_H}">
	
<!--	
<xsl:variable name="IP_Y_POS"    select="($BUS_Y_POS       + $BLKD_BUSSES_H)"/>
<xsl:variable name="BUS_Y_POS"   select="($PROC_Y_POS      + $BLKD_PROC_H + $BLKD_PROC2BUS_GAP_Y)"/>
<xsl:variable name="PROC_Y_POS"  select="($BLKD_PRTCHAN_H  + $BLKD_IORCHAN_H + $BLKD_MEM_GAP_Y)"/>
	<FSL_BUS><xsl:value-of select="$fsl_BUS_CNT"/></FSL_BUS>
	<FSL_BIF><xsl:value-of select="$fsl_BIF_CNT"/></FSL_BIF>
	<BUS_H><xsl:value-of select="$BLKD_BUSSES_H"/></BUS_H>
-->	
	
	<!--specify a css for the file -->
	<xsl:processing-instruction name="xml-stylesheet">href="MdtXdsSVG_Render.css" type="text/css"</xsl:processing-instruction>
	
<!-- =============================================== -->
<!--        Layout All the various definitions       -->
<!-- =============================================== -->
	<defs>
		
		<!-- Processor Memory defs -->
		<xsl:call-template name="Layout_ProcMemDefs"/>	
	
		<!-- Processor and Debug defs-->
		<xsl:for-each select="MHSINFO/MODULES/MODULE[@MODCLASS='PROCESSOR']">
			<xsl:call-template name="Layout_ProcessorDefs">
				<xsl:with-param name="fsl_ip_cnt"   select="$fsl_IP_CNT"/>
				<xsl:with-param name="fsl_bif_cnt"  select="$fsl_BIF_CNT"/>
				<xsl:with-param name="proc_height"  select="$BLKD_PROC_H"/>
			</xsl:call-template>
		</xsl:for-each>
			
		<!-- IP block defs -->
		<xsl:call-template name="Layout_IPBlkDefs"/>	
		
		<!-- Bus defs -->
		<xsl:call-template name="Layout_BusDefs">	
				<xsl:with-param name="bus_width_"  select="$BLKD_DRAWAREA_W"/>
		</xsl:call-template>
			
		<!-- IO Port  defs -->
		<xsl:call-template name="Layout_BlkdIOPDefs"/>	

	</defs>
	
	 <!-- The surrounding black liner -->
     <rect x="0"  
		   y="0" 
		   width ="{$BLKD_W}"
		   height="{$BLKD_H}" style="fill:{$BLKD_COL_WHITE}; stroke:{$BLKD_COL_BLACK};stroke-width:4"/>
		   
	 <!-- The outer IO channel -->
     <rect x="{$BLKD_PRTCHAN_W}"  
		   y="{$BLKD_PRTCHAN_H}" 
		   width= "{$BLKD_W - ($BLKD_PRTCHAN_W * 2)}" 
		   height="{$BLKD_H - ($BLKD_PRTCHAN_H * 2)}" style="fill:{$BLKD_COL_IORING}"/>
		   
	 <!-- The Diagram's drawing area -->
     <rect x="{$BLKD_PRTCHAN_W + $BLKD_IORCHAN_W}"  
		   y="{$BLKD_PRTCHAN_H + $BLKD_IORCHAN_H}" 
		   width= "{$BLKD_DRAWAREA_W}" 
		   height="{$BLKD_H - (($BLKD_PRTCHAN_H  + $BLKD_IORCHAN_H)* 2)}" rx="8" ry="8" style="fill:{$BLKD_COL_BG}"/>
		   

<!-- =============================================== -->
<!--        Draw All the various components          -->
<!-- =============================================== -->
	
	<!--   Layout the IO Ports    -->	
	<xsl:call-template name="Draw_IOPorts">		
		<xsl:with-param name="drawarea_w" select="$BLKD_DRAWAREA_W"/>
	 </xsl:call-template>
	 
	<!--   Layout the Processor  -->
	<xsl:variable name="BLKD_PROC_MEM_X_POS">
		<xsl:value-of select="ceiling(($BLKD_W - $BLKD_PROC_MEM_W) div 2)"/>
	</xsl:variable>
	
	<xsl:variable name="BLKD_PROC_MEM_Y_POS">
		<xsl:value-of select="$BLKD_IORCHAN_H + $BLKD_PRTCHAN_H + $BLKD_GAP_Y"/> 
	</xsl:variable>
	
	<xsl:variable name="BLKD_PROC_X_POS">
		<xsl:value-of select="ceiling(($BLKD_W - $BLKD_PROC_W) div 2)"/>
	</xsl:variable>
	
	<xsl:variable name="BLKD_PROC_Y_POS">
		<xsl:value-of select="($BLKD_PROC_MEM_Y_POS + $BLKD_PROC_MEM_H)"/> 
	</xsl:variable>
	
	<xsl:for-each select="MHSINFO/MODULES/MODULE[@MODCLASS='PROCESSOR']">
		
	<!--   Layout the processor memory  -->
	 <xsl:if test="$BLKD_PROC_HASMEM &gt; 0">
		<xsl:call-template name="Draw_ProcessorMemory">	
			<xsl:with-param name="x_pos" select="$BLKD_PROC_MEM_X_POS"/>
			<xsl:with-param name="y_pos" select="$BLKD_PROC_MEM_Y_POS"/>
		</xsl:call-template>
    </xsl:if>
		
		<xsl:call-template name="Draw_Processor">	
			<xsl:with-param name="x_pos" select="$BLKD_PROC_X_POS"/>
			<xsl:with-param name="y_pos" select="$BLKD_PROC_Y_POS"/>
		</xsl:call-template>
		
	</xsl:for-each>		
	
	<!--   Layout the Processor Debug -->
	<xsl:for-each select="MHSINFO/MODULES/MODULE[@MODCLASS='PROCESSOR_DEBUG' and starts-with(@MODTYPE,'opb_mdm')]">
		<xsl:call-template  name="Draw_ProcessorDebug">	
			<xsl:with-param name="PROC_X_POS"      select="$BLKD_PROC_X_POS"/>
			<xsl:with-param name="PROC_Y_POS"      select="$BLKD_PROC_Y_POS + $BLKD_PROC_H - $IP_H"/>
			
<!--			
			<xsl:with-param name="BPROC_W"         select="$BLKD_PROC_H"/>	
			<xsl:with-param name="BPROC_H"         select="$BLKD_PROC_H"/>	
    		<xsl:with-param name="PROC_MDM_GAP_X"  select="$BLKD_PROC2MDM_GAP_X"/>
-->
			
		</xsl:call-template>	
	</xsl:for-each>		
	
	<!--   Layout the Busses     -->
	<xsl:variable name="BLKD_BUS_X_POS">
		<xsl:value-of select="($BLKD_PRTCHAN_W + $BLKD_IORCHAN_W)"/>
	</xsl:variable>
	
	<xsl:variable name="BLKD_BUS_Y_POS">
		<xsl:value-of select="($BLKD_PROC_Y_POS + $BLKD_PROC_H + $BLKD_PROC2BUS_GAP_Y)"/> 
	</xsl:variable>
	
	<xsl:call-template name="Draw_Busses">	
			<xsl:with-param name="proc_type_" select="$BLKD_PROC_TYPE"/>
			<xsl:with-param name="bus_width"  select="$BLKD_DRAWAREA_W"/>
			<xsl:with-param name="x_pos"      select="$BLKD_BUS_X_POS"/>
			<xsl:with-param name="y_pos"      select="$BLKD_BUS_Y_POS"/>
	</xsl:call-template>
	
	
	<!--        Layout the IP Blocks   -->	
	
	<xsl:variable name="BLKD_PERI_X_POS">
		<xsl:value-of select="($BLKD_PRTCHAN_W + $BLKD_IORCHAN_W)"/>
	</xsl:variable>
	
	<xsl:variable name="BLKD_PERI_Y_POS">
		<xsl:value-of select="($BLKD_BUS_Y_POS + $BLKD_BUSSES_H)"/> 
	</xsl:variable>
	
	 <xsl:call-template name="Draw_IPBlocks">	
			<xsl:with-param name="x_pos"   select="$BLKD_PERI_X_POS"/>
			<xsl:with-param name="y_pos"   select="$BLKD_PERI_Y_POS"/>
			<xsl:with-param name="blkd_w"  select="$BLKD_W"/>
			<xsl:with-param name="ipblk_h" select="$BLKD_IPBLK_H"/>
	 </xsl:call-template>
	 
	 
<!-- And the Masterpiece is ready!! -->
</svg>
<!-- ======================= END MAIN SVG BLOCK =============================== -->

</xsl:template>

</xsl:stylesheet>
