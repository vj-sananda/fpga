<?xml version="1.0" standalone="no"?>
<xsl:stylesheet version="1.0"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           xmlns:exsl="http://exslt.org/common"
           xmlns:xlink="http://www.w3.org/1999/xlink">
                
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
	       doctype-public="-//W3C//DTD SVG 1.0//EN"
		   doctype-system="http://www.w3.org/TR/SVG/DTD/svg10.dtd"/>
			
<xsl:param name="IP_H"       select="64"/>				
<xsl:param name="IP_W"       select="96"/>				
<xsl:param name="IP_H_GAP"   select="16"/>				
<xsl:param name="IP_V_GAP"   select="16"/>			
<xsl:param name="IP_PER_ROW" select="3"/>				

<xsl:param name="IPBG_V_GAP" select="8"/>				
<xsl:param name="IPBG_H_GAP" select="8"/>				

<xsl:param name="IP_COL_BLKBG"  select="'#F0F0F0'"/>				
<xsl:param name="IP_COL_OPBBG"  select="'#CCFF99'"/>				
<xsl:param name="IP_COL_PLBBG"  select="'#F9E08E'"/>				
<xsl:param name="IP_COL_FSLBG"  select="'#FFAAFF'"/>				

<xsl:param name="IP_ARROW_H"  select="8"/>
<xsl:param name="IP_ARROW_W"  select="8"/>
<xsl:param name="IPOPB_HCONNE_L" select="32"/>

<xsl:param name="IPIO_ARROW_H"  select="16"/>
<xsl:param name="IPIO_ARROW_W"  select="16"/>
<xsl:param name="IPIO_HCONNE_L" select="64"/>
<xsl:param name="IPIO_VCONNE_L" select="ceiling($IPIO_ARROW_H div 2)"/>

<xsl:param name="IO_CON_W"      select="(($IPIO_ARROW_H * 2) + $IPIO_HCONNE_L)"/>
<xsl:param name="BUS_CON_H"     select="(($IP_ARROW_H * 2)   + $IPOPB_HCONNE_L)"/>
<xsl:param name="PLB_CON_H"     select="(($IP_ARROW_H * 2)   + $IPOPB_HCONNE_L)"/>

<!-- ======================= MAIN BLOCK =============================== -->
<xsl:template name="Layout_IPBlkDefs">

<!-- =================================IO CONNECTOR DEFINITIONS ======================================== -->	
	 <symbol id="IPIO_Arrow">
		<path class="bus"
			  d="M   0    0, 
				 L     {$IPIO_ARROW_W},  {ceiling($IPIO_ARROW_H div 2)}, 
				 L   0,{$IPIO_ARROW_H}, 
				 Z" style="stroke:none; fill:{$BLKD_COL_IORING}"/>
	</symbol>
	
	 <symbol id="IPIO_Connector" overflow="visible">
		<use   x="{$IPIO_HCONNE_L + $IPIO_ARROW_W}" y="0"  xlink:href="#IPIO_Arrow"/>
		<use   x="0"  y="0"  xlink:href="#IPIO_Arrow" transform="scale(-1,1) translate({$IPIO_ARROW_W * -1},0)"/>
		<rect  x="{$IPIO_ARROW_W}"  
			   y="{ceiling($IPIO_ARROW_H div 2) - ceiling((ceiling($IPIO_ARROW_H div 2) div 2))}" 
			   width= "{$IPIO_HCONNE_L}" 
			   height="{ceiling($IPIO_ARROW_H div 2)}" 
			   style="fill:{$BLKD_COL_IORING};"/> 
		<text class="buslabel" x="{ceiling($IO_CON_W div 2)}" y="2">IO</text>
		<text class="buslabel" x="{ceiling($IO_CON_W div 2)}" y="22">Connections</text>
	</symbol>	

<!-- ================================= OPB DEFINITIONS =========================================== -->	

	<xsl:variable name="opb_IP_CNT"     select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and (@BUSDOMAIN_IS_OPB='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>
	<xsl:variable name="opb_MSHP_CNT"   select="count(RENDERINFO/MEMSHAPE[(@BUSDOMAIN_IS_OPB='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>

	<xsl:variable name="opb_IP_BlkComp_H">
		<xsl:call-template name="Calc_IPBlk_H">
			<xsl:with-param name="ip_cnt"   select="$opb_IP_CNT"/>
			<xsl:with-param name="ms_cnt"   select="$opb_MSHP_CNT"/>
		</xsl:call-template>
	</xsl:variable>  
	
	<xsl:variable name="opb_IP_Bg_H" select="($opb_IP_BlkComp_H - $BUS_CON_H)"/>  
	
	<xsl:variable name="opb_IP_Bg_W">
		
		<xsl:variable name="ip_per_row_">
			<xsl:if test="$opb_IP_CNT &gt;= $IP_PER_ROW">
				<xsl:value-of select="$IP_PER_ROW"/>
			</xsl:if>
			<xsl:if test="not($opb_IP_CNT &gt;= $IP_PER_ROW)">
				2
			</xsl:if>
		</xsl:variable>
		
		<xsl:if test="($opb_IP_CNT &gt; 0)">
			<xsl:value-of select="($ip_per_row_ * ($IP_H_GAP + $IP_W)) + $IP_H_GAP"/>
		</xsl:if>
		<xsl:if test="not($opb_IP_CNT &gt; 0)">
			<xsl:value-of select="$opb_IP_CNT"/>
		</xsl:if>
	</xsl:variable>  
	
	<symbol id="opb_IP_Bg" overflow="visible">
		<rect x="0" 
			  y="0" 
			  rx="10" 
			  ry="10"
			  width="{ $opb_IP_Bg_W}" 
			  height="{$opb_IP_Bg_H}" 
			  style="fill:{$IP_COL_OPBBG};stroke:none;stroke-width:3;opacity:0.5"/>
	</symbol>

	<xsl:call-template name="Layout_BusNorthArrowDef">
		<xsl:with-param name="bus_col"     select="$BLKD_COL_OPBBUS"/>
		<xsl:with-param name="bus_type"    select="'OPB'"/>
		<xsl:with-param name="bus_arrow_w" select="$IP_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$IP_ARROW_H"/>	
	</xsl:call-template>	
	
	<symbol id="IPOPB_ArrowSouth">
		<use   x="0"   y="0"  xlink:href="#IPOPB_ArrowNorth" transform="scale(1,-1) translate(0,{$IP_ARROW_H * -1})"/>
	</symbol>

	<xsl:call-template name="Layout_BUSConnectorDef">
		<xsl:with-param name="bus_col"      select="$BLKD_COL_OPBBUS"/>
		<xsl:with-param name="bus_type"     select="'OPB'"/>
		<xsl:with-param name="bus_arrow_h"  select="$IP_ARROW_H"/>
		<xsl:with-param name="bus_arrow_w"  select="$IP_ARROW_W"/>
		<xsl:with-param name="bus_hconne_l" select="$IPOPB_HCONNE_L"/>	
	</xsl:call-template>	

	<symbol id="opb_IP_DrawArea">
		
		<use  x="0"  y="0"  xlink:href="#opb_IP_Bg"/>
		
		<xsl:for-each select="MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and @BUSDOMAIN_IS_OPB='TRUE']">
			
			<xsl:call-template name="Layout_IPDef">
				<xsl:with-param name="ip_pos"  select="position()"/>
				<xsl:with-param name="ip_name" select="@INSTANCE"/>
				<xsl:with-param name="ip_type" select="@MODTYPE"/>
			</xsl:call-template>
			
		</xsl:for-each>
		
		<xsl:variable name="last_ip_row" select="ceiling(($opb_IP_CNT div $IP_PER_ROW))"/>
		
		<xsl:for-each select="RENDERINFO/MEMSHAPE[@BUSDOMAIN_IS_OPB='TRUE' and not(@BUSDOMAIN_IS_MUL)]">
			
			<xsl:variable name="mc_name">
				<xsl:choose>
					<xsl:when test="@DCNAME and not(@DCNAME='')">
					<xsl:value-of select="@DCNAME"/>
					</xsl:when>
				<xsl:when test="@ICNAME and not(@ICNAME='')">
					<xsl:value-of select="@ICNAME"/>
				</xsl:when>
				<xsl:otherwise>
					UNKNOWN	NAME
				</xsl:otherwise>
				</xsl:choose>				
				
			</xsl:variable>
			
			<xsl:variable name="mc_type">
				
				<xsl:choose>
					<xsl:when test="@DCTYPE and not(@DCTYPE='')">
						<xsl:value-of select="@DCTYPE"/>
					</xsl:when>
				
					<xsl:when test="@ICTYPE and not(@ICTYPE='')">
						<xsl:value-of select="@ICTYPE"/>
					</xsl:when>
					<xsl:otherwise>
						UNKNOWN	TYPE
					</xsl:otherwise>
				</xsl:choose>	
				
			</xsl:variable>
			
			<xsl:variable name="is_ext">
				<xsl:if test="(@EXT_MEMORY='TRUE')">1</xsl:if>
				<xsl:if test="not(@EXT_MEMORY='TRUE')">0</xsl:if>
			</xsl:variable>
			
			<xsl:call-template name="Layout_MSHPDef">
				<xsl:with-param name="ms_row"       select="$last_ip_row + position()"/>
				<xsl:with-param name="m_name"       select="@MEMNAME"/>
				<xsl:with-param name="m_type"       select="@MEMTYPE"/>
				<xsl:with-param name="c_name"       select="$mc_name"/>
				<xsl:with-param name="c_type"       select="$mc_type"/>
				<xsl:with-param name="is_ext"       select="$is_ext"/>
				<xsl:with-param name="mshp_stroke"  select="$BLKD_COL_OPBBUS"/>
			</xsl:call-template>
			
		</xsl:for-each>
		
	</symbol>	
	
	
    <symbol id="opb_IP_Block">
		<use  x="0"  y="{ceiling($opb_IP_Bg_H div 2) + $BUS_CON_H}"  xlink:href="#IPIO_Connector"/>	
		<use  y="0"  x="{ceiling($opb_IP_Bg_W div 2) + $IO_CON_W}"   xlink:href="#IPOPB_Connector"/>	
		
		<use  x="{$IO_CON_W}"  
			  y="{$BUS_CON_H}" xlink:href="#opb_IP_DrawArea"/>	
	</symbol>	
<!-- =================================END OPB DEFINITIONS =========================================== -->	

<!-- ================================= PLB DEFINITIONS =========================================== -->	

	<xsl:variable name="plb_IP_CNT"     select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and (@BUSDOMAIN_IS_PLB='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>
	<xsl:variable name="plb_MSHP_CNT"   select="count(RENDERINFO/MEMSHAPE[(@BUSDOMAIN_IS_PLB='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>

	<xsl:variable name="plb_IP_BlkComp_H">
		<xsl:call-template name="Calc_IPBlk_H">
			<xsl:with-param name="ip_cnt"   select="$plb_IP_CNT"/>
			<xsl:with-param name="ms_cnt"   select="$plb_MSHP_CNT"/>
		</xsl:call-template>
	</xsl:variable>  
	
	<xsl:variable name="plb_IP_Bg_H" select="($plb_IP_BlkComp_H - $PLB_CON_H)"/>  
	
	<xsl:variable name="plb_IP_Bg_W">
		
		<xsl:variable name="ip_per_row_">
			<xsl:if test="$plb_IP_CNT &gt;= $IP_PER_ROW">
				<xsl:value-of select="$IP_PER_ROW"/>
			</xsl:if>
			<xsl:if test="not($plb_IP_CNT &gt;= $IP_PER_ROW)">
				2
			</xsl:if>
		</xsl:variable>
		
		<xsl:if test="($plb_IP_CNT &gt; 0)">
			<xsl:value-of select="($ip_per_row_ * ($IP_H_GAP + $IP_W)) + $IP_H_GAP"/>
		</xsl:if>
		<xsl:if test="not($plb_IP_CNT &gt; 0)">
			<xsl:value-of select="$plb_IP_CNT"/>
		</xsl:if>
	</xsl:variable>  
	
	<symbol id="plb_IP_Bg" overflow="visible">
		<rect x="0" 
			  y="0" 
			  rx="10" 
			  ry="10" 
			  width="{ $plb_IP_Bg_W}" 
			  height="{$plb_IP_Bg_H}" 
			  style="fill:{$IP_COL_PLBBG};stroke:none;stroke-width:3;opacity:0.5"/>
	</symbol>

	<xsl:call-template name="Layout_BusNorthArrowDef">
		<xsl:with-param name="bus_col"     select="$BLKD_COL_PLBBUS"/>
		<xsl:with-param name="bus_type"    select="'PLB'"/>
		<xsl:with-param name="bus_arrow_w" select="$IP_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$IP_ARROW_H"/>	
	</xsl:call-template>	
	
	<symbol id="IPPLB_ArrowSouth">
		<use   x="0"   y="0"  xlink:href="#IPPLB_ArrowNorth" transform="scale(1,-1) translate(0,-8)"/>
	</symbol>

	<xsl:call-template name="Layout_BUSConnectorDef">
		<xsl:with-param name="bus_col"      select="$BLKD_COL_PLBBUS"/>
		<xsl:with-param name="bus_type"     select="'PLB'"/>
		<xsl:with-param name="bus_arrow_h"  select="$IP_ARROW_H"/>
		<xsl:with-param name="bus_arrow_w"  select="$IP_ARROW_W"/>
		<xsl:with-param name="bus_hconne_l" select="$IPOPB_HCONNE_L"/>	
	</xsl:call-template>	

	<symbol id="plb_IP_DrawArea">
		
		<use  x="0"  y="0"  xlink:href="#plb_IP_Bg"/>
		
		<xsl:for-each select="MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and @BUSDOMAIN_IS_PLB='TRUE']">
			
			<xsl:call-template name="Layout_IPDef">
				<xsl:with-param name="ip_pos"  select="position()"/>
				<xsl:with-param name="ip_name" select="@INSTANCE"/>
				<xsl:with-param name="ip_type" select="@MODTYPE"/>
			</xsl:call-template>
			
		</xsl:for-each>
		
		<xsl:variable name="last_ip_row" select="ceiling(($plb_IP_CNT div $IP_PER_ROW))"/>
		
		<xsl:for-each select="RENDERINFO/MEMSHAPE[@BUSDOMAIN_IS_PLB='TRUE' and not(@BUSDOMAIN_IS_MUL)]">
			
			<xsl:variable name="is_ext">
				<xsl:if test="(@EXT_MEMORY='TRUE')">1</xsl:if>
				<xsl:if test="not(@EXT_MEMORY='TRUE')">0</xsl:if>
			</xsl:variable>
			
<!--			
			<EXM><xsl:value-of select="$is_ext"/></EXM>
-->	

		   <xsl:variable name="c_name_">
				<xsl:if test="@DCNAME"><xsl:value-of select="@DCNAME"/></xsl:if>
				<xsl:if test="@ICNAME"><xsl:value-of select="@ICNAME"/></xsl:if>
		   </xsl:variable>
		   
		   <xsl:variable name="c_type_">
				<xsl:if test="@DCTYPE"><xsl:value-of select="@DCTYPE"/></xsl:if>
				<xsl:if test="@ICTYPE"><xsl:value-of select="@ICTYPE"/></xsl:if>
		   </xsl:variable>
			
			<xsl:call-template name="Layout_MSHPDef">
				<xsl:with-param name="ms_row"       select="$last_ip_row + position()"/>
				<xsl:with-param name="m_name"       select="@MEMNAME"/>
				<xsl:with-param name="m_type"       select="@MEMTYPE"/>
				<xsl:with-param name="c_name"       select="$c_name_"/>
				<xsl:with-param name="c_type"       select="$c_type_"/>
				<xsl:with-param name="is_ext"       select="$is_ext"/>
				<xsl:with-param name="mshp_stroke"  select="$BLKD_COL_PLBBUS"/>
			</xsl:call-template>
			
		</xsl:for-each>
		
	</symbol>	
	
	
    <symbol id="plb_IP_Block">
		<use  x="0"  y="{ceiling($plb_IP_Bg_H div 2) + $PLB_CON_H}"  xlink:href="#IPIO_Connector"/>	
		<use  y="0"  x="{ceiling($plb_IP_Bg_W div 2) + $IO_CON_W}"   xlink:href="#IPPLB_Connector"/>	
		
		<use  x="{$IO_CON_W}"  
			  y="{$PLB_CON_H}" xlink:href="#plb_IP_DrawArea"/>	
	</symbol>	
<!-- =================================END PLB DEFINITIONS =========================================== -->	
	

<!-- ================================= IP (NOT BUS) DEFINITIONS ========================================= -->	
	<xsl:variable name="nobus_IP_CNT"     select="count(MHSINFO/MODULES/MODULE[@MODCLASS='IP'])"/>

	<xsl:variable name="nobus_IP_BlkComp_H">
		<xsl:call-template name="Calc_IPBlk_H">
			<xsl:with-param name="ip_cnt"   select="$nobus_IP_CNT"/>
		</xsl:call-template>
	</xsl:variable>  
	
	<xsl:variable name="nobus_IP_Bg_H" select="($nobus_IP_BlkComp_H - $BUS_CON_H)"/>  
	
	<xsl:variable name="nobus_IP_Bg_W">
		
		<xsl:variable name="ip_per_row_">
			<xsl:if test="$nobus_IP_CNT &gt;= $IP_PER_ROW"><xsl:value-of select="$IP_PER_ROW"/></xsl:if>
			<xsl:if test="not($nobus_IP_CNT &gt;= $IP_PER_ROW)">2</xsl:if>
		</xsl:variable>
		
		<xsl:if test="($nobus_IP_CNT &gt; 0)">
			<xsl:value-of select="($ip_per_row_ * ($IP_H_GAP + $IP_W)) + $IP_H_GAP"/>
		</xsl:if>
		<xsl:if test="not($nobus_IP_CNT &gt; 0)">
			<xsl:value-of select="$nobus_IP_CNT"/>
		</xsl:if>
		
	</xsl:variable>  
	
	<symbol id="nobus_IP_Bg" overflow="visible">
		<rect x="0" 
			  y="0" 
			  rx="10" 
			  ry="10"
			  width="{ $nobus_IP_Bg_W}" 
			  height="{$nobus_IP_Bg_H}" 
			  style="fill:{$BLKD_COL_WHITE};stroke:none;stroke-width:3;opacity:0.5"/>
	</symbol>

<!--
	<uxsl:call-template name="nameLayout_BusNorthArrowDef">
		<xsl:with-param name="bus_col"     select="$BLKD_COL_OPBBUS"/>
		<xsl:with-param name="bus_type"    select="'NOBUS'"/>
		<xsl:with-param name="bus_arrow_w" select="$IP_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$IP_ARROW_H"/>	
	</xsl:call-template>	
	
	<symbol id="IPNOBUS_ArrowSouth">
		<use   x="0"   y="0"  xlink:href="#IPNOBUS_ArrowNorth" transform="scale(1,-1) translate(0,{$IP_ARROW_H * -1})"/>
	</symbol>

	<xsl:call-template name="Layout_BUSConnectorDef">
		<xsl:with-param name="bus_col"      select="$BLKD_COL_IORING"/>
		<xsl:with-param name="bus_type"     select="'IO'"/>
		<xsl:with-param name="bus_arrow_h"  select="$IP_ARROW_H"/>
		<xsl:with-param name="bus_arrow_w"  select="$IP_ARROW_W"/>
		<xsl:with-param name="bus_hconne_l" select="$IPOPB_HCONNE_L"/>	
	</xsl:call-template>	/ICONu/
-->	

	<symbol id="nobus_IP_DrawArea">
		
		<use  x="0"  y="0"  xlink:href="#nobus_IP_Bg"/>
		
		<xsl:for-each select="MHSINFO/MODULES/MODULE[@MODCLASS='IP']">
			
			<xsl:call-template name="Layout_IPDef">
				<xsl:with-param name="ip_pos"  select="position()"/>
				<xsl:with-param name="ip_name" select="@INSTANCE"/>
				<xsl:with-param name="ip_type" select="@MODTYPE"/>
			</xsl:call-template>
			
		</xsl:for-each>
		
	</symbol>	
	
    <symbol id="nobus_IP_Block">
		
		<use  x="0"  
			  y="0" xlink:href="#nobus_IP_DrawArea"/>	
			  
		<use  x="{ceiling($nobus_IP_Bg_W div 2)}" 
			  y="{$nobus_IP_Bg_H}"  
			  xlink:href="#IPIO_Connector" transform="rotate(90,{ceiling($nobus_IP_Bg_W div 2)},{$nobus_IP_Bg_H})"/>	
		
	</symbol>	
	
<!-- =================================END IP (NON BUS) DEFINITIONS =========================================== -->	

<!-- ================================= FSL DEFINITIONS =========================================== -->	

	<xsl:variable name="fsl_IP_CNT"    select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and (@BUSDOMAIN_IS_FSL='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>
	<xsl:variable name="fsl_BIF_CNT"   select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PROCESSOR']/BUSINTERFACE[@BUSDOMAIN ='FSL'])"/>
	<xsl:variable name="fsl_MSHP_CNT"  select="count(RENDERINFO/MEMSHAPE[(@BUSDOMAIN_IS_FSL='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>

<!--
	<xsl:call-template name="Test_FslIPBlk_H">
		<xsl:with-param name="ip_cnt"   select="$fsl_IP_CNT"/>
		<xsl:with-param name="bif_cnt"   select="$fsl_BIF_CNT"/>
	</xsl:call-template>
-->	
	
	<xsl:variable name="fsl_IP_BlkComp_H">
		<xsl:call-template name="Calc_FslIPBlk_H">
			<xsl:with-param name="ip_cnt"   select="$fsl_IP_CNT"/>
			<xsl:with-param name="bif_cnt"   select="$fsl_BIF_CNT"/>
		</xsl:call-template>
	</xsl:variable>  
	
	<xsl:variable name="fsl_IP_Bg_H" select="($fsl_IP_BlkComp_H - $BUS_CON_H)"/>  
	
	<xsl:variable name="fsl_IP_Bg_W">
		
		<xsl:variable name="ip_per_row_">
			<xsl:if test="$fsl_IP_CNT &gt;= $IP_PER_ROW">
				<xsl:value-of select="$IP_PER_ROW"/>
			</xsl:if>
			<xsl:if test="not($fsl_IP_CNT &gt;= $IP_PER_ROW)">2</xsl:if>
		</xsl:variable>
		
		<xsl:if test="($fsl_IP_CNT &gt; 0)">
			<xsl:value-of select="($ip_per_row_ * ($IP_H_GAP + $IP_W)) + $IP_H_GAP"/>
		</xsl:if>
		<xsl:if test="not($fsl_IP_CNT &gt; 0)">
			<xsl:value-of select="$fsl_IP_CNT"/>
		</xsl:if>
	</xsl:variable>  
	
	<symbol id="fsl_IP_Bg" overflow="visible">
		<rect x="0" 
			  y="0" 
			  rx="10" 
			  ry="10"
			  width="{ $fsl_IP_Bg_W}" 
			  height="{$fsl_IP_Bg_H}" 
			  style="fill:{$IP_COL_FSLBG};stroke:none;stroke-width:3;opacity:0.5"/>
	</symbol>

<!--
	<xsl:call-template name="Layout_BusNorthArrowDef">
		<xsl:with-param name="bus_col"     select="$BLKD_COL_FSLBUS"/>
		<xsl:with-param name="bus_type"    select="'OPB'"/>
		<xsl:with-param name="bus_arrow_w" select="$IP_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$IP_ARROW_H"/>	
	</xsl:call-template>	
	
	<symbol id="IPOPB_ArrowSouth">
		<use   x="0"   y="0"  xlink:href="#IPOPB_ArrowNorth" transform="scale(1,-1) translate(0,{$IP_ARROW_H * -1})"/>
	</symbol>

	<xsl:call-template name="Layout_BUSConnectorDef">
		<xsl:with-param name="bus_col"      select="$BLKD_COL_OPBBUS"/>
		<xsl:with-param name="bus_type"     select="'OPB'"/>
		<xsl:with-param name="bus_arrow_h"  select="$IP_ARROW_H"/>
		<xsl:with-param name="bus_arrow_w"  select="$IP_ARROW_W"/>
		<xsl:with-param name="bus_hconne_l" select="$IPOPB_HCONNE_L"/>	
	</xsl:call-template>	
-->
	<symbol id="fsl_IP_DrawArea">
		
		<use  x="0"  y="0"  xlink:href="#fsl_IP_Bg"/>
		
		<xsl:for-each select="MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and @BUSDOMAIN_IS_FSL='TRUE']">
			
			<xsl:call-template name="Layout_IPDef">
				<xsl:with-param name="ip_pos"  select="position()"/>
				<xsl:with-param name="ip_name" select="@INSTANCE"/>
				<xsl:with-param name="ip_type" select="@MODTYPE"/>
			</xsl:call-template>
			
		</xsl:for-each>
		
		<xsl:variable name="last_ip_row" select="ceiling(($fsl_IP_CNT div $IP_PER_ROW))"/>
		
<!--		
		<xsl:for-each select="RENDERINFO/MEMSHAPE[@BUSDOMAIN_IS_OPB='TRUE' and not(@BUSDOMAIN_IS_MUL)]">
			
			<xsl:variable name="mc_name">
				<xsl:choose>
					<xsl:when test="@DCNAME and not(@DCNAME='')">
					<xsl:value-of select="@DCNAME"/>
					</xsl:when>
				<xsl:when test="@ICNAME and not(@ICNAME='')">
					<xsl:value-of select="@ICNAME"/>
				</xsl:when>
				<xsl:otherwise>
					UNKNOWN	NAME
				</xsl:otherwise>
				</xsl:choose>				
				
			</xsl:variable>
			
			<xsl:variable name="mc_type">
				
				<xsl:choose>
					<xsl:when test="@DCTYPE and not(@DCTYPE='')">
						<xsl:value-of select="@DCTYPE"/>
					</xsl:when>
				
					<xsl:when test="@ICTYPE and not(@ICTYPE='')">
						<xsl:value-of select="@ICTYPE"/>
					</xsl:when>
					<xsl:otherwise>
						UNKNOWN	TYPE
					</xsl:otherwise>
				</xsl:choose>	
				
			</xsl:variable>
			
			<xsl:variable name="is_ext">
				<xsl:if test="(@EXT_MEMORY='TRUE')">1</xsl:if>
				<xsl:if test="not(@EXT_MEMORY='TRUE')">0</xsl:if>
			</xsl:variable>
			
			<xsl:call-template name="Layout_MSHPDef">
				<xsl:with-param name="ms_row"       select="$last_ip_row + position()"/>
				<xsl:with-param name="m_name"       select="@MEMNAME"/>
				<xsl:with-param name="m_type"       select="@MEMTYPE"/>
				<xsl:with-param name="c_name"       select="$mc_name"/>
				<xsl:with-param name="c_type"       select="$mc_type"/>
				<xsl:with-param name="is_ext"       select="$is_ext"/>
				<xsl:with-param name="mshp_stroke"  select="$BLKD_COL_OPBBUS"/>
			</xsl:call-template>
			
		</xsl:for-each>
-->	
		
	</symbol>	
	
    <symbol id="fsl_IP_Block">
<!--		
		<use  x="0"  y="{ceiling($opb_IP_Bg_H div 2) + $BUS_CON_H}"  xlink:href="#IPIO_Connector"/>	
		<use  y="0"  x="{ceiling($opb_IP_Bg_W div 2) + $IO_CON_W}"   xlink:href="#IPOPB_Connector"/>	
-->	
		
		<use  x="0"  
			  y="0" xlink:href="#fsl_IP_DrawArea"/>	
	</symbol>	
<!-- =================================END FSL DEFINITIONS =========================================== -->	


</xsl:template>
<!-- ===================================== END DEFINITIONS =========================================== -->	



<!-- ================================= GENERAL FUNCTIONS ============================================ -->	
<xsl:template name="Layout_IPDef"> 
	<xsl:param name="ip_pos"  select="1"/>
	<xsl:param name="ip_name" select="name"/>
	<xsl:param name="ip_type" select="type"/>

	<xsl:variable name="ip_col">
		<xsl:if test="(($ip_pos &gt; $IP_PER_ROW) or ($ip_pos &lt; $IP_PER_ROW))">
			<xsl:value-of select="($ip_pos mod $IP_PER_ROW)"/>
		</xsl:if>
		<xsl:if test="not($ip_pos mod $IP_PER_ROW)">
			<xsl:value-of select="$IP_PER_ROW"/>
		</xsl:if>
	</xsl:variable>
	
	<xsl:variable name="ip_row" select="ceiling(($ip_pos div $IP_PER_ROW))"/>
	
	<xsl:call-template name="Layout_IPDefParts">
		<xsl:with-param name="ip_x_pos" select="(($IP_H_GAP * $ip_col) + (($ip_col - 1) * $IP_W))"/>
		<xsl:with-param name="ip_y_pos" select="(($IP_V_GAP * $ip_row) + (($ip_row - 1) * $IP_H))"/>
		<xsl:with-param name="i_name" select="$ip_name"/>
		<xsl:with-param name="i_type" select="$ip_type"/>
	</xsl:call-template>
	
</xsl:template>

<xsl:template name="Layout_IPDefParts">
	<xsl:param name="ip_x_pos" select="100"/>
	<xsl:param name="ip_y_pos" select="100"/>
	<xsl:param name="i_name" select="$ip_name"/>
	<xsl:param name="i_type" select="$ip_type"/>
	
	<rect  x="{$ip_x_pos}"  
		   y="{$ip_y_pos}"
		   rx="3" ry="3" 
		   width ="{$IP_W}" 
		   height="{$IP_H}" style="fill:{$IP_COL_BLKBG}; fill-opacity: 0.8; stroke: rgb(0,0,0); stroke-width:1"/> 
		   
    <image x="{$ip_x_pos + ceiling(($IP_W div 2)) -16}" 
		   y="{$ip_y_pos + 16}" 
		   width="32" height="32" xlink:href="ICON_Peri.gif"/> 
    
	<text class="iptype"
		  x="{$ip_x_pos + ceiling($IP_W div 2)}" 
		  y="{$ip_y_pos + 10}">
			<xsl:value-of select="$i_type"/>
	</text>
	
	<text class="iplabel"
		  x="{$ip_x_pos + ceiling($IP_W div 2)}" 
		  y="{($ip_y_pos + $IP_H) - 6}">
			<xsl:value-of select="$i_name"/>
	</text>
	
</xsl:template>


<xsl:template name="Layout_MSHPDef"> 
	
	<xsl:param name="ms_row"       select="1"/>
	<xsl:param name="m_name"       select="name"/>
	<xsl:param name="m_type"       select="type"/>
	<xsl:param name="c_name"       select="name"/>
	<xsl:param name="c_type"       select="type"/>
	<xsl:param name="is_ext"       select="0"/>
	<xsl:param name="mshp_stroke"  select="$BLKD_COL_OPBBUS"/>
	
<!--
	<xsl:variable name="ms_col">
		<xsl:if test="(($ms_pos &gt; $IP_PER_ROW) or ($ms_pos &lt; $IP_PER_ROW))">
			<xsl:value-of select="($ms_pos mod $IP_PER_ROW)"/>
		</xsl:if>
		
		<xsl:if test="not($ms_pos mod $IP_PER_ROW)">
			<xsl:value-of select="$IP_PER_ROW"/>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="ms_row" select="ceiling(($ms_pos div $IP_PER_ROW))"/>
	<xsl:variable name="ms_row" select="ceiling(($ms_pos div $IP_PER_ROW))"/>
-->	

	<xsl:variable name="ms_col">1</xsl:variable>
	
	<xsl:call-template name="Layout_MSHPDefParts">
		<xsl:with-param name="ms_x_pos"     select="(($IP_H_GAP * $ms_col) + (($ms_col - 1) * $IP_W))"/>
		<xsl:with-param name="ms_y_pos"     select="(($IP_V_GAP * $ms_row) + (($ms_row - 1) * $IP_H))"/>
		<xsl:with-param name="m_name"       select="$m_name"/>
		<xsl:with-param name="m_type"       select="$m_type"/>
		<xsl:with-param name="c_name"       select="$c_name"/>
		<xsl:with-param name="c_type"       select="$c_type"/>
		<xsl:with-param name="is_ext"       select="$is_ext"/>
		<xsl:with-param name="mshp_stroke"  select="$mshp_stroke"/>
	</xsl:call-template>
	
</xsl:template>

<xsl:template name="Layout_MSHPDefParts">
	<xsl:param name="ms_x_pos"    select="10"/>
	<xsl:param name="ms_y_pos"    select="10"/>
	<xsl:param name="m_name"      select="memName"/>
	<xsl:param name="m_type"      select="memType"/>
	<xsl:param name="c_name"      select="DataName"/>
	<xsl:param name="c_type"      select="DataType"/>
	<xsl:param name="is_ext"      select="0"/>
	<xsl:param name="mshp_stroke" select="$BLKD_COL_OPBBUS"/>
	
<!--	
	<EXM><xsl:value-of select="$is_ext"/></EXM>
-->	
	
	<rect  x="{$ms_x_pos}"  
		   y="{$ms_y_pos}"
		   rx="3" ry="3" 
		   width ="{($IP_W * 2) + $IP_H_GAP}" 
		   height="{$IP_H}" style="fill:{$IP_COL_BLKBG}; fill-opacity: 1.0; stroke:{$mshp_stroke}; stroke-width:2"/> 
		   
    <image x="{$ms_x_pos + ceiling(($IP_W div 2)) - 16}" 
		   y="{$ms_y_pos + 16}" 
		   width="32" height="32" xlink:href="ICON_MemCntlr.gif"/> 
    
	<text class="iptype"
		  x="{$ms_x_pos + ceiling($IP_W div 2)}" 
		  y="{$ms_y_pos + 10}">
			<xsl:value-of select="$c_type"/>
	</text>
	
	<text class="iplabel"
		  x="{ $ms_x_pos + ceiling($IP_W div 2)}" 
		  y="{($ms_y_pos + $IP_H) - 6}">
			<xsl:value-of select="$c_name"/>
	</text>
		
	<xsl:if test="$is_ext = 0">	
		<image x="{$ms_x_pos + ($IP_W + $IP_H_GAP) + ceiling(($IP_W div 2)) - 16}" 
		       y="{$ms_y_pos + 16}" 
		   width="32" height="32" xlink:href="ICON_BRam.gif"/> 
	</xsl:if> 
	
	<xsl:if test="$is_ext = 1">	
		<image x="{$ms_x_pos + ($IP_W + $IP_H_GAP) + ceiling(($IP_W div 2)) - 16}" 
		       y="{$ms_y_pos + 16}" 
		   width="32" height="32" xlink:href="ICON_ExtMem.gif"/> 
	</xsl:if> 
	
	<text class="iptype"
		  x="{$ms_x_pos + ($IP_W + $IP_H_GAP)  + ceiling($IP_W div 2)}" 
		  y="{$ms_y_pos + 10}">
			<xsl:value-of select="$m_type"/>
	</text>
	
	<text class="iplabel"
		  x="{ $ms_x_pos + ($IP_W + $IP_H_GAP) + ceiling($IP_W div 2)}" 
		  y="{($ms_y_pos + $IP_H) - 6}">
			<xsl:value-of select="$m_name"/>
	</text>
	
</xsl:template>
	
<xsl:template name="Layout_BusNorthArrowDef">
	<xsl:param name="bus_col"     select="'OPB'"/>
	<xsl:param name="bus_type"    select="'OPB'"/>
	<xsl:param name="bus_arrow_w" select="20"/>
	<xsl:param name="bus_arrow_h" select="20"/>	
	
	 <symbol id="IP{$bus_type}_ArrowNorth">
		<path class="bus"
			  d="M   {ceiling($bus_arrow_w div 2)},0
				 L   {$bus_arrow_h}, {$bus_arrow_w}
				 L   0,{$bus_arrow_h}, 
				 Z" style="stroke:none; fill:{$bus_col}"/>
	</symbol>
</xsl:template>

<xsl:template name="Layout_BUSConnectorDef">
	<xsl:param name="bus_col"      select="$BLKD_COL_OPBBUS"/>
	<xsl:param name="bus_type"     select="'OPB'"/>
	<xsl:param name="bus_arrow_h"  select="20"/>
	<xsl:param name="bus_arrow_w"  select="20"/>
	<xsl:param name="bus_hconne_l" select="20"/>	
	
	 <symbol id="IP{$bus_type}_Connector">
		<use   x="0" y="0" xlink:href="#IP{$bus_type}_ArrowNorth"/>
		<use   x="0" y="{$bus_arrow_h + $bus_hconne_l}"  xlink:href="#IP{$bus_type}_ArrowSouth"/>
		<rect  x="3" y="{$bus_arrow_h}" width="2" height="{$bus_hconne_l}" style="fill:{$bus_col};"/> 
		<text class="buslabel" x="32" y="{ceiling($BUS_CON_H div 2)}"><xsl:value-of select="$bus_type"/>  BUS</text>
		<text class="buslabel" x="44" y="{ceiling($BUS_CON_H div 2) + 16}">INTERFACES</text>
	 </symbol>	
</xsl:template>
	
	
<!-- =================================  SIZE CALCULATING FUNCTIONS  ======================================= -->	
<xsl:template name="Calc_IPDrawArea_H">
	<xsl:param name="ipcnt" select="1"/>	
	<xsl:param name="mscnt" select="0"/>	
	
	<xsl:variable name = "nIpRows">
		<xsl:if test="($ipcnt &gt; 0)">
			<xsl:value-of select="ceiling(($ipcnt div $IP_PER_ROW))"/>
		</xsl:if>
		<xsl:if test="not($ipcnt &gt; 0)">
			<xsl:value-of select="$ipcnt"/>
		</xsl:if>
	</xsl:variable> 	
	
	<xsl:variable name = "nMsRows" select="$mscnt"/>
		
<!--			
		<xsl:if test="($mscnt_ &gt; 0)">
			<xsl:value-of select="ceiling((($mscnt_ * 2) div $IP_PER_ROW))"/>
		</xsl:if>
		<xsl:if test="not($mscnt_ &gt; 0)">
			<xsl:value-of select="$mscnt_"/>
		</xsl:if>
	<xsl:value-of select="(($nIpRows + nMsRows) * ($IP_V_GAP + $IP_H)) + $IP_V_GAP"/>	
		<xsl:value-of select="(ceiling(($ipcnt_ div $IP_PER_ROW)) * ($IP_V_GAP + $IP_H)) + $IP_V_GAP"/>	
		<xsl:value-of select="(ceiling((($nIpRows + $mscnt_) div $IP_PER_ROW)) * ($IP_V_GAP + $IP_H)) + $IP_V_GAP"/>	
-->
	<xsl:value-of select="(($nIpRows + $nMsRows) * ($IP_V_GAP + $IP_H)) + $IP_V_GAP"/>	
	
</xsl:template>

<xsl:template name="Calc_IPBlk_H">
	<xsl:param name="ip_cnt"  select="0"/>	
	<xsl:param name="ms_cnt"  select="0"/>	
	
	<xsl:variable name="ip_drwar_h_">
		<xsl:call-template name="Calc_IPDrawArea_H">
			<xsl:with-param name="ipcnt" select="$ip_cnt"/>	
			<xsl:with-param name="mscnt" select="$ms_cnt"/>	
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:choose>
		<xsl:when test="($ip_drwar_h_ > 0)">
			<xsl:value-of select="($ip_drwar_h_ + $BUS_CON_H)"/>
		</xsl:when>
		
		<xsl:otherwise>
			<xsl:value-of select="$ip_drwar_h_"/>
		</xsl:otherwise>
	</xsl:choose>
		
</xsl:template>

<xsl:template name="Calc_FslIPBlk_H">
	<xsl:param name="ip_cnt"   select="0"/>	
	<xsl:param name="bif_cnt"  select="0"/>	
	
	<xsl:variable name="ip_defdrwar_h_">
		<xsl:call-template name="Calc_IPDrawArea_H">
			<xsl:with-param name="ipcnt" select="$ip_cnt"/>	
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="fsl_drwar_h_">
		<xsl:choose>
			<xsl:when test="($bif_cnt &gt; 0)">
				<xsl:value-of select="(($PROC_BANK_MID_H + $PROC_BANK_GAP) * ($bif_cnt + 1))"/>
			</xsl:when>
		
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="ip_drwar_h_">
		<xsl:choose>
			<xsl:when test="($ip_defdrwar_h_ &gt; 0)">
				<xsl:value-of select="$ip_defdrwar_h_"/>
			</xsl:when>
		
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:choose>
		<xsl:when test="($ip_drwar_h_ &gt; $fsl_drwar_h_)">
			<xsl:value-of select="$ip_drwar_h_"/>
		</xsl:when>
		
		<xsl:otherwise><xsl:value-of select="$fsl_drwar_h_"/></xsl:otherwise>
	</xsl:choose>
		
</xsl:template>



<xsl:template name="Test_FslIPBlk_H">
	<xsl:param name="ip_cnt"  select="0"/>	
	<xsl:param name="bif_cnt"  select="0"/>	
	
	<xsl:variable name="ip_defdrwar_h_">
		<xsl:call-template name="Calc_IPDrawArea_H">
			<xsl:with-param name="ipcnt" select="$ip_cnt"/>	
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="fsl_drwar_h_" select="(($PROC_BANK_MID_H + $PROC_BANK_GAP) * $ip_cnt)"/>
	
	<TSTFSL><xsl:value-of select="$bif_cnt"/></TSTFSL>
	
	<xsl:variable name="ip_drwar_h_">
		<xsl:choose>
			<xsl:when test="($ip_defdrwar_h_ &gt; 0)">
				<xsl:value-of select="$ip_defdrwar_h_"/>
			</xsl:when>
		
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
</xsl:template>


<xsl:template name="Calc_IPBlk_W">
	<xsl:param name="ip_cnt"  select="0"/>	
	
	<xsl:if test="($ip_cnt &gt; 0)">
		<xsl:value-of select="$IO_CON_W + ($IP_PER_ROW * ($IP_H_GAP + $IP_W)) + $IP_H_GAP + ($IPBG_H_GAP * 2)"/>
	</xsl:if>
	
	<xsl:if test="not($ip_cnt &gt; 0)">
		<xsl:value-of select="$ip_cnt"/>
	</xsl:if>
	
</xsl:template>


<!-- =================================  MASTER LAYOUT FUNCTIONS  ================================== -->	
<xsl:template name="Draw_IPBlocks"> 
	<xsl:param name="x_pos"   select="0"/>
	<xsl:param name="y_pos"   select="0"/>
	<xsl:param name="blkd_w"  select="800"/>
	<xsl:param name="ipblk_h" select="0"/>
	
	<xsl:variable name="opb_ip_c_"    select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and (@BUSDOMAIN_IS_OPB='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>
	<xsl:variable name="plb_ip_c_"    select="count(MHSINFO/MODULES/MODULE[@MODCLASS='PERIPHERAL' and (@BUSDOMAIN_IS_PLB='TRUE' and not(@BUSDOMAIN_IS_MUL))])"/>
	<xsl:variable name="nobus_ip_c_"  select="count(MHSINFO/MODULES/MODULE[@MODCLASS='IP'])"/>
	
	<xsl:variable name="opb_blks_exist_">
		<xsl:if test="opb_ip_c_ &gt; 0">1</xsl:if>	
		<xsl:if test="not(opb_ip_c_ &gt; 0)">0</xsl:if>	
	</xsl:variable>
	
	<xsl:variable name="opb_blk_w_">
		<xsl:call-template  name="Calc_IPBlk_W">
			<xsl:with-param name="ip_cnt"  select="$opb_ip_c_"/>	
		</xsl:call-template>
	</xsl:variable>
			
	<xsl:variable name="opb_x_pos_">
		<xsl:value-of select="$IPBG_H_GAP + $x_pos"/>	
	</xsl:variable>
	
	<xsl:variable name="plb_x_pos_">
		<xsl:value-of select="$opb_x_pos_ + $opb_blk_w_ + ($opb_blks_exist_ * $IPBG_H_GAP)"/>	
	</xsl:variable>
	
<!--	  THE OPB IP BLOCK -->
	<xsl:if test="$opb_ip_c_ &gt; 0">
		<use  x="{$opb_x_pos_}"  y="{$y_pos}"   xlink:href="#opb_IP_Block"/>	
	</xsl:if>		
		
<!--	  THE PLB IP BLOCK -->
	<xsl:if test="$plb_ip_c_ &gt; 0">
		<use  x="{$plb_x_pos_}"  y="{$y_pos}"   xlink:href="#plb_IP_Block"/>	
	</xsl:if>		
	
	
<!--	  THE NON BUS CONNECTED IP BLOCK -->
	<xsl:variable name="nobus_w_">
		<xsl:call-template name="Calc_IPBlk_W">
			<xsl:with-param name="ip_cnt" select="$nobus_ip_c_"/>	
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="nobus_y_pos_">
		<xsl:value-of select="$y_pos + $ipblk_h + $IPBG_H_GAP"/>
	</xsl:variable>
	
	<xsl:variable name="nobus_x_pos_">
		<xsl:value-of select="ceiling($blkd_w div 2) - ceiling($nobus_w_ div 2)"/>	
	</xsl:variable>
		
	<xsl:if test="$nobus_ip_c_ &gt; 0">
		<use  x="{$nobus_x_pos_}"  y="{$nobus_y_pos_}"  xlink:href="#nobus_IP_Block"/>	
	</xsl:if>		
	
</xsl:template>

</xsl:stylesheet>
