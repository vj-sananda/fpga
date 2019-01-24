<?xml version="1.0" standalone="no"?>

<xsl:stylesheet version="1.0"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           xmlns:exsl="http://exslt.org/common"
           xmlns:xlink="http://www.w3.org/1999/xlink">
                
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
	       doctype-public="-//W3C//DTD SVG 1.0//EN"
		   doctype-system="http://www.w3.org/TR/SVG/DTD/svg10.dtd"/>
		   
<xsl:param name="PROC_W"          select="128"/>
<xsl:param name="PROC_DEF_H"      select="128"/>
<xsl:param name="PROC_BANK_GAP"   select="4"/>
<xsl:param name="PROC_BANK_MID_H" select="32"/>

<xsl:param name="PROC_BANK_H"     select="(ceiling($PROC_DEF_H div 2) - $PROC_BANK_GAP)"/>
<xsl:param name="PROC_BANK_W"     select="(ceiling($PROC_W div 2)     - $PROC_BANK_GAP)"/>

<xsl:param name="PROC_MDM_GAP_X"  select="68"/>

<xsl:param name="POPB_ARROW_H"    select="8"/>
<xsl:param name="POPB_ARROW_W"    select="8"/>
<xsl:param name="POPB_CONNE_H"    select="32"/>
<xsl:param name="POPB_HCONNE_L"   select="32"/>
<xsl:param name="POPB_VCONNE_L"   select="50"/>

<xsl:param name="PPLB_ARROW_H"    select="8"/>
<xsl:param name="PPLB_ARROW_W"    select="8"/>
<xsl:param name="PPLB_CONNE_H"    select="32"/>
<xsl:param name="PPLB_HCONNE_L"   select="32"/>
<xsl:param name="PPLB_VCONNE_L"   select="50"/>

<xsl:param name="PMDM_IP_H"       select="64"/>				
<xsl:param name="PMDM_IP_W"       select="96"/>

<xsl:param name="PMDM_COL_YEL"    select="'#FFCC00'"/>
<xsl:param name="PMDM_COL_BLK"    select="'#111111'"/>
<xsl:param name="MBZ_COL_BANK"    select="'#555555'"/>
<xsl:param name="PPC_COL_BANK"    select="'#663300'"/>
<xsl:param name="PROC_COL_BG"     select="'#CCCCCC'"/>				

<!-- ======================= MAIN SVG BLOCK =============================== -->
<xsl:template name="Layout_ProcessorDefs"> 
	
	<xsl:param name="blkd_col_bg"  select="$PROC_COL_BG"/>				
	<xsl:param name="fsl_ip_cnt"   select="0"/>
	<xsl:param name="fsl_bif_cnt"  select="0"/>
	<xsl:param name="proc_height"  select="$PROC_DEF_H"/>

	<xsl:variable name="bank_col">	
		<xsl:choose>
			<xsl:when test="@PROCTYPE = 'MICROBLAZE'">
				<xsl:value-of select="$MBZ_COL_BANK"/>
			</xsl:when>	
			<xsl:when test="@PROCTYPE = 'POWERPC'">
				<xsl:value-of select="$PPC_COL_BANK"/>
			</xsl:when>	
			<xsl:otherwise>
				<xsl:value-of select="$MBZ_COL_BANK"/>
			</xsl:otherwise>
		</xsl:choose>					
	</xsl:variable>
	
	<symbol id="QtrCurve" overflow="visible">
		<path d="M 0   0, 
				 L 24  0, 
				 A 24 24, 0,0,1, 0,24,
				 L 0  0, 
				 Z" style="fill:{$blkd_col_bg};fill-opacity:1.0;stroke:none"/> 
	</symbol> 
	 
	<symbol id="PROC_BankGen" overflow="visible">
		<rect x="0" y="0"  width="{$PROC_BANK_W}" height="{$PROC_BANK_H}" style="fill:{$bank_col}"/>
		<use  x="0"  y="0" xlink:href="#QtrCurve"/>	
  	</symbol>	
  	
	<symbol id="PROC_BankUL" overflow="visible">
		<use  x="0"  y="0" xlink:href="#PROC_BankGen"/>	
  	</symbol>	
  	
	<symbol id="PROC_BankUR" overflow="visible">
		<use  x="0"  y="0" xlink:href="#PROC_BankGen" transform="scale(-1,1) translate({$PROC_BANK_W * -1},0)"/>	
  	</symbol>	
  	
	<symbol id="PROC_BankLL" overflow="visible">
		<use  x="0"  y="0" xlink:href="#PROC_BankGen" transform="scale(1,-1) translate(0,{$PROC_BANK_H * -1})"/>	
  	</symbol>	
  	
	<symbol id="PROC_BankLR" overflow="visible">
		<use  x="0"  y="0" xlink:href="#PROC_BankGen" transform="scale(-1,-1) translate({$PROC_BANK_W * -1},{$PROC_BANK_H * -1})"/>	
  	</symbol>	
	
	<symbol id="PROC_BankMD" overflow="visible">
		<rect x="0" y="0"  width="{$PROC_BANK_W}" height="{$PROC_BANK_MID_H}" style="fill:{$bank_col}"/>
  	</symbol>	
	
<!--  ====================================OPB CONNECTORS=======================================	 -->
	<xsl:call-template name="Layout_ArrowHDef"> 
		<xsl:with-param name="bus_col"     select="$BLKD_COL_OPBBUS"/>
		<xsl:with-param name="bus_type"    select="'OPB'"/>
		<xsl:with-param name="bus_arrow_w" select="$POPB_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$POPB_ARROW_H"/>
	</xsl:call-template>
	
	<xsl:call-template name="Layout_ArrowVDef"> 
		<xsl:with-param name="bus_col"     select="$BLKD_COL_OPBBUS"/>
		<xsl:with-param name="bus_type"    select="'OPB'"/>
		<xsl:with-param name="bus_arrow_w" select="$POPB_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$POPB_ARROW_H"/>
	</xsl:call-template>
	
	<xsl:call-template name="Layout_ConnIDef"> 
		<xsl:with-param name="bus_col"      select="$BLKD_COL_OPBBUS"/>
		<xsl:with-param name="bus_type"     select="'OPB'"/>
		<xsl:with-param name="bus_hconne_l" select="$POPB_HCONNE_L"/>
		<xsl:with-param name="bus_vconne_l" select="$POPB_VCONNE_L"/>
	</xsl:call-template>
	
	<symbol id="PROC_OPBConnD">
		<use   y="0"  x="0"  xlink:href="#PROC_OPBConnI" transform="scale(-1,1) translate({(($POPB_HCONNE_L + $POPB_ARROW_W) * -1)},0)"/>	
	</symbol>
	
<!--  ====================================PLB CONNECTORS=======================================	 -->
	<xsl:call-template name="Layout_ArrowHDef"> 
		
		<xsl:with-param name="bus_col"     select="$BLKD_COL_PLBBUS"/>
		<xsl:with-param name="bus_type"    select="'PLB'"/>
		<xsl:with-param name="bus_arrow_w" select="$PPLB_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$PPLB_ARROW_H"/>
	</xsl:call-template>
	
	<xsl:call-template name="Layout_ArrowVDef"> 
		<xsl:with-param name="bus_col"     select="$BLKD_COL_PLBBUS"/>
		<xsl:with-param name="bus_type"    select="'PLB'"/>
		<xsl:with-param name="bus_arrow_w" select="$PPLB_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$PPLB_ARROW_H"/>
	</xsl:call-template>
	
	<xsl:call-template name="Layout_ConnIDef"> 
		<xsl:with-param name="bus_col"      select="$BLKD_COL_PLBBUS"/>
		<xsl:with-param name="bus_type"     select="'PLB'"/>
		<xsl:with-param name="bus_hconne_l" select="$PPLB_HCONNE_L"/>
		<xsl:with-param name="bus_vconne_l" select="$PPLB_VCONNE_L"/>
	</xsl:call-template>
	
	<symbol id="PROC_PLBConnD">
		<use   y="0"  x="0"  xlink:href="#PROC_PLBConnI" transform="scale(-1,1) translate({(($PPLB_HCONNE_L + $PPLB_ARROW_W) * -1)},0)"/>	
	</symbol>

<!--  ==================================================================================	 -->
	
<!-- ADD Microprocessor block-->
	<symbol id="PROC_Body" overflow="visible">
	
		
		
		<xsl:variable name="fsl_bank_h_"  select="($PROC_BANK_MID_H   * $fsl_bif_cnt)"/>
		<xsl:variable name="fsl_gap_h_"   select="($PROC_BANK_GAP     * $fsl_bif_cnt)"/>
		
		<xsl:variable name="fsl_h_"       select="($fsl_bank_h_       + $fsl_gap_h_)"/>
		
		<xsl:variable name="mid_h_"       select="$fsl_h_"/>
		
<!-- Add Debug information -->
		<xsl:if test="@MODTYPE='microblaze' and MPARM[@PNAME='C_DEBUG_ENABLED' and @VALUE='1']"> 
			<rect  x="-4" y="-12" 
				width= "{$PROC_W + 4}"
				height="{$proc_height + 24}"
				rx="4" ry="4"
				style="fill:{$PROC_COL_BG};stroke:{$PMDM_COL_YEL}; stroke-width:2;"/>
		   <text class="dbglabel" 
				 x="{ceiling($PROC_BANK_W + 4)}"
			     y="-14">DEBUG MODE</text>
			     
		<rect  x="{$PROC_MDM_GAP_X * - 1}" 
			   y="{$proc_height - ceiling($PROC_BANK_H div 2)}"	
				   width= "{$PROC_MDM_GAP_X - 4}"
				   height="4"
				   style="fill:{$PMDM_COL_BLK};stroke:none;"/>
			
		<rect  x="-8" 
			   y="{$proc_height - ceiling($PROC_BANK_H div 2)}"	
			   width= "4"
			   height="12"
			   style="fill:{$PMDM_COL_BLK};stroke:none;"/>
		</xsl:if>
		
<!-- Default Banks, always drawn to give the processor at least some body -->
		<use  x="0"
			  y="0"
			  xlink:href="#PROC_BankUL"/>	
			  
		<use  x="{$PROC_BANK_W + $PROC_BANK_GAP}"  
			  y="0"
			  xlink:href="#PROC_BankUR"/>	
			  
		<use  x="0"                                
			  y="{$PROC_BANK_H + $PROC_BANK_GAP + $fsl_h_}" 
			  xlink:href="#PROC_BankLL"/>	
			  
		<use  x="{$PROC_BANK_W + $PROC_BANK_GAP}"  
			  y="{$PROC_BANK_H + $PROC_BANK_GAP + $fsl_h_}"
			  xlink:href="#PROC_BankLR"/>	
		
			<text class="iptype" 
				  x="{ceiling((($PROC_BANK_W * 2) + 4) div 2)}" 
				  y="-2">
				<xsl:value-of select="@MODTYPE"/>
			</text>
			
			<text class="iplabel" 
				  x="{ceiling((($PROC_BANK_W * 2) + 4) div 2)}" 
				  y="{$proc_height + 8}">
				<xsl:value-of select="@INSTANCE"/>
			</text>
			
<!-- =========================================== PROCESSOR MEMORY INTERFACES ============================================ -->
			<xsl:for-each select="BUSINTERFACE[@BUSDOMAIN = 'LMB' or @BUSDOMAIN = 'OCM']">
				<xsl:choose>
					  
				<xsl:when test="@BIFNAME = 'DLMB'">
					
					<text class="lmbbif" 
						  x="{($PROC_BANK_W + $PROC_BANK_GAP) + ceiling($PROC_BANK_W div 2)}" 
						  y="{ceiling($PROC_BANK_H div 2) + 8}">DLMB</text>
						
					<use x="{$PROC_W -2}" 
						 y="{((ceiling($PROC_BANK_H div 2) - 12) * -1)}"  
						 xlink:href="#LMB_BusShapeD"/>
						
					<xsl:variable name="dlmbbusname">
						<xsl:value-of select="@BUSNAME"/>	
					</xsl:variable>
						
					<xsl:for-each select="../../MODULE[@INSTANCE=$dlmbbusname]">
					   <text class="iptype" 
						     x="{($PROC_BANK_W * 2) + $BUS_LMB_HCONNE_L + ($BUS_LMB_ARROW_W * 2)}" 
							 y="{ceiling($PROC_BANK_H div 2) + 4}">
							<xsl:value-of select="@MODTYPE"/>
					   </text>
						   
					   <text class="iplabel" 
						     x="{($PROC_BANK_W * 2) + $BUS_LMB_HCONNE_L + ($BUS_LMB_ARROW_W * 2)}" 
							 y="{ceiling($PROC_BANK_H div 2) + 20}">
							<xsl:value-of select="@INSTANCE"/>
					   </text>
					</xsl:for-each>
				</xsl:when>	
					
				<xsl:when test="@BIFNAME = 'ILMB'">
					
					<text class="lmbbif" x="{ceiling($PROC_BANK_W div 2)}" y="{ceiling($PROC_BANK_H div 2) + 8}">ILMB</text>
					<use x="{(($BUS_LMB_HCONNE_L + $BUS_LMB_ARROW_W) * -1)}" y="{((ceiling($PROC_BANK_H div 2) - 12) * -1)}" xlink:href="#LMB_BusShapeI"/>
						
					<xsl:variable name="lmbbusname">
						<xsl:value-of select="@BUSNAME"/>	
					</xsl:variable>
						
					<xsl:for-each select="../../MODULE[@INSTANCE=$lmbbusname]">
					   <text class="iptype" 
						     x="{(($BUS_LMB_HCONNE_L + $BUS_LMB_ARROW_W) * -1) - 16}" 
							 y="{ceiling($PROC_BANK_H div 2) + 4}">
							<xsl:value-of select="@MODTYPE"/>
					   </text>
					   
					   <text class="iplabel" 
						     x="{(($BUS_LMB_HCONNE_L + $BUS_LMB_ARROW_W) * -1) -16}" 
							 y="{ceiling($PROC_BANK_H div 2) + 20}">
							<xsl:value-of select="@INSTANCE"/>
					   </text>
				  </xsl:for-each>
			</xsl:when>	
			
			</xsl:choose>
		</xsl:for-each>
			
<!-- =========================================== PROCESSOR FSL INTERFACES ============================================ -->
		<xsl:for-each select="BUSINTERFACE[@BUSDOMAIN = 'FSL']">
			
			<xsl:variable name="bank_y_">
				  <xsl:value-of select="($PROC_BANK_H + $PROC_BANK_GAP) + ((position() - 1) * ($PROC_BANK_MID_H + $PROC_BANK_GAP))"/>
			</xsl:variable>
			
			<xsl:variable name="busname_">
				<xsl:value-of select="@BUSNAME"/>
			</xsl:variable>
			
			<xsl:variable name="fsl_modtype_">
				<xsl:for-each select="../../MODULE[@MODCLASS='BUS' and @INSTANCE=$busname_]">
					<xsl:value-of select="@MODTYPE"/>
				</xsl:for-each>	
			</xsl:variable>	
			
<!--			
				  <xsl:value-of select="($PROC_BANK_H + $PROC_BANK_GAP) + ((position() - 1) * ($PROC_BANK_MID_H + $PROC_BANK_GAP))"/>
					<xsl:value-of select="@MODTYPE"/>	
			<FSL_MOD><xsl:value-of select="$fsl_modtype_"/></FSL_MOD>
-->					
			
			<xsl:variable name="fsl_bus_ofs_y_">
				<xsl:value-of select="ceiling(($PROC_BANK_MID_H - $BUS_FSL_ARROW_H) div 2)"/>
			</xsl:variable>
			
			<use  x="0"
				  y="{$bank_y_}"
			      xlink:href="#PROC_BankMD"/>	
			  
			<use  x="{$PROC_BANK_W + $PROC_BANK_GAP}"  
				  y="{$bank_y_}"
			      xlink:href="#PROC_BankMD"/>	
				  
			<text style="fill:{$BLKD_COL_FSLBUS};
				stroke:none; 
				font-size:10pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{$PROC_W   - ceiling($PROC_BANK_W div 2)}" 
				y="{$bank_y_  + ceiling($PROC_BANK_H div 2) - 6}">
				<xsl:value-of select="@BIFNAME"/>
			</text>
		
		  <text class="iptype" 
				x="{ceiling(($BUS_FSL_ARROW_W  + $BUS_FSL_HCONNE_L) div 2) + $PROC_W}" 
				y="{$bank_y_ + $fsl_bus_ofs_y_ + 4}">
					<xsl:value-of select="$fsl_modtype_"/>
		  </text>

	   <text class="iplabel" 
			 x="{ceiling(($BUS_FSL_ARROW_W  + $BUS_FSL_HCONNE_L) div 2) + $PROC_W}" 
			 y="{$bank_y_ + $fsl_bus_ofs_y_ + $BUS_FSL_ARROW_H + 4}">
					<xsl:value-of select="@BUSNAME"/>
	   </text>
			
		<xsl:if test="@BIFCLASS = 'MASTER'">
			<use  x="{$PROC_W - $PROC_BANK_GAP}"  
				  y="{$bank_y_ + $fsl_bus_ofs_y_}"
			      xlink:href="#FSL_BusMaster"/>	
				  
			<text style="fill:{$BLKD_COL_FSLBUS_TXT};
				stroke:none; 
				font-size:8pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{ceiling(($BUS_FSL_ARROW_W  + $BUS_FSL_HCONNE_L) div 2) + $PROC_W}" 
				y="{$bank_y_ + $fsl_bus_ofs_y_ + ceiling($BUS_FSL_ARROW_H div 2) + 4}">FSL MASTER</text>	
			
		</xsl:if>
		
		<xsl:if test="not(@BIFCLASS = 'MASTER')">
			<use  x="{$PROC_W - $PROC_BANK_GAP}"  
				  y="{$bank_y_ + $fsl_bus_ofs_y_}"
			      xlink:href="#FSL_BusSlave"/>	
				  
			<text style="fill:{$BLKD_COL_FSLBUS_TXT};
				stroke:none; 
				font-size:8pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{ceiling(($BUS_FSL_ARROW_W  + $BUS_FSL_HCONNE_L) div 2) + $PROC_W}" 
				y="{$bank_y_ + $fsl_bus_ofs_y_ + ceiling($BUS_FSL_ARROW_H div 2) + 4}">FSL SLAVE</text>	
			
		</xsl:if>
		
<!--				  
		y="{$bank_y_ + $fsl_bus_ofs_y_ + ceiling($BUS_FSL_ARROW_H div 2)}">MASTER</text>	
		<xsl:if test="">
			<use  x="{$PROC_BANK_W + $PROC_BANK_GAP}"  
				  y="{$bank_y_}"
			      xlink:href="#PROC_BankMD"/>	
		</xsl:if>
		<BIX><xsl:value-of select="$busindex_"/></BIX>
-->	
				  
				  
		</xsl:for-each>
		
	<xsl:if test="$fsl_ip_cnt &gt; 0">
		<use  x="{$PROC_W + $BUS_FSL_ARROW_W + $BUS_FSL_HCONNE_L}"  
			  y="{$PROC_BANK_H}"   
			  xlink:href="#fsl_IP_DrawArea"/>
	</xsl:if>		
	    
<!-- =========================================== PROCESSOR DATA BUS INTERFACES ============================================ -->
		<xsl:for-each select="BUSINTERFACE[@BUSDOMAIN = 'OPB' or @BUSDOMAIN = 'PLB']">
			
			<xsl:variable name="busname_">
				<xsl:value-of select="@BUSNAME"/>
			</xsl:variable>
			
			<xsl:variable name="busindex_">
				<xsl:for-each select="../../../../RENDERINFO/BUSSHAPE[@INSTANCE=$busname_]">
					<xsl:value-of select="@BUSINDEX"/>
				</xsl:for-each>	
			</xsl:variable>
			
		    <xsl:variable name="bus_con_h_" 
				          select="ceiling($PROC_BANK_H div 2) + $BLKD_PROC2BUS_GAP_Y + ($busindex_ * ($BUS_BRIDGE_H + $BUS_ARROW_H)) + $PROC_BANK_GAP"/>
					  
			<xsl:choose>
				
				<xsl:when test="@BIFNAME = 'DOPB'">
					<text class="opbbif" 
						x="{          ($PROC_BANK_W + 4) + ceiling($PROC_BANK_W div 2)}" 
						y="{$mid_h_ + ($PROC_BANK_H + 4) + ceiling($PROC_BANK_H div 2)}">DOPB</text>
						
					<use x="{$PROC_W}" 
						 y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - 8}" xlink:href="#PROC_OPBConnD"/>
						 
					<rect  x="{$PROC_W + $POPB_ARROW_W + $POPB_HCONNE_L - $PROC_BANK_GAP - 2}" 
						   y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - $PROC_BANK_GAP }"
						   height="{$bus_con_h_}" 
						   width="2"  style="fill:{$BLKD_COL_OPBBUS};"/>
						   
					<use  x="{$PROC_W + $POPB_ARROW_W + $POPB_HCONNE_L - $PROC_BANK_GAP - 5}" 
					      y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - $PROC_BANK_GAP + $bus_con_h_}"
						  xlink:href="#PROC_OPBArrowV"/>	
				</xsl:when>	
					
				<xsl:when test="@BIFNAME = 'DPLB'">
					<text class="plbbif" 
						x="{($PROC_BANK_W + 4) + ceiling($PROC_BANK_W div 2)}" 
						y="{$mid_h_ + ($PROC_BANK_H + 4) + ceiling($PROC_BANK_H div 2)}">DPLB</text>
						
					<use x="{$PROC_W}" 
						 y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - 8}" xlink:href="#PROC_PLBConnD"/>
					
					<rect  x="{$PROC_W + $PPLB_ARROW_W + $PPLB_HCONNE_L - $PROC_BANK_GAP - 2}" 
						   y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - $PROC_BANK_GAP }"
						   height="{$bus_con_h_}" 
						   width="2"  style="fill:{$BLKD_COL_PLBBUS};"/>
						   
					<use  x="{$PROC_W + $PPLB_ARROW_W + $PPLB_HCONNE_L - $PROC_BANK_GAP - 5}" 
					      y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - $PROC_BANK_GAP + $bus_con_h_}"
						  xlink:href="#PROC_PLBArrowV"/>	
				</xsl:when>	
					
				<xsl:when test="@BIFNAME = 'IOPB'">
					<text class="opbbif" 
						  x="{ceiling($PROC_BANK_W div 2)}" 
						  y="{$mid_h_  + ($PROC_BANK_H + 4) + ceiling($PROC_BANK_H div 2)}">IOPB</text>
					<use x="{(($POPB_HCONNE_L + $POPB_ARROW_W) * -1) - $PROC_BANK_GAP}"  
						 y="{$mid_h_ + ($PROC_BANK_H + 4) + ceiling($PROC_BANK_H div 2) - 8}" xlink:href="#PROC_OPBConnI"/>
						 
					<rect  x="{(($POPB_HCONNE_L + $POPB_ARROW_W) * -1)}"  
						   y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - $PROC_BANK_GAP }"
						   height="{$bus_con_h_}" 
						   width="2"  style="fill:{$BLKD_COL_OPBBUS};"/>
						   
					<use  x="{(($POPB_HCONNE_L + $POPB_ARROW_W) * -1) - 3}"  
					      y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - $PROC_BANK_GAP + $bus_con_h_}"
						  xlink:href="#PROC_OPBArrowV"/>	
						   
				</xsl:when>	
					
				<xsl:when test="@BIFNAME = 'IPLB'">
					
					<text class="plbbif" 
						x="{ceiling($PROC_BANK_W div 2)}" 
						y="{$mid_h_ + ($PROC_BANK_H + 4) + ceiling($PROC_BANK_H div 2)}">IPLB</text>
						
					<use x="{(($PPLB_HCONNE_L + $PPLB_ARROW_W) * -1) -4}"  
						 y="{$mid_h_ + ($PROC_BANK_H + 4) + ceiling($PROC_BANK_H div 2) - 8}" xlink:href="#PROC_PLBConnI"/>
						 
					<rect  x="{(($PPLB_HCONNE_L + $PPLB_ARROW_W) * -1)}"  
						   y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - $PROC_BANK_GAP }"
						   height="{$bus_con_h_}" 
						   width="2"  style="fill:{$BLKD_COL_PLBBUS};"/>
						   
					<use  x="{(($PPLB_HCONNE_L + $PPLB_ARROW_W) * -1) - 3}"  
					      y="{$mid_h_ + ($PROC_BANK_H + $PROC_BANK_GAP) + ceiling($PROC_BANK_H div 2) - $PROC_BANK_GAP + $bus_con_h_}"
						  xlink:href="#PROC_PLBArrowV"/>	
						   
				</xsl:when>	
					
			</xsl:choose>
		</xsl:for-each>			
		
		<circle cx="{ceiling(($PROC_W div 2))}" 
			    cy="{ceiling($proc_height div 2)}" 
				r="18" style="fill:{$PROC_COL_BG}"/>
		
		<xsl:choose>
			<xsl:when test="@PROCTYPE = 'POWERPC'">
				<text class="proclabel" 
					x="{ceiling(($PROC_W div 2))}" 
					y="{ceiling(($proc_height div 2))}">&#929;</text>
			</xsl:when>					
			<xsl:when test="@PROCTYPE = 'MICROBLAZE'">
				<text class="proclabel" 
					x="{ceiling(($PROC_W div 2))}" 
					y="{ceiling(($proc_height div 2))}">&#181;</text>
			</xsl:when>					
		</xsl:choose>
			
	</symbol>	
	
  	
<!-- DEBUG MDM Block-->
	<symbol id="PROC_MDM_OPBConn" overflow="visible">
		
		<use   x="0" y="0"  
			   xlink:href="#PROC_OPBArrowV" transform="scale(1,-1) translate(0,{$POPB_ARROW_H * -1})"/>	
			   
		<use   x="0" y="18"   
			   xlink:href="#PROC_OPBArrowV"/>	
			
			
		<rect  x="3" y="{$POPB_ARROW_H - 2}"  height="16" width="2"  style="fill:{$BLKD_COL_OPBBUS};"/>
		
		
	</symbol>
	
	<xsl:for-each select="../MODULE[@MODCLASS='PROCESSOR_DEBUG' and @MODTYPE='opb_mdm']">
	
		<symbol id="PROC_MDM_Body" overflow="visible">
	
			<rect x="0"
			      y="0"
		          rx="3" ry="3" 
		          width ="{$PMDM_IP_W}" 
		          height="{$PMDM_IP_H}" 
				  style="fill:{$PMDM_COL_YEL}; fill-opacity: 0.8; stroke:{$PMDM_COL_BLK}; stroke-width:3"/> 
		   
			<image x="{ceiling($PMDM_IP_W div 2) - 16}"
			       y="{ceiling($PMDM_IP_H div 2) - 16}"
		           width="32" height="32" xlink:href="ICON_MDMDebug.gif"/> 	   
		   
			<text class="iptype"
			   x="{ceiling(($PMDM_IP_W div 2))}"  
			   y="12">
				<xsl:value-of select="@MODTYPE"/>
			</text>   
	
			<text class="iplabel"
			   x="{ceiling(($PMDM_IP_W div 2))}"  
			   y="{$PMDM_IP_H - 4}">
				<xsl:value-of select="@INSTANCE"/>
			</text>  
			
		   <use  x="{ceiling($PMDM_IP_W div 2)}"  
			     y="{$PMDM_IP_H + 4}"  
				 xlink:href="#PROC_MDM_OPBConn"/>	
			
		</symbol>	
	
	</xsl:for-each>
  
</xsl:template>
	
<xsl:template name="Layout_ArrowHDef"> 
	<xsl:param name="bus_col"     select="'OPB'"/>
	<xsl:param name="bus_type"    select="'OPB'"/>
	<xsl:param name="bus_arrow_w" select="20"/>
	<xsl:param name="bus_arrow_h" select="20"/>
	
	<symbol id="PROC_{$bus_type}ArrowH">
		<path class="bus"
			  d="M   0,0
				 L   {$bus_arrow_w}, {ceiling($bus_arrow_h div 2)}
				 L   0,{$bus_arrow_h}, 
				 Z" style="stroke:none; fill:{$bus_col}"/>
	</symbol>
</xsl:template>

<xsl:template name="Layout_ArrowVDef"> 
	<xsl:param name="bus_col"     select="'OPB'"/>
	<xsl:param name="bus_type"    select="'OPB'"/>
	<xsl:param name="bus_arrow_w" select="20"/>
	<xsl:param name="bus_arrow_h" select="20"/>
	
	<symbol id="PROC_{$bus_type}ArrowV">
		<path class="bus"
			  d="M   0,0
				 L   {$bus_arrow_w},0
				 L   {ceiling($bus_arrow_w div 2)}, {$bus_arrow_h}
				 Z" style="stroke:none; fill:{$bus_col}"/>
	</symbol>
</xsl:template>

<xsl:template name="Layout_ConnIDef"> 
	<xsl:param name="bus_col"     select="$BLKD_COL_OPBBUS"/>
	<xsl:param name="bus_type"    select="'OPB'"/>
	<xsl:param name="bus_hconne_l" select="20"/>
	<xsl:param name="bus_vconne_l" select="20"/>
	
	<symbol id="PROC_{$bus_type}ConnI">
		<rect  x="4" y="3" width= "{$bus_hconne_l}" height="2" style="fill:{$bus_col};"/>
		<use   x="{$bus_hconne_l}"  y="0"  xlink:href="#PROC_{$bus_type}ArrowH"/>	
<!--		
		<rect  x="3" y="3" height="{$bus_vconne_l}" width="2"  style="fill:{$bus_col};"/>
		<use   y="{$bus_vconne_l}"  x="0"  xlink:href="#PROC_{$bus_type}ArrowV"/>	
-->	
	</symbol>
</xsl:template>

<xsl:template name="Draw_Processor"> 
	<xsl:param name="x_pos" select="100"/>
	<xsl:param name="y_pos" select="100"/>
	
	<use  x="{$x_pos}"  y="{$y_pos}"   xlink:href="#PROC_Body"/>	
	
</xsl:template>

<xsl:template name="Draw_ProcessorDebug"> 

	<xsl:param name="BPROC_W"        select="$PROC_W"/>				
	<xsl:param name="BPROC_H"        select="$PROC_BANK_H"/>
	<xsl:param name="PROC_X_POS"     select="20"/>
	<xsl:param name="PROC_Y_POS"     select="20"/>
	<xsl:param name="PROC_MDM_GAP_X" select="70"/>
	
	<use  x="{$PROC_X_POS - ($PROC_MDM_GAP_X + $PMDM_IP_W)}"  
	      y="{$PROC_Y_POS + ceiling($PROC_BANK_H div 2) - ceiling($PMDM_IP_H div 2)}" 
		  xlink:href="#PROC_MDM_Body"/>
</xsl:template>

<xsl:template name="Calc_Proc_H"> 
	
	<xsl:variable name="def_bank_h_"  select="($PROC_BANK_H * 2)"/>
	<xsl:variable name="fsl_BIF_CNT"  select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PROCESSOR']/BUSINTERFACE[@BUSDOMAIN='FSL'])"/>
	
	<xsl:variable name="fsl_bank_h_"  select="($fsl_BIF_CNT * $PROC_BANK_MID_H)"/>
	
	<xsl:variable name="bank_gap_h_"  select="(($fsl_BIF_CNT + 1) * $PROC_BANK_GAP)"/>
	
	<xsl:value-of select="$def_bank_h_ + $fsl_bank_h_ + $bank_gap_h_"/>
	
</xsl:template>

<xsl:template name="Calc_Proc_W"> 
	<xsl:value-of select="$PROC_W"/>
</xsl:template>

</xsl:stylesheet>
